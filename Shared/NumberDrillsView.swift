//
//  NumberDrillsView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/3/22.
//

import SwiftUI

struct NumberDrillsView: View {
    var body: some View {
        List {
            NavigationLink("1-digit hexadecimal -> Decimal drill", destination: OneDigitHex2DecimalView())
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NumberDrillsView_Previews: PreviewProvider {
    static var previews: some View {
        NumberDrillsView()
    }
}
