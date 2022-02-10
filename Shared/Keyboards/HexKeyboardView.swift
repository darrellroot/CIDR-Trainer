//
//  HexKeyboardView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/4/22.
//

import SwiftUI

struct HexKeyboardView: View {
    @Binding var input: String
    let submit: () -> ()
    
    func buttonPress(_ key: Keypress) -> Void {
        switch key {
        case .one,.two,.three,.four,.five,.six,.seven,.eight,.nine,.zero,.a,.b,.c,.d,.e,.f:
            input += key.description
        case .DEL:
            if !input.isEmpty {
                input.removeLast()
            }
        case .ENTER:
            submit()
        case .zeroBinary,.oneBinary,.twoBinary,.threeBinary,.fourBinary,.fiveBinary,.sixBinary,.sevenBinary,.eightBinary,.nineBinary,.tenBinary,.elevenBinary,.twelveBinary,.thirteenBinary,.fourteenBinary, .fifteenBinary:
            fatalError("BinaryKeyboard invalid button rpess \(key)")
        }
    }
    
    var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: 5) {
                ForEach(0..<4) { digit in
                    SingleDigitButtonView(key: Keypress(digit),function: buttonPress)
                }
            }
            HStack(spacing: 5) {
                ForEach(4..<8) { digit in
                    SingleDigitButtonView(key: Keypress(digit),function: buttonPress)
                }
            }
            HStack(spacing: 5) {
                ForEach(8..<12) { digit in
                    SingleDigitButtonView(key: Keypress(digit),function: buttonPress)
                }
            }
            HStack(spacing: 5) {
                ForEach(12..<16) { digit in
                    SingleDigitButtonView(key: Keypress(digit),function: buttonPress)
                }
            }
            HStack(spacing: 5) {
                SingleDigitButtonView(key: .ENTER,function: buttonPress,aspectRatio: 4)
                SingleDigitButtonView(key: .DEL,function: buttonPress, aspectRatio: 4)
            }
        }.font(.title)
    }
}

struct HexKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        HexKeyboardView(input: .constant(""),submit: {})
    }
}
