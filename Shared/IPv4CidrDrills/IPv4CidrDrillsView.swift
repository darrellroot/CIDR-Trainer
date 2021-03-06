//
//  IPv4CidrDrillsView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/17/22.
//

import SwiftUI

struct IPv4CidrDrillsView: View {
    var body: some View {
        List {
            Section("IPv4 CIDR Drills") {
                NavigationLink("Number of IPs in a CIDR", destination: IPv4NumberIpsCidrView())
                NavigationLink("Number of usable unicast IPs in a CIDR", destination: IPv4NumberUsableIpsCidrView())
                NavigationLink("CIDR to Network Address in binary", destination: IPv4Cidr2NetworkHardView())
                NavigationLink("CIDR to Network Address in decimal", destination: IPv4Cidr2NetworkDecimalView())
                NavigationLink("Well-formed CIDR to Broadcast Address", destination: IPv4Cidr2BroadcastView())
                NavigationLink("Well-formed CIDR to First Usable IP Address", destination: IPv4Cidr2FirstUsableView())
                NavigationLink("Well-formed CIDR to Last Usable IP Address", destination: IPv4Cidr2LastUsableView())
            }
        }
        .navigationTitle("IPv4 CIDR Drills")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct IPv4CidrDrillsView_Previews: PreviewProvider {
    static var previews: some View {
        IPv4CidrDrillsView()
    }
}
