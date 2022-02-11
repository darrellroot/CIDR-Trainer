//
//  OneDigitDecimal2BinaryView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/11/22.
//

import SwiftUI

struct OneDigitDecimal2BinaryView: View, DrillHelper {
    static let staticFetchRequest = Games.oneDigitDecimal2Binary.fetchRequest
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
        
        lastResult = "Incorrect: Decimal \(given) is 0b\(given.binary4) not 0b\(input)"
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
        lastResult = "Correct: Decimal \(given) is 0b\(given.binary4) in binary"
        displayCheck = true
        withAnimation {
            displayCheck = false
        }
        newQuestion()
    }
    
    func submit() {
        guard let answer = Int(input, radix: 2) else {
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
                            Text("Convert Decimal \(given) to Binary")
                            Text(input)
                        }
                        .foregroundColor(Color.accentColor)

                    }
                    Spacer()
                    BinaryKeyboardView(input: $input,submit: submit)
                }.onDisappear {
                    do {
                        try moc.save()
                        print("Saved core data context")
                    } catch {
                        print("Failed to save core data context \(error.localizedDescription)")
                    }
                }//main vstack
                (lastCorrect ? SFSymbol.checkmark.image : SFSymbol.xCircle.image)
                    .font(.system(size: 150)).opacity(displayCheck ? 0.4 : 0.0)

            }// zstack

            .navigationTitle("Decimal -> 4-Digit Binary")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Help", destination: OneDigitBinaryHelp())
                }
            }

        }// if else
    }
}



struct OneDigitDecimal2BinaryView_Previews: PreviewProvider {
    static var previews: some View {
        OneDigitDecimal2BinaryView()
    }
}
