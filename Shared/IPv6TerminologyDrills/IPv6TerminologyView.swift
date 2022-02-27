//
//  IPv6CidrDrillsView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/26/22.
//

import SwiftUI

struct IPv6TerminologyView: View {
    var body: some View {
        List {
            Section("IPv6 Terminology Drills") {
                NavigationLink("IPv6 Address Types", destination: IPv6AddressTypesView())
                NavigationLink("Valid IPv6 Hextets", destination: ValidIPv6HextetView())
                NavigationLink("Valid IPv6 Addresses", destination: ValidIPv6AddressView())

            }
        }
        .navigationTitle("IPv6 Terminology")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct IPv6TerminologyView_Previews: PreviewProvider {
    static var previews: some View {
        IPv6TerminologyView()
    }
}
