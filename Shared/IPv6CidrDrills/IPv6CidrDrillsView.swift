//
//  IPv6CidrDrillsView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/26/22.
//

import SwiftUI

struct IPv6CidrDrillsView: View {
    var body: some View {
        List {
            Section("IPv6 CIDR Drills") {
                NavigationLink("IPv6 Address Types", destination: IPv6AddressTypesView())

            }
        }
    }
}

struct IPv6CidrDrillsView_Previews: PreviewProvider {
    static var previews: some View {
        IPv6CidrDrillsView()
    }
}
