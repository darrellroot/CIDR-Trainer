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
    @State var target: Int = Int.random(in: 0..<16)
    @State var lastResult = "Press your answer and hit the up arrow"
    @State var lastCorrect = true
    
    var targetHex: String {
        return String(format: "0x%X",target)
    }

    func wrongAnswer() {
        withAnimation {
            lastCorrect = false
        }
        gameScore.wrong()
        let oldTarget = targetHex
        let oldAnswer = target
        lastResult = "Incorrect: \(oldTarget) in decimal is \(oldAnswer)"
        newQuestion()
    }
    func correctAnswer() {
        withAnimation {
            lastCorrect = true
        }
        gameScore.correct()
        let oldTarget = target
        let oldAnswer = targetHex
        lastResult = "Correct: \(oldTarget) in hex is \(oldAnswer)"
        newQuestion()
    }
    func submit() {
        guard let answer = Int(input) else {
            wrongAnswer()
            return
        }
        if answer == target {
            correctAnswer()
            return
        } else {
            wrongAnswer()
            return
        }
    }
    func newQuestion() {
        // Prevent same question repeatedly
        let oldTarget = target
        repeat {
            target = Int.random(in: 0..<16)
        } while target == oldTarget
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
                    Text("Total score: \(gameScore.correctTotal) out of \(gameScore.correctTotal + gameScore.wrongTotal)")
                    Text("Last 100: \(gameScore.last100correct) correct \(gameScore.last100wrong) wrong")
                }
                Section("Next Task") {
                    Text("Convert \(targetHex) to Decimal")
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
        OneDigitHex2DecimalView(gameScore: GameScore())
    }
}
