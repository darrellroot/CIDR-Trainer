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

    @State var alertMessage: String = ""
    @State var showAlert: Bool = false
    var productDescription: String {
        guard let product = store.product(for: Store.fullUnlockIdentifier) else {
            return "Unable to purchase CIDR Trainer at this time"
        }
        
        return "\(product.displayName): \(product.description) for \(product.displayPrice)"
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
                Text("Each subnetting drill may only be used for free \(Globals.freeSampleNumber) times.  You may go back and try another drill, or purchase CIDR Trainer")
                Spacer()
                Button("\(productDescription)") {
                    if let product = store.product(for: Store.fullUnlockIdentifier) {
                        Task {
                            do {
                                try await _ = store.purchase(product)
                            } catch {
                                alertMessage = "Error while attempting to purchase \(product.displayName): \(error.localizedDescription)"
                            }
                        }
                    } else {
                        alertMessage = "Error: cannot identify product \(Store.fullUnlockIdentifier) in store"
                        showAlert = true
                    }
                }.buttonStyle(.borderedProminent)
                Spacer()
                Button("Click here to restore a prior CIDR Trainer purchase") {
                    Task {
                        do {
                            try await store.restorePurchases()
                        } catch {
                            alertMessage = "Error while attempting to restore prior purchases: \(error)"
                            showAlert = true
                            
                        }
                    }
                }.buttonStyle(.borderedProminent)
            }
            Spacer()
        }
        .padding([.leading,.trailing])
        .navigationTitle("Purchase CIDR Trainer")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertMessage, isPresented: $showAlert) {}

    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}
