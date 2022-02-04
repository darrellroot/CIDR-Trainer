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
    var body: some View {
        return Button {
            function(key)
        } label: {
            switch key {
            case .DEL,.ENTER:
                ZStack {
                    Text(" ") //makes box same size as text buttons
                    switch key {
                    case .DEL:
                        Image(systemName: "delete.left")
                    case .ENTER:
                        Image(systemName: "arrow.up")
                    default:
                        fatalError("Unexpected case")
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .aspectRatio(2,contentMode: .fit)
            default:
                Text(key.description)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .aspectRatio(2,contentMode: .fit)
            }
        }.font(.title)
        .background(Color.gray)
            .padding(5)
    }
}

/*struct SingleDigitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SingleDigitButtonView(character: "3",input: .constant(""))
    }
}*/
