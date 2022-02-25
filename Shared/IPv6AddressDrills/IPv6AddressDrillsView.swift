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


            }
        }
    }
}

struct IPv6AddressDrillsView_Previews: PreviewProvider {
    static var previews: some View {
        IPv6AddressDrillsView()
    }
}
