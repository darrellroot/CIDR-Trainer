//
//  PurchaseView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/6/22.
//

import SwiftUI
import StoreKit

struct PurchaseView: View {
    @EnvironmentObject private var store: Store
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

 
    var productDescription: String {
        guard let product = store.product(for: Store.fullUnlockIdentifier) else {
            return "Unable to purchase CIDR Trainer at this time"
        }
        
        return "\(product.localizedTitle): \(product.localizedDescription) for \(Locale.current.currencySymbol ?? "")\(Double(truncating: product.price).formatted(.currency(code: Locale.current.identifier)))"
    }

    var body: some View {
        VStack {
            Spacer()
            switch coreSettings.first?.fullUnlock ?? false {
            case true:
                Text("You already fully unlocked CIDR Trainer!")
                    .font(.title)
                Spacer()
                Text("Thank you!")
                    .font(.title)
            case false:
                Text("Each subnetting drill may only be used \(Globals.freeSampleNumber) times.  You may go back and try another drill, or purchase CIDR Trainer")
                Spacer()
                Button("\(productDescription)") {
                    if let product = store.product(for: Store.fullUnlockIdentifier) {
                        store.purchaseProduct(product)
                    } else {
                        print("Cannot identify product \(Store.fullUnlockIdentifier) in store")
                    }
                }.buttonStyle(.borderedProminent)
                Spacer()
                Button("Click here to restore a prior CIDR Trainer purchase") {
                    store.restorePurchases()
                }.buttonStyle(.borderedProminent)
            }
            Spacer()
        }
        .padding([.leading,.trailing])
        .navigationTitle("Purchase CIDR Trainer")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}
