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
        return Button {
            function(key)
        } label: {
            switch key {
            case .DEL,.ENTER:
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(maxWidth: .infinity)
                        //.aspectRatio(2,contentMode: .fit)
                        .foregroundColor(Color.gray)

                    switch key {
                    case .DEL:
                        Image(systemName: "delete.left")
                    case .ENTER:
                        Image(systemName: "arrow.up")
                    default:
                        fatalError("Unexpected case")
                    }
                }
                //.padding()
                //.frame(maxWidth: .infinity)
                .aspectRatio(3,contentMode: .fit)
            default:
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(maxWidth: .infinity)
                        .aspectRatio(aspectRatio,contentMode: .fit)
                        .foregroundColor(Color.gray)
                    Text(key.description)
                }
                 
            }
        }.font(.title)
        .background(Color.gray)
            //.padding(5)
    }
}

/*struct SingleDigitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SingleDigitButtonView(character: "3",input: .constant(""))
    }
}*/
