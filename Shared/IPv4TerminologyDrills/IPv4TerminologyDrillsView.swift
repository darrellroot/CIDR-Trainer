//
//  IPv4TerminologyDrillsView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/11/22.
//

import SwiftUI

struct IPv4TerminologyDrillsView: View {
    var body: some View {
        List {
            Section("IPv4 Basics") {
                NavigationLink("Valid IPv4 Addresses", destination: ValidIPv4AddressesView())
                NavigationLink("IPv4 Address Types", destination: IPv4AddressTypesView())


            }
        }
        .navigationBarTitle("IPv4 Terminology Drills")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct IPv4TerminologyDrillsView_Previews: PreviewProvider {
    static var previews: some View {
        IPv4TerminologyDrillsView()
    }
}
