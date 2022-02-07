//
//  PurchaseView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/6/22.
//

import SwiftUI

struct PurchaseView: View {
    @EnvironmentObject private var store: Store
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings


    var body: some View {
        List {
            switch coreSettings.first?.fullUnlock ?? false {
            case true:
                Text("You already fully unlocked CIDR Trainer!")
            case false:
                Button("Click here to purchase CIDR Trainer") {
                    if let product = store.product(for: Store.fullUnlockIdentifier) {
                        store.purchaseProduct(product)
                    } else {
                        print("Cannot identify product \(Store.fullUnlockIdentifier) in store")
                    }
                }
                Button("Click here to attempt to restore a prior CIDR Trainer purchase") {
                    
                }
            }
            /*Text("\(coreSettings.first != nil ? "Fetched coreSettings successfully!" : "unable to fetch coreSettings")")
            Text("Full unlock setting: \(coreSettings.first?.fullUnlock ?? false ? "true" : "false")")
            Section("Non-purchased products") {
                
                ForEach(store.nonPurchasedProducts, id: \.self) { productDescription in
                    Text(productDescription)
                }
            }
            Section("Purchased Products") {
                ForEach(store.purchasedProducts.sorted(), id: \.self) { product in
                    Text(product)
                }
            }*/
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}
