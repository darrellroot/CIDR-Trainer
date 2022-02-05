//
//  OneDigitDecimal2HexView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/4/22.
//

import SwiftUI

struct OneDigitDecimal2HexView: View {
    
    @ObservedObject var gameScore: GameScore

    @State var input = ""
    @State var given: Int = Int.random(in: 0..<16)
    @State var lastResult = "Press your answer and hit the up arrow"
    @State var lastCorrect = true

    var givenHex: String {
        return String(format: "0x%X",given)
    }

    func wrongAnswer(_ answer: String) {
        withAnimation {
            lastCorrect = false
        }
        gameScore.wrong()
        lastResult = "Incorrect: \(given) in hex is \(givenHex) not 0x\(answer)"
        newQuestion()
    }
    func correctAnswer() {
        withAnimation {
            lastCorrect = true
        }
        gameScore.correct()
        //let oldGiven = givenw
        //let oldAnswer = targetHex
        lastResult = "Correct: \(given) in hex is \(givenHex)"
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
        VStack(spacing: 10) {
            Spacer()
            List {
                Section("Results") {
                    Text("\(lastResult)")
                        .foregroundColor(lastCorrect ? Color.green : Color.red)
                        .fontWeight(.bold)
                    Text("Recent 100 score: \(gameScore.last100correct) correct \(gameScore.last100wrong) wrong")
                    Text("All time score: \(gameScore.correctTotal) out of \(gameScore.correctTotal + gameScore.wrongTotal)")
                }
                Section("Next Task") {
                    Text("Convert \(given) to Hex")
                    Text(input)
                }
                .foregroundColor(Color.accentColor)

            }
            Spacer()
            HexKeyboardView(input: $input,submit: submit)
        }

        .navigationTitle("1 Digit Decimal -> Hex")
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct OneDigitDecimal2HexView_Previews: PreviewProvider {
    static var previews: some View {
        OneDigitDecimal2HexView(gameScore: GameScore())
    }
}
