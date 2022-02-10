//
//  OneDigitDecimal2HexView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/4/22.
//

import SwiftUI
import CoreData

struct OneDigitDecimal2HexView: View, DrillHelper {
    
    @FetchRequest(fetchRequest: Games.oneDigitDecimal2Hex.fetchRequest) var coreGames
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

    func wrongAnswer(_ answer: String) {
        withAnimation {
            lastCorrect = false
        }
        coreGames.first?.wrong()
        
        lastResult = "Incorrect: \(given) in hex is \(givenHex) not 0x\(answer)"
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
        coreGames.first?.correct()
        lastResult = "Correct: \(given) in hex is \(givenHex)"
        displayCheck = true
        withAnimation {
            displayCheck = false
        }
        newQuestion()
    }
    func submit() {
        guard let answer = Int(input, radix: 16) else {
            wrongAnswer(input)
            return
        }
        if answer == given {
            correctAnswer()
            return
        } else {
            wrongAnswer(input)
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
                            Text("Recent \(Globals.lastSize) score: \(coreGames.first?.last100correct ?? -1) correct \(coreGames.first?.last100wrong ?? -1) wrong")
                            Text("All time score: \(coreGames.first?.correctTotal ?? -1) out of \((coreGames.first?.correctTotal ?? -1) + (coreGames.first?.wrongTotal ?? -1))")
                        }
                        Section("Next Task") {
                            Text("Convert \(given) to Hex")
                            Text(input)
                        }
                        .foregroundColor(Color.accentColor)

                    }
                    Spacer()
                    HexKeyboardView(input: $input,submit: submit)
                }.onDisappear {
                    do {
                        try moc.save()
                        print("Saved core data context")
                    } catch {
                        print("Failed to save core data context \(error.localizedDescription)")
                    }
                }//main vstack
                Image(systemName: (lastCorrect ? "checkmark" : "x.circle")).font(.system(size: 150)).opacity(displayCheck ? 0.4 : 0.0)
            }// zstack

            .navigationTitle("1 Digit Decimal -> Hex")
            .navigationBarTitleDisplayMode(.inline)
        }// if else
    }
}


struct OneDigitDecimal2HexView_Previews: PreviewProvider {
    static var previews: some View {
        OneDigitDecimal2HexView()
    }
}
