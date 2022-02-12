//
//  ContentView.swift
//  Shared
//
//  Created by Darrell Root on 2/3/22.
//

import SwiftUI

struct ContentView: View {
    //@ObservedObject var model: Model
    @EnvironmentObject private var store: Store

    var body: some View {
        NavigationView {
            List {
                Section("Preliminary Drills") {
                    NavigationLink("1-Digit Hexadecimal and Binary Drills", destination: OneDigitNumberDrillsView())
                    NavigationLink("2-Digit Hexadecimal and Binary Drills", destination: TwoDigitNumberDrillsView())
                    NavigationLink("IPv4 Terminology Drills", destination: IPv4TerminologyDrillsView())
                }
                Section("Administrative") {
                    NavigationLink("Purchase full unlock",destination: PurchaseView())
                }
            }
            
            .navigationTitle("CIDR Trainer")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
