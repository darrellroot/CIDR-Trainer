//
//  OneDigitHex2DecimalView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/3/22.
//

import SwiftUI
import CoreData

struct OneDigitHex2DecimalView: View, DrillHelper {
    
    @FetchRequest(fetchRequest: Games.oneDigitHex2Decimal.fetchRequest) var coreGames
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    @State var input = ""
    @State var given: Int = Int.random(in: 0..<16)
    @State var lastResult = "Press your answer and hit the up arrow"
    @State var lastCorrect = true
    @State var displayCheck = false
    
    var givenHex: String {
        return String(format: "0x%X",given)
    }
    
    func wrongAnswer(_ answer: Int?) {
        withAnimation {
            lastCorrect = false
        }
        thisGame?.wrong()
        if let answer = answer {
            lastResult = "Incorrect: \(givenHex) in decimal is \(given) not \(answer)"
        } else {
            lastResult = "Incorrect: \(givenHex) in decimal is \(given)"
        }
        displayCheck = true
        withAnimation {
            displayCheck = false
        }
        newQuestion()
    }
    func correctAnswer() {
        
        withAnimation {
            lastCorrect = true
        }
        thisGame?.correct()
        lastResult = "Correct: \(givenHex) in hex is \(given)"
        displayCheck = true
        withAnimation {
            displayCheck = false
        }
        newQuestion()
    }
    func submit() {
        guard let answer = Int(input) else {
            wrongAnswer(nil)
            return
        }
        if answer == given {
            correctAnswer()
            return
        } else {
            wrongAnswer(answer)
            return
        }
    }
    func newQuestion() {
        // Prevent same question repeatedly
        let oldTarget = given
        repeat {
            given = Int.random(in: 0..<16)
        } while given == oldTarget
        input = ""
    }
    var body: some View {
        if displayPurchaseView {
            PurchaseView()
        } else {
            ZStack {
                VStack {
                    List {
                        Section("Results") {
                            Text("\(lastResult)")
                                .foregroundColor(lastCorrect ? Color.green : Color.red)
                                .fontWeight(.bold)
                            //-1 means error getting core data
                            RecentScoreView(thisGame: thisGame)
                            //Text("Recent \(Globals.lastSize) score: \(thisGame?.last100correct ?? -1) \(SFSymbol.checkmark) \(thisGame?.last100wrong ?? -1) \(SFSymbol.xCircle)")
                            AllTimeScoreView(thisGame: thisGame)

                            //Text("All time score: \(thisGame?.correctTotal ?? -1) \(SFSymbol.checkmark) \(thisGame?.wrongTotal ?? 0) \(SFSymbol.xCircle)")
                        }
                        Section("Next Task") {
                            Text("Convert \(givenHex) to Decimal")
                            Text(input)
                        }
                        .foregroundColor(Color.accentColor)

                    }
                    Spacer()
                    DecimalKeyboardView(input: $input,submit: submit)
                }.onDisappear {
                    do {
                        try moc.save()
                        print("Saved core data context")
                    } catch {
                        print("Failed to save core data context \(error.localizedDescription)")
                    }
                }// main vstack
                (lastCorrect ? SFSymbol.checkmark.image : SFSymbol.xCircle.image)
                    .font(.system(size: 150)).opacity(displayCheck ? 0.4 : 0.0)
            }// zstack
            .navigationTitle("1 Digit Hex -> Decimal")
            .navigationBarTitleDisplayMode(.inline)
        }//if else
    }
}

/*struct OneDigitHex2DecimalView_Previews: PreviewProvider {
    static var previews: some View {
        OneDigitHex2DecimalView(gameScore: GameScore(name: Games.oneDigitHex2Decimal.rawValue))
    }
}*/
