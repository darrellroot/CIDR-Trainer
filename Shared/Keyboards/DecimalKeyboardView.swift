//
//  DecimalKeyboardView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/3/22.
//

import SwiftUI

struct DecimalKeyboardView: View {
    @Binding var input: String
    let submit: () -> ()

    func buttonPress(_ key: Keypress) -> Void {
        switch key {
        case .one,.two,.three,.four,.five,.six,.seven,.eight,.nine,.zero:
            input += key.description
        case .DEL:
            if !input.isEmpty {
                input.removeLast()
            }
        case .ENTER:
            submit()
        case .a, .b, .c, .d, .e, .f:
            fatalError("DecimalKeyboard invalid button rpess \(key)")
        case .zeroBinary,.oneBinary,.twoBinary,.threeBinary,.fourBinary,.fiveBinary,.sixBinary,.sevenBinary,.eightBinary,.nineBinary,.tenBinary,.elevenBinary,.twelveBinary,.thirteenBinary,.fourteenBinary, .fifteenBinary:
            fatalError("BinaryKeyboard invalid button rpess \(key)")

        }
        
    }
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                ForEach(1..<4) { digit in
                    SingleDigitButtonView(key: Keypress(digit),function: buttonPress)
                }
            }
            HStack {
                ForEach(4..<7) { digit in
                    SingleDigitButtonView(key: Keypress(digit),function: buttonPress)

                }
            }
            HStack {
                ForEach(7..<10) { digit in
                    SingleDigitButtonView(key: Keypress(digit),function: buttonPress)

                }
            }
            HStack {
                SingleDigitButtonView(key: .ENTER,function: buttonPress)
                SingleDigitButtonView(key: Keypress(0),function: buttonPress)


                SingleDigitButtonView(key: .DEL,function: buttonPress)

            }
        }.font(.title)
    }
}

struct DecimalKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        DecimalKeyboardView(input: .constant(""),submit: {})
    }
}
