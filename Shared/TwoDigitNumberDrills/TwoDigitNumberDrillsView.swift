//
//  TwoDigitNumberDrillsView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/11/22.
//

import SwiftUI

struct TwoDigitNumberDrillsView: View {
    var body: some View {
        List {
            Section("Two digit conversions") {
                NavigationLink("2-digit hexadecimal -> decimal (easy)", destination: TwoDigitHex2DecimalEasyView())
                NavigationLink("Decimal -> 2-digit hexadecimal (easy)", destination: TwoDigitDecimal2HexEasyView())
                NavigationLink("2-digit hexadecimal -> binary", destination: TwoDigitHex2BinaryView())
                NavigationLink("Binary -> 2-digit hexadecimal", destination: TwoDigitBinary2HexView())
                NavigationLink("2-digit hexadecimal to decimal", destination: TwoDigitHex2DecimalView())
                NavigationLink("Decimal -> 2-digit hexadecimal", destination: TwoDigitDecimal2HexView())
                NavigationLink("8-digit binary -> decimal (hard)", destination: TwoDigitBinary2DecimalView())
                NavigationLink("Decimal -> 8-digit binary (hard)", destination: TwoDigitDecimal2BinaryView())
                NavigationLink("8 Bit AND", destination: EightBitAndView())


            }
        }
        .navigationTitle("2-Digit Hex and Binary Drills")
        .navigationBarTitleDisplayMode(.inline)

    }
}

struct TwoDigitNumberDrillsView_Previews: PreviewProvider {
    static var previews: some View {
        TwoDigitNumberDrillsView()
    }
}
