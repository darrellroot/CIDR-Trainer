//
//  AllTimeScoreView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct AllTimeScoreView: View {
    var thisGame: CoreGame?
    
    var allTimeCorrect: String {
        if let thisGame = thisGame {
            return "\(thisGame.correctTotal)"
        } else {
            return "??"
        }
    }
    var allTimeWrong: String {
        if let thisGame = thisGame {
            return "\(thisGame.wrongTotal)"
        } else {
            return "??"
        }
    }
    var body: some View {
        HStack {
            Text("All-Time Score:")
            Label(allTimeCorrect , systemImage: SFSymbol.checkmark.rawValue)
            Spacer()
            Label(allTimeWrong, systemImage: SFSymbol.xCircle.rawValue)
        }
    }
}

struct AllTimeScoreView_Previews: PreviewProvider {
    static var previews: some View {
        AllTimeScoreView()
    }
}
