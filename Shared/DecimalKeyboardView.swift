//
//  DecimalKeyboardView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/3/22.
//

import SwiftUI

struct DecimalKeyboardView: View {
    @Binding var input: String
    
    func buttonPress(_ key: Keypress) -> Void {
        switch key {
        case .one,.two,.three,.four,.five,.six,.seven,.eight,.nine,.zero:
            input += key.description
        case .DEL:
            if !input.isEmpty {
                input.removeLast()
            }
        

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
                SingleDigitButtonView(key: Keypress(0),function: buttonPress)


                SingleDigitButtonView(key: .DEL,function: buttonPress)

            }
        }
    }
}

struct DecimalKeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        DecimalKeyboardView(input: .constant(""))
    }
}
