//
//  IPv4PrefixLengthDrillsView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/17/22.
//

import SwiftUI

struct IPv4PrefixLengthDrillsView: View {
    var body: some View {
        List {
            Section("IPv4 Prefix Length Drills") {
                NavigationLink("IPv4 Prefix Length to Binary Netmask", destination: IPv4Prefix2BinaryNetmaskView())
                NavigationLink("IPv4 Binary Netmask to Prefix Length", destination: IPv4BinaryNetmask2PrefixLengthView())
            }
        }
        .navigationBarTitle("IPv4 Prefix Length Drills")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct IPv4PrefixLengthDrillsView_Previews: PreviewProvider {
    static var previews: some View {
        IPv4PrefixLengthDrillsView()
    }
}
