//
//  IPv4Prefix2HexNetmaskView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/17/22.
//

import SwiftUI

struct IPv4Prefix2HexNetmaskView: View, DrillHelper {
    static let staticFetchRequest = Games.ipv4Prefix2HexNetmask.fetchRequest
    let fetchRequest = staticFetchRequest
    @FetchRequest(fetchRequest: staticFetchRequest) var coreGames
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    @State var input = ""
    @State var given: Int = Int.random(in: 0..<33)
    @State var lastResult = "Press your answer and hit the up arrow"
    @State var lastCorrect = true
    @State var displayCheck = false

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
        lastResult = "Incorrect: A /\(given) prefix length is \(hexNetmask) in hex"

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
        lastResult = "Correct: A /\(given) prefix length is \(hexNetmask) in hex"
        displayCheck = true
        withAnimation {
            displayCheck = false
        }
        newQuestion()
    }

    func submit() {
        /*guard let answer = Int(input, radix: 2) else {
            wrongAnswer(nil)
            return
        }*/
        if input == hexNetmask {
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
                            Text("Prefix length: /\(given) What is the netmask in hex?")
                            Text(input)
                        }
                        .foregroundColor(Color.accentColor)

                    }
                    Spacer()
                    HexKeyboardView(input: $input,submit: submit)
                }.onDisappear {
                    saveMoc()
                }// main vstack
                (lastCorrect ? SFSymbol.checkmark.image : SFSymbol.xCircle.image)
                    .font(.system(size: 150)).opacity(displayCheck ? 0.4 : 0.0)
            }// zstack
            .navigationTitle("Prefix Length -> Hex Netmask")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Help", destination: IPv4Prefix2HexNetmaskHelp())
                }
            }
        }//if else
    }
}

struct IPv4Prefix2HexNetmaskView_Previews: PreviewProvider {
    static var previews: some View {
        IPv4Prefix2HexNetmaskView()
    }
}
