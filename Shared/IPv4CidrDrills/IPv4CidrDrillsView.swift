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
            }
        }
    }
}

struct IPv4CidrDrillsView_Previews: PreviewProvider {
    static var previews: some View {
        IPv4CidrDrillsView()
    }
}
