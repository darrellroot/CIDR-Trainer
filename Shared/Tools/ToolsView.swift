//
//  ToolsView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/22/22.
//

import SwiftUI

struct ToolsView: View {
    var body: some View {
        List {
            Section("CIDR Calculators") {
                NavigationLink("IPv4 CIDR Calculator", destination: IPv4CidrCalculatorView())
                NavigationLink("IPv6 CIDR Calculator", destination: IPv6CidrCalculatorView())

            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("Network Tools")
    }
}

struct ToolsView_Previews: PreviewProvider {
    static var previews: some View {
        ToolsView()
    }
}
