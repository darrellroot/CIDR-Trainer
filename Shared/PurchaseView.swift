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
            Text("\(coreSettings.first != nil ? "Fetched coreSettings successfully!" : "unable to fetch coreSettings")")
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
            }
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}
