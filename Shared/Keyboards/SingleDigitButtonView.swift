//
//  SingleDigitButtonView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/3/22.
//
// some input from https://stackoverflow.com/questions/70808514/swiftui-how-to-display-a-keyboard-with-numpad-in-the-side

import SwiftUI

struct SingleDigitButtonView: View {
    let key: Keypress
    let function: (Keypress) -> ()
    var aspectRatio: CGFloat = 3
    var body: some View {
        Button {
            function(key)
        } label: {
            switch key {
            case .DEL:
                Image(systemName: "delete.left")
                    .frame(maxWidth: .infinity)
            case.ENTER:
                Image(systemName: "arrow.up")
                    .frame(maxWidth: .infinity)
            default:
                Text(key.description)
                    .frame(maxWidth: .infinity)
            }
        }
        .buttonStyle(.bordered)

    }
}

/*struct SingleDigitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SingleDigitButtonView(character: "3",input: .constant(""))
    }
}*/
