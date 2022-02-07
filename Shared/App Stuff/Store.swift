//
//  Store.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/6/22.
// Using code from https://iosexample.com/apples-framework-to-support-in-app-purchases-and-interaction-with-the-app-store/

import Foundation
import StoreKit
import SwiftUI
import CoreData

typealias FetchCompletionHandler = (([SKProduct]) -> Void)
typealias PurchaseCompletionHandler = ((SKPaymentTransaction?) -> Void)

class Store: NSObject, ObservableObject {
    //@FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    var moc: NSManagedObjectContext
    var coreSetting: CoreSettings?
    
    // String is product identifer
    @Published var purchasedProducts: Set<String> = []
    // String is product identifier
    @Published var allProducts: Dictionary<String,SKProduct> = [:]
    
    var nonPurchasedProducts: [String] {
        var productList: Set<String> = Set(allProducts.keys)
        for purchasedProduct in purchasedProducts {
            productList.remove(purchasedProduct)
        }
        return productList.sorted()
    }
#if DEBUG
    let certificate = "StoreKitTestCertificate"
#else
    let certificate = "AppleIncRootCertificate"
#endif
    
    private var productsRequest: SKProductsRequest?
    //private var fetchedProducts = [SKProduct]()
    private var fetchCompletionHandler: FetchCompletionHandler? // fetch product
    private var purchaseCompletionHandler: PurchaseCompletionHandler?
    
    static let fullUnlockIdentifier = "net.networkmom.CIDRTrainer.FullUnlock"
    private let allProductIdentifiers = Set([Store.fullUnlockIdentifier])
    
    /*private var completedPurchases = [String]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
            }
        }
    }*/
    
    init(moc: NSManagedObjectContext) {
        self.moc = moc
        super.init()
        print("Store init")
        if let coreSettings = try? moc.fetch(CoreSettings.fetchRequest()) {
            self.coreSetting = coreSettings.first
        }
        startObservingPaymentQueue()
        fetchProducts { products in
            print("found \(products.count) existing products from store")
            for product in products {
                print("\(product.productIdentifier) exists")
                self.allProducts[product.productIdentifier] = product
            }
        }
    }
    
    private func startObservingPaymentQueue() {
        SKPaymentQueue.default().add(self)
    }
    
    private func fetchProducts(_ completion: @escaping FetchCompletionHandler) {
        print("trying to fetch products from store")
        guard self.productsRequest == nil else { return }
        productsRequest = SKProductsRequest(productIdentifiers: allProductIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    private func buy(_ product: SKProduct, completion: @escaping PurchaseCompletionHandler) {
        purchaseCompletionHandler = completion
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
}

extension Store {
    func product(for identifier: String) -> SKProduct? {
        return allProducts[identifier]
    }
    func purchaseProduct(_ product: SKProduct) {
        startObservingPaymentQueue()
        buy(product) { _ in
            
        }
    }
}

extension Store: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            var shouldFinishTransaction = false
            switch transaction.transactionState {
            case .purchased, .restored:
                print("We purchased or restored \(transaction.payment.productIdentifier)")
                purchasedProducts.insert(transaction.payment.productIdentifier)
                if transaction.payment.productIdentifier == Store.fullUnlockIdentifier {
                    if let coreSetting = coreSetting {
                        coreSetting.setFullUnlock(true)
                    } else {
                        print("Error: cannot fetch Core Settings to execute full unlock")
                    }
                } else {
                    print("Error: purchased or restored unexpected product identifier: \(transaction.payment.productIdentifier)")
                }
            case .failed:
                shouldFinishTransaction = true
            case .deferred, .purchasing:
                break
            @unknown default:
                break
            }
            
            if shouldFinishTransaction {
                SKPaymentQueue.default().finishTransaction(transaction)
                DispatchQueue.main.async { [weak self] in
                    self?.purchaseCompletionHandler?(transaction)
                    self?.purchaseCompletionHandler = nil
                }
            }
        }
    }
}

extension Store: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let loadedProducts = response.products
        print("got \(loadedProducts.count) store products response")

        let invalidProducts = response.invalidProductIdentifiers
        guard !loadedProducts.isEmpty else {
            print("Could not load the products from store!")
            if !invalidProducts.isEmpty {
                print("Invalid Products found: \(invalidProducts)")
            }
            productsRequest = nil
            return
        }
        // cache fetched products
        for product in loadedProducts {
            allProducts[product.productIdentifier] = product
        }
        
        // notify anyone waiting on the product load
        DispatchQueue.main.async { [weak self] in
            self?.fetchCompletionHandler?(loadedProducts)
            self?.fetchCompletionHandler = nil
            self?.productsRequest = nil
        }
    }
}

