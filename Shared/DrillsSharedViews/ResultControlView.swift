//
//  ResultControlView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/18/22.
//

import SwiftUI

struct ResultControlView: View {
    @Binding var displayScore: Bool
    var body: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .top) {
                Toggle("", isOn: $displayScore).padding(.trailing)
            }
            Spacer()
        }
    }
}

struct ResultControlView_Previews: PreviewProvider {
    static var previews: some View {
        ResultControlView(displayScore: .constant(true))
    }
}
