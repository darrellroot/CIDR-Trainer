//
//  Store.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/6/22.
// Using code from https://iosexample.com/apples-framework-to-support-in-app-purchases-and-interaction-with-the-app-store/

import Foundation
import StoreKit
import SwiftUI

typealias FetchCompletionHandler = (([SKProduct]) -> Void)
typealias PurchaseCompletionHandler = ((SKPaymentTransaction?) -> Void)

class Store: NSObject, ObservableObject {
    
    //@Published var purchasedProductNames: Set<String> = []
    //@Published var allProductNames: Set<String> = []
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
    
    private var productsRequest: SKProductsRequest?
    private var fetchedProducts = [SKProduct]()
    private var fetchCompletionHandler: FetchCompletionHandler? // fetch product
    private var purchaseCompletionHandler: PurchaseCompletionHandler?
    
    private let allProductIdentifiers = Set(["net.networkmom.CIDRTrainer.FullUnlock"])
    
    /*private var completedPurchases = [String]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
            }
        }
    }*/
    
    override init() {
        super.init()
        print("Store init")
        startObservingPaymentQueue()
        fetchProducts { products in
            print("found \(products.count) existing products")
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
        guard self.productsRequest == nil else { return }
        productsRequest = SKProductsRequest(productIdentifiers: allProductIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
}

extension Store: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            var shouldFinishTransaction = false
            switch transaction.transactionState {
            case .purchased:
                print("We purchased \(transaction.payment.productIdentifier)")
                purchasedProducts.insert(transaction.payment.productIdentifier)
            case .restored:
                print("We restored \(transaction.payment.productIdentifier)")
                purchasedProducts.insert(transaction.payment.productIdentifier)
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
        let invalidProducts = response.invalidProductIdentifiers
        guard !loadedProducts.isEmpty else {
            print("Could not load the products!")
            if !invalidProducts.isEmpty {
                print("Invalid Products found: \(invalidProducts)")
            }
            productsRequest = nil
            return
        }
        // cache fetched products
        fetchedProducts = loadedProducts
        
        // notify anyone waiting on the product load
        DispatchQueue.main.async { [weak self] in
            self?.fetchCompletionHandler?(loadedProducts)
            self?.fetchCompletionHandler = nil
            self?.productsRequest = nil
        }
    }
}

