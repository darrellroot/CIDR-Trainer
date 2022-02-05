//
//  OneDigitHex2DecimalView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/3/22.
//

import SwiftUI

struct OneDigitHex2DecimalView: View {
    


    @State var input = ""
    @State var target: Int = Int.random(in: 0..<16)
    @State var correct = 0
    @State var wrong = 0
    @State var lastResult = "Press your answer and hit the up arrow"
    @State var lastCorrect = true
    
    var targetHex: String {
        return String(format: "0x%X",target)
    }

    func wrongAnswer() {
        withAnimation {
            lastCorrect = false
        }
        wrong += 1
        let oldTarget = targetHex
        let oldAnswer = target
        lastResult = "Incorrect: \(oldTarget) in decimal is \(oldAnswer)"
        newQuestion()
    }
    func correctAnswer() {
        withAnimation {
            lastCorrect = true
        }
        correct += 1
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
                    Text("Score: \(correct) out of \(correct + wrong)")
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
        OneDigitHex2DecimalView()
    }
}
