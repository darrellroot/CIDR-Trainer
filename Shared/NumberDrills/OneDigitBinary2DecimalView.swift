//
//  OneDigitBinary2DecimalView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/11/22.
//

import SwiftUI

struct OneDigitBinary2DecimalView: View, DrillHelper {
    static let staticFetchRequest = Games.oneDigitBinary2Decimal.fetchRequest
    let fetchRequest = staticFetchRequest
    @FetchRequest(fetchRequest: staticFetchRequest) var coreGames

    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    @State var input = ""
    @State var given: Int = Int.random(in: 0..<16)
    @State var lastResult = "Press your answer and hit the up arrow"
    @State var lastCorrect = true
    @State var displayCheck = false

    func wrongAnswer() {
        withAnimation {
            lastCorrect = false
        }
        thisGame?.wrong()
        lastResult = "Incorrect:  0b\(given.binary4) is \(given) in Decimal not \(input)"

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
        lastResult = "Correct: 0b\(given.binary4) is \(input) in Decimal"
        displayCheck = true
        withAnimation {
            displayCheck = false
        }
        newQuestion()
    }
    
    func submit() {
        guard let answer = Int(input) else {
            wrongAnswer()
            return
        }
        if answer == given {
            correctAnswer()
            return
        } else {
            wrongAnswer()
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
                            RecentScoreView(nsFetchRequest: fetchRequest)
                            AllTimeScoreView(nsFetchRequest: fetchRequest)
                        }
                        Section("Next Task") {
                            Text("Convert \(given.binary4) to Decimal")
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
            .navigationTitle("4-digit Binary -> Decimal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Help", destination: OneDigitBinaryHelp())
                }
            }
        }//if else
    }
}

struct OneDigitBinary2DecimalView_Previews: PreviewProvider {
    static var previews: some View {
        OneDigitBinary2DecimalView()
    }
}
