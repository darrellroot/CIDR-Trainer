//
//  IPv4HexNetmask2PrefixView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/17/22.
//

import SwiftUI

struct IPv4HexNetmask2PrefixView: View, DrillHelper {
    static let staticFetchRequest = Games.ipv4HexNetmask2Prefix.fetchRequest
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

    var hexNetmask: String {
        // special case to deal with leading zeroes
        if given == 0 {
            return "00000000"
        }
        var netmask: UInt32 = UInt32.max
        netmask = netmask << (32 - given)
        return String(netmask, radix: 16, uppercase: false)
    }
    
    func wrongAnswer() {
        withAnimation {
            lastCorrect = false
        }
        thisGame?.wrong()
        lastResult = "Incorrect: \(hexNetmask) is /\(given) not /\(input)"

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
        lastResult = "Correct: \(hexNetmask) prefix-length is /\(given)"
        displayCheck = true
        withAnimation {
            displayCheck = false
        }
        newQuestion()
    }

    func submit() {
        displayScore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                displayScore = false
            }
        }
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
                        if displayScore {
                            ResultView(lastResult: $lastResult, lastCorrect: $lastCorrect, fetchRequest: fetchRequest)
                        }
                        Section("Next Task") {
                            Text("What is hex netmask \(hexNetmask)'s prefix-length?")
                            Text("/\(input)")
                        }
                        .foregroundColor(Color.accentColor)

                    }
                    Spacer()
                    DecimalKeyboardView(input: $input,submit: submit)
                }.onDisappear {
                    saveMoc()
                }// main vstack
                ResultControlView(displayScore: $displayScore)
                (lastCorrect ? SFSymbol.checkmark.image : SFSymbol.xCircle.image)
                    .font(.system(size: 150)).opacity(displayCheck ? 0.4 : 0.0)
            }// zstack
            .navigationTitle("Hex Netmask -> Prefix Length")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Help", destination: IPv4HexNetmask2PrefixHelp())
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

struct IPv4HexNetmask2PrefixView_Previews: PreviewProvider {
    static var previews: some View {
        IPv4HexNetmask2PrefixView()
    }
}
