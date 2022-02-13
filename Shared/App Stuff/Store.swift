//
//  Store.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/6/22.

import Foundation
import StoreKit
import SwiftUI
import CoreData

typealias Transaction = StoreKit.Transaction

public enum StoreError: Error {
    case failedVerification
    case didNotFindPurchaseToRestore
}

class Store: NSObject, ObservableObject {
    //@FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    var moc: NSManagedObjectContext
    var coreSetting: CoreSettings?
    
    // String is product identifer
    var purchasedProducts: Set<String> = []
    // String is product identifier
    var allProducts: Dictionary<String,Product> = [:]
    
#if DEBUG
    let certificate = "StoreKitTestCertificate"
#else
    let certificate = "AppleIncRootCertificate"
#endif
        
    static let fullUnlockIdentifier = "net.networkmom.CIDRTrainer.FullUnlock"
    
    var updateListenerTask: Task<Void, Error>? = nil
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
        super.init()
        print("Store init")
        if let coreSettings = try? moc.fetch(CoreSettings.fetchRequest()) {
            self.coreSetting = coreSettings.first
        }
        //Start a transaction listener as close to app launch as possible so you don't miss any transactions.
        updateListenerTask = listenForTransactions()

        Task {
            //Initialize the store by starting a product request.
            await requestProducts()
        }
    }
    
    func requestProducts() async {
        do {
            let products = try await Product.products(for: [Store.fullUnlockIdentifier])
            print("found \(products.count) existing products from store")
            for product in products {
                print("\(product.id) exists")
                self.allProducts[product.id] = product
            }
        } catch {
            print("Store.requestProducts: error \(error) detected while downloading products")
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
    
    func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            //Iterate through any transactions which didn't come from a direct call to `purchase()`.
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)

                    //Deliver content to the user.
                    await self.updatePurchasedIdentifiers(transaction)

                    //Always finish a transaction.
                    await transaction.finish()
                } catch {
                    //StoreKit has a receipt it can read but it failed verification. Don't deliver content to the user.
                    print("Transaction failed verification")
                }
            }
        }
    }

    func updatePurchasedIdentifiers(_ transaction: Transaction) async {
        self.purchasedProducts.insert(transaction.productID)
        if transaction.productID == Store.fullUnlockIdentifier {
            if let coreSetting = coreSetting {
                coreSetting.setFullUnlock(true)
                print("purchased or restored \(transaction.id)")
                await transaction.finish()
            } else {
                print("Error: cannot fetch Core Settings to execute full unlock")
            }
        } else {
            print("Error: purchased or restored unexpected product identifier: \(transaction.id)")
        }
    }
    
    
}

extension Store {
    func product(for identifier: String) -> Product? {
        return allProducts[identifier]
    }
    
    func purchase(_ product: Product) async throws -> Transaction? {
        //Begin a purchase.
        let result = try await product.purchase()

        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)

            //Deliver content to the user.
            await updatePurchasedIdentifiers(transaction)

            //Always finish a transaction.
            await transaction.finish()

            return transaction
        case .userCancelled, .pending:
            return nil
        default:
            return nil
        }
    }
    
    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        //Check if the transaction passes StoreKit verification.
        switch result {
        case .unverified:
            //StoreKit has parsed the JWS but failed verification. Don't deliver content to the user.
            throw StoreError.failedVerification
        case .verified(let safe):
            //If the transaction is verified, unwrap and return it.
            return safe
        }
    }

    func restorePurchases() async throws {
        print("attempting to restore purchases")
        guard let result = await Transaction.latest(for: Store.fullUnlockIdentifier) else {
            print("\(#file) \(#function): Unable to restore purchase for \(Store.fullUnlockIdentifier)")
            throw StoreError.didNotFindPurchaseToRestore
        }
        let transaction = try checkVerified(result)
        print(transaction)
        if transaction.revocationDate == nil {
            await updatePurchasedIdentifiers(transaction)
        } else {
            throw StoreError.didNotFindPurchaseToRestore
        }
    }
}
