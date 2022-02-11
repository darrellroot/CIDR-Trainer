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
            Section("One digit conversions") {
                NavigationLink("1-digit hex -> decimal", destination: OneDigitHex2DecimalView())
                NavigationLink("1-digit decimal -> hex", destination: OneDigitDecimal2HexView())
                NavigationLink("1-digit hex -> binary", destination: OneDigitHex2BinaryView())
                NavigationLink("Binary -> 1-digit hex", destination: OneDigitBinary2HexView())
                NavigationLink("4-digit Binary -> decimal", destination: OneDigitBinary2DecimalView())
                NavigationLink("Decimal -> 4-digit binary", destination: OneDigitDecimal2BinaryView())
            }
            Section("Two digit conversions") {
                
            }


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
