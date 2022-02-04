//
//  OneDigitHex2DecimalView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/3/22.
//

import SwiftUI

struct OneDigitHex2DecimalView: View {
    @State var input = ""
    var body: some View {
        Spacer()
        DecimalKeyboardView(input: $input)
    }
}

struct OneDigitHex2DecimalView_Previews: PreviewProvider {
    static var previews: some View {
        OneDigitHex2DecimalView()
    }
}
