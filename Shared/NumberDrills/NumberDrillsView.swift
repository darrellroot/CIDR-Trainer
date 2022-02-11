//
//  NumberDrillsView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/3/22.
//

import SwiftUI

struct NumberDrillsView: View {
    //@ObservedObject var model: Model
    var body: some View {
        List {
            NavigationLink("1-digit hex -> decimal", destination: OneDigitHex2DecimalView())
            NavigationLink("1-digit decimal -> hex", destination: OneDigitDecimal2HexView())
            NavigationLink("1-digit hex -> binary", destination: OneDigitHex2BinaryView())
            NavigationLink("Binary -> 1-digit hex", destination: OneDigitBinary2HexView())
            NavigationLink("4-digit Binary -> Decimal", destination: OneDigitBinary2DecimalView())


        }
        .navigationTitle("Hex and Binary Drills")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NumberDrillsView_Previews: PreviewProvider {
    static var previews: some View {
        NumberDrillsView()
    }
}
