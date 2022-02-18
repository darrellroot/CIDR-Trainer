//
//  OneDigitBitwiseAndView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/17/22.
//

import SwiftUI

struct OneDigitBitwiseAndView: View, DrillHelper {
    static let staticFetchRequest = Games.oneDigitBitwiseAnd.fetchRequest
    let fetchRequest = staticFetchRequest
    @FetchRequest(fetchRequest: staticFetchRequest) var coreGames
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    @State var given1 = UInt8.random(in: 0..<2)
    @State var given2 = UInt8.random(in: 0..<2)

    @State var lastResult = "Press your answer and hit the up arrow"
    @State var lastCorrect = true
    @State var displayCheck = false

    var answer: UInt8 {
        return given1 & given2
    }
    func wrongAnswer() {
        withAnimation {
            lastCorrect = false
        }
        thisGame?.wrong()
        lastResult = "Incorrect: \(given1) AND \(given2) is \(answer)"

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
        lastResult = "Correct: \(given1) AND \(given2) is \(answer)"
        displayCheck = true
        withAnimation {
            displayCheck = false
        }
        newQuestion()
    }

    func newQuestion() {
        // Prevent same question repeatedly
        given1 = UInt8.random(in: 0..<2)
        given2 = UInt8.random(in: 0..<2)
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
                            Text("What is \(given1) AND \(given2) ?")
                        }
                        .foregroundColor(Color.accentColor)

                    }
                    Spacer()
                    Button(action: {
                        if answer == 0 {
                            correctAnswer()
                        } else {
                            wrongAnswer()
                        }
                    }) {
                        Text("0")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    Spacer()
                    Button(action: {
                        if answer == 1 {
                            correctAnswer()
                        } else {
                            wrongAnswer()
                        }
                    }) {
                        Text("1")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    Spacer()
                }.onDisappear {
                    saveMoc()
                }// main vstack
                (lastCorrect ? SFSymbol.checkmark.image : SFSymbol.xCircle.image)
                    .font(.system(size: 150)).opacity(displayCheck ? 0.4 : 0.0)
            }// zstack
            .navigationTitle("1 Bit AND")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Help", destination: BitwiseAndHelp())
                }
            }
        }//if else
    }
}

struct OneDigitBitwiseAndView_Previews: PreviewProvider {
    static var previews: some View {
        OneDigitBitwiseAndView()
    }
}
