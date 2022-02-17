//
//  BinaryKeyboardView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/9/22.
//

import SwiftUI

struct BinaryKeyboardView: View {
    @Binding var input: String
    let submit: () -> ()
    
    func buttonPress(_ key: Keypress) -> Void {
        switch key {
        case .one,.two,.three,.four,.five,.six,.seven,.eight,.nine,.zero,.a,.b,.c,.d,.e,.f:
            fatalError("BinaryKeyboard invalid button rpess \(key)")

        case .DEL:
            // delete 4 binary characters per delete
            if !input.isEmpty {
                input.removeLast()
            }
            if !input.isEmpty {
                input.removeLast()
            }
            if !input.isEmpty {
                input.removeLast()
            }
            if !input.isEmpty {
                input.removeLast()
            }
        case .ENTER:
            submit()
        case .zeroBinary,.oneBinary,.twoBinary,.threeBinary,.fourBinary,.fiveBinary,.sixBinary,.sevenBinary,.eightBinary,.nineBinary,.tenBinary,.elevenBinary,.twelveBinary,.thirteenBinary,.fourteenBinary, .fifteenBinary,.DOT:
            input += key.description
        }
    }

    var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: 5) {
                SingleDigitButtonView(key: Keypress.zeroBinary,function: buttonPress)
                SingleDigitButtonView(key: Keypress.oneBinary,function: buttonPress)
                SingleDigitButtonView(key: Keypress.twoBinary,function: buttonPress)
                SingleDigitButtonView(key: Keypress.threeBinary,function: buttonPress)
            }
            HStack(spacing: 5) {
                SingleDigitButtonView(key: Keypress.fourBinary,function: buttonPress)
                SingleDigitButtonView(key: Keypress.fiveBinary,function: buttonPress)
                SingleDigitButtonView(key: Keypress.sixBinary,function: buttonPress)
                SingleDigitButtonView(key: Keypress.sevenBinary,function: buttonPress)
            }
            HStack(spacing: 5) {
                SingleDigitButtonView(key: Keypress.eightBinary,function: buttonPress)
                SingleDigitButtonView(key: Keypress.nineBinary,function: buttonPress)
                SingleDigitButtonView(key: Keypress.tenBinary,function: buttonPress)
                SingleDigitButtonView(key: Keypress.elevenBinary,function: buttonPress)
            }
            HStack(spacing: 5) {
                SingleDigitButtonView(key: Keypress.twelveBinary,function: buttonPress)
                SingleDigitButtonView(key: Keypress.thirteenBinary,function: buttonPress)
                SingleDigitButtonView(key: Keypress.fourteenBinary,function: buttonPress)
                SingleDigitButtonView(key: Keypress.fifteenBinary,function: buttonPress)
            }
            HStack(spacing: 5) {
                SingleDigitButtonView(key: .ENTER,function: buttonPress,aspectRatio: 4)
                SingleDigitButtonView(key: .DEL,function: buttonPress, aspectRatio: 4)
            }
        }.font(.body)
    }
}

struct BinaryKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        BinaryKeyboardView(input: .constant(""),submit: {})
    }
}
