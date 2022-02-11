//
//  RecentScoreView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI
import CoreData

struct RecentScoreView: View {
    @FetchRequest var coreGames: FetchedResults<CoreGame>
    var thisGame: CoreGame? {
        return coreGames.first
    }
    
    init(nsFetchRequest: NSFetchRequest<CoreGame>) {
        let fetchRequest = FetchRequest(fetchRequest: nsFetchRequest)
        _coreGames = fetchRequest
    }
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
            Text("Recent Score:  ") // 15 chars to align (sorta) with all-time score
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
