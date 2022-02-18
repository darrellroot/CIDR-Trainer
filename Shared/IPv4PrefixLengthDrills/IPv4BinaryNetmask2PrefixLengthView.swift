//
//  IPv4BinaryNetmask2PrefixLengthView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/17/22.
//

import SwiftUI

struct IPv4BinaryNetmask2PrefixLengthView: View, DrillHelper {
    static let staticFetchRequest = Games.ipv4BinaryNetmask2PrefixLength.fetchRequest
    let fetchRequest = staticFetchRequest
    @FetchRequest(fetchRequest: staticFetchRequest) var coreGames
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    @State var input = ""
    @State var given: Int = Int.random(in: 0..<33)
    @State var lastResult = "Press your answer and hit the up arrow"
    @State var lastCorrect = true
    @State var displayCheck = false
    @State var displayScore = true

    var binaryNetmask: String {
        let ones = String(repeating: "1", count: given)
        let zeroes = String(repeating: "0", count: 32 - given)
        return ones + zeroes
    }

    func wrongAnswer() {
        withAnimation {
            lastCorrect = false
        }
        thisGame?.wrong()
        lastResult = "Incorrect: \(binaryNetmask) is /\(given) not /\(input)"

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
        lastResult = "Correct: \(binaryNetmask) prefix-length is /\(given)"
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
            given = Int.random(in: 0..<33)
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
                            Text("What is binary netmask \(binaryNetmask)'s prefix-length?")
                            Text("/\(input)")
                        }
                        .foregroundColor(Color.accentColor)

                    }
                    Spacer()
                    DecimalKeyboardView(input: $input,submit: submit)
                }.onDisappear {
                    saveMoc()
                }// main vstack
                (lastCorrect ? SFSymbol.checkmark.image : SFSymbol.xCircle.image)
                    .font(.system(size: 150)).opacity(displayCheck ? 0.4 : 0.0)
            }// zstack
            .navigationTitle("Binary Netmask -> Prefix Length")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Help", destination: IPv4BinaryNetmask2PrefixHelp())
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        displayScore = false
                    }
                }
            }
        }//if else
    }
}

struct IPv4BinaryNetmask2PrefixLengthView_Previews: PreviewProvider {
    static var previews: some View {
        IPv4BinaryNetmask2PrefixLengthView()
    }
}
