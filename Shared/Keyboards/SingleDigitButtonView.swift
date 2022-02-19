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
    let extraVerticalPadding: CGFloat
    
    init(key: Keypress, function: @escaping (Keypress) -> (), aspectRatio: CGFloat) {
        self.init(key: key, function: function)
        self.aspectRatio = aspectRatio
    }
    
    init(key: Keypress, function: @escaping (Keypress) -> ()) {
        self.key = key
        self.function = function
        
        if UIDevice.current.localizedModel == DeviceModel.iPad.rawValue {
            self.extraVerticalPadding = 8
        } else {
            self.extraVerticalPadding = 0
        }
    }
    var body: some View {
        Button {
            function(key)
        } label: {
            switch key {
            case .DEL:
                Image(systemName: "delete.left")
                    .padding([.top,.bottom],extraVerticalPadding)
                    .frame(maxWidth: .infinity)
            case.ENTER:
                Image(systemName: "arrow.up")
                    .padding([.top,.bottom],extraVerticalPadding)
                    .frame(maxWidth: .infinity)
            default:
                Text(key.description)
                    .padding([.top,.bottom],extraVerticalPadding)
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
