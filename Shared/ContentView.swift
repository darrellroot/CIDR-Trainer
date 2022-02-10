//
//  ContentView.swift
//  Shared
//
//  Created by Darrell Root on 2/3/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: Model
    @EnvironmentObject private var store: Store

    var body: some View {
        NavigationView {
            List {
                NavigationLink("Purchase full unlock",destination: PurchaseView())
                NavigationLink("Hexadecimal and Binary Drills", destination: NumberDrillsView(model: model))
            }
            
            .navigationTitle("CIDR Trainer")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: Model())
    }
}
