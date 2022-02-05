//
//  OneDigitHex2DecimalView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/3/22.
//

import SwiftUI

struct OneDigitHex2DecimalView: View {
    
    @ObservedObject var gameScore: GameScore

    @State var input = ""
    @State var given: Int = Int.random(in: 0..<16)
    @State var lastResult = "Press your answer and hit the up arrow"
    @State var lastCorrect = true
    
    var givenHex: String {
        return String(format: "0x%X",given)
    }

    func wrongAnswer(_ answer: Int?) {
        withAnimation {
            lastCorrect = false
        }
        gameScore.wrong()
        if let answer = answer {
            lastResult = "Incorrect: \(givenHex) in decimal is \(given) not \(answer)"
        } else {
            lastResult = "Incorrect: \(givenHex) in decimal is \(given)"
        }
        newQuestion()
    }
    func correctAnswer() {
        withAnimation {
            lastCorrect = true
        }
        gameScore.correct()
        //let oldGiven = givenw
        //let oldAnswer = targetHex
        lastResult = "Correct: \(givenHex) in hex is \(given)"
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
        VStack(spacing: 10) {
            Spacer()
            List {
                Section("Results") {
                    Text("\(lastResult)")
                        .foregroundColor(lastCorrect ? Color.green : Color.red)
                        .fontWeight(.bold)
                    Text("Recent \(GameScore.lastSize) score: \(gameScore.last100correct) correct \(gameScore.last100wrong) wrong")
                    Text("All time score: \(gameScore.correctTotal) out of \(gameScore.correctTotal + gameScore.wrongTotal)")
                }
                Section("Next Task") {
                    Text("Convert \(givenHex) to Decimal")
                    Text(input)
                }
                .foregroundColor(Color.accentColor)

            }
            Spacer()
            DecimalKeyboardView(input: $input,submit: submit)
        }

        .navigationTitle("1 Digit Hex -> Decimal")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct OneDigitHex2DecimalView_Previews: PreviewProvider {
    static var previews: some View {
        OneDigitHex2DecimalView(gameScore: GameScore(name: Games.oneDigitHex2Decimal.rawValue))
    }
}
