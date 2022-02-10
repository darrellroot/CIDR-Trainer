//
//  RecentScoreView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct RecentScoreView: View {
    var thisGame: CoreGame?
    
    var recentCorrect: String {
        if let thisGame = thisGame {
            return "\(thisGame.last100correct)"
        } else {
            return "??"
        }
    }
    var recentWrong: String {
        if let thisGame = thisGame {
            return "\(thisGame.last100wrong)"
        } else {
            return "??"
        }
    }
    var body: some View {
        HStack {
            Text("Recent Score:")
            Label(recentCorrect , systemImage: SFSymbol.checkmark.rawValue)
            Spacer()
            Label(recentWrong, systemImage: SFSymbol.xCircle.rawValue)
        }
    }
}

/*struct RecentScoreView_Previews: PreviewProvider {
    static var previews: some View {
        RecentScoreView()
    }
}*/
