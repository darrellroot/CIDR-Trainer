//
//  IPv6AddressDrillsView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/24/22.
//

import SwiftUI

struct IPv6AddressDrillsView: View {
    var body: some View {
        List {
            Section("IPv6 Address Compression") {
                NavigationLink("IPv6 Hextet Shortening", destination: IPv6HextetShorteningView())
                NavigationLink("IPv6 Hextet Lengthening", destination: IPv6HextetLengtheningView())
                NavigationLink("IPv6 Eight Hextet Shortening", destination: IPv6EightHextetShorteningView())
                NavigationLink("IPv6 Eight Hextet Lengthening", destination: IPv6EightHextetLengtheningView())
                NavigationLink("IPv6 Double Colon Shortening", destination: IPv6DoubleColonShorteningView())
                NavigationLink("IPv6 Double Colon Lengthening", destination: IPv6DoubleColonLengtheningView())
                NavigationLink("IPv6 Address Shortening", destination: IPv6AddressShorteningView())
                NavigationLink("IPv6 Address Lengthening", destination: IPv6AddressLengtheningView())
            }
        }
        .navigationTitle("IPv6 Address Compression")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct IPv6AddressDrillsView_Previews: PreviewProvider {
    static var previews: some View {
        IPv6AddressDrillsView()
    }
}
