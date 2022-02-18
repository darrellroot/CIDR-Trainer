//
//  ResultView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/18/22.
//

import SwiftUI
import CoreData

struct ResultView: View {
    @Binding var lastResult: String
    @Binding var lastCorrect: Bool
    var fetchRequest: NSFetchRequest<CoreGame>
    
    var body: some View {
        Section("Results") {
            Text("\(lastResult)")
                .foregroundColor(lastCorrect ? Color.green : Color.red)
                .fontWeight(.bold)
                RecentScoreView(nsFetchRequest: fetchRequest)
                AllTimeScoreView(nsFetchRequest: fetchRequest)
        }
    }
}

/*struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}*/
