//
//  IPv4NumberUsableIpsCidrView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/17/22.
//

import SwiftUI

struct IPv4NumberUsableIpsCidrView: View, DrillHelper {
    static let staticFetchRequest = Games.ipv4NumberUsableIpsCidr.fetchRequest
    let fetchRequest = staticFetchRequest
    @FetchRequest(fetchRequest: staticFetchRequest) var coreGames
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    @State var input = ""
    @State var given: IPv4Cidr = IPv4Cidr.unicastWellFormed
    @State var lastResult = "Press your answer and hit the up arrow"
    @State var lastCorrect = true
    @State var displayCheck = false

    func wrongAnswer() {
        withAnimation {
            lastCorrect = false
        }
        thisGame?.wrong()
        lastResult = "Incorrect: \(given.description) contains \(given.numberUsableIps) USABLE IPs"

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
        lastResult = "Correct: \(given.description) contains \(given.numberUsableIps) USABLE IPs"
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
        if answer == given.numberUsableIps {
            correctAnswer()
            return
        } else {
            wrongAnswer()
            return
        }
    }
    
    func newQuestion() {
        given = IPv4Cidr.unicastWellFormed
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
                            Text("How many USABLE IPs in  \(given.description)?")
                            Text(input)
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
            .navigationTitle("Number Usable IPs in CIDR")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Help", destination: IPv4NumberIpsHelp())
                }
            }
        }//if else
    }
}
struct IPv4NumberUsableIpsCidrView_Previews: PreviewProvider {
    static var previews: some View {
        IPv4NumberUsableIpsCidrView()
    }
}
