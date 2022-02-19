//
//  IPv4Cidr2NetworkView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/18/22.
//

import SwiftUI

struct IPv4Cidr2NetworkDecimalView: View, DrillHelper {
    static let staticFetchRequest = Games.ipv4Cidr2NetworkDecimal.fetchRequest
    let fetchRequest = staticFetchRequest
    @FetchRequest(fetchRequest: staticFetchRequest) var coreGames
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    @State var input = ""
    @State var given: IPv4Cidr = IPv4Cidr.unicastRandom
    @State var lastResult = "Press your answer and hit the up arrow"
    @State var lastCorrect = true
    @State var displayCheck = false
    @State var displayScore = true

    func wrongAnswer() {
        withAnimation {
            lastCorrect = false
        }
        thisGame?.wrong()
        lastResult = "Incorrect: \(given.description) network IP is \(given.wellFormed.ip.ipv4)"

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
        lastResult = "Correct: \(given.description) network IP is \(given.wellFormed.ip.ipv4)"
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

        if input == given.wellFormed.ip.ipv4 {
            correctAnswer()
            return
        } else {
            wrongAnswer()
            return
        }
    }

    func newQuestion() {
        given = IPv4Cidr.unicastRandom
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
                            Text("What is the network IP for  \(given.description)?")
                            Text(input)
                        }
                        .foregroundColor(Color.accentColor)

                    }
                    Spacer()
                    DottedDecimalKeyboardView(input: $input,submit: submit)
                }.onDisappear {
                    saveMoc()
                }// main vstack
                ResultControlView(displayScore: $displayScore)
                (lastCorrect ? SFSymbol.checkmark.image : SFSymbol.xCircle.image)
                    .font(.system(size: 150)).opacity(displayCheck ? 0.4 : 0.0)
            }// zstack
            .navigationTitle("CIDR 2 Network Decimal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Help", destination: IPv4CidrBinaryHelp())
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
struct IPv4Cidr2NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        IPv4Cidr2NetworkDecimalView()
    }
}
