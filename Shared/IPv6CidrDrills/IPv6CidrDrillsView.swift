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
            Section("IPv6 Terminology Drills") {
                NavigationLink("IPv6 CIDR (prefix / 16) drill", destination: IPv6Cidr16DrillView(cidrDivisor: 16))
                NavigationLink("IPv6 CIDR (prefix / 4) drill", destination: IPv6Cidr16DrillView(cidrDivisor: 16))
                NavigationLink("IPv6 CIDR (any prefix) drill", destination: IPv6Cidr16DrillView(cidrDivisor: 1))

            }
        }
    }
}

struct IPv6CidrDrillsView_Previews: PreviewProvider {
    static var previews: some View {
        IPv6TerminologyView()
    }
}
