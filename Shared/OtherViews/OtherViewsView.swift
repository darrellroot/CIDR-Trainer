//
//  OtherViewsView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/19/22.
//

import SwiftUI

struct OtherViewsView: View {
    var body: some View {
        List {
            Section("Other Views") {
                NavigationLink("Purchase full unlock",destination: PurchaseView())
                NavigationLink("Support and Credits",destination: ContactsHelp())
                Button(action: {
                    requestReviewManually()
                }) {
                    Label {
                        Text("Write a review").foregroundColor(.primary)
                    } icon: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .navigationTitle("Other Views")
        .navigationBarTitleDisplayMode(.inline)
    }
    func requestReviewManually() {
        // Note: Replace the XXXXXXXXXX below with the App Store ID for your app
        //       You can find the App Store ID in your app's product URL
        guard let writeReviewURL = URL(string: "https://apps.apple.com/app/id1608806016?action=write-review")
            else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
}

struct OtherViewsView_Previews: PreviewProvider {
    static var previews: some View {
        OtherViewsView()
    }
}
