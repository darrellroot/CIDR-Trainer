//
//  IPv6Cidr16Drill.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/27/22.
//

import SwiftUI

struct IPv6CidrAnyDrillView: View, DrillHelper {
    static let staticFetchRequest = Games.ipv6Cidr16.fetchRequest
    let fetchRequest = staticFetchRequest
    @FetchRequest(fetchRequest: staticFetchRequest) var coreGames
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    @State var input = ""
    @State var given: IPv6Cidr = IPv6Cidr(divisor: 1)
    @State var lastResult = "Press your answer and hit the up arrow"
    @State var lastCorrect = true
    @State var displayCheck = false
    @State var displayScore = true

    let cidrDivisor: Int = 1
    
    func wrongAnswer() {
        withAnimation {
            lastCorrect = false
        }
        thisGame?.wrong()
        lastResult = """
            Incorrect:
            \(given.unshortened ?? "?")
            well-formed CIDR is
            \(given.wellFormedCidrString)
            """

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
        lastResult = """
            Correct:
            \(given.unshortened ?? "?")
            well-formed CIDR is
            \(given.wellFormedCidrString)
            """
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
        if input == given.wellFormedCidrString {
            correctAnswer()
            return
        } else {
            wrongAnswer()
            return
        }
    }

    func newQuestion() {
        given = IPv6Cidr(divisor: cidrDivisor)
        input = "\(given.unshortened ?? "")"
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
                                .font(.body.monospaced())

                        }
                        Section("Next Task") {
                            Text("Convert this address to a well-formed CIDR")
                            Text("\(given.description)")
                            TextField("",text: $input)
                                .onSubmit {
                                    submit()
                                }
                                .keyboardType(.numbersAndPunctuation)
                                .disableAutocorrection(true)
                            .foregroundColor(.accentColor)
                        }
                        .foregroundColor(Color.primary)

                    }
                    Spacer()
                    //HexKeyboardView(input: $input,submit: submit)
                }.onDisappear {
                    saveMoc()
                }// main vstack
                ResultControlView(displayScore: $displayScore)
                (lastCorrect ? SFSymbol.checkmark.image : SFSymbol.xCircle.image)
                    .font(.system(size: 150)).opacity(displayCheck ? 0.4 : 0.0)
            }// zstack
            
            .navigationTitle("IPv6 CIDR Drill" )

            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Help", destination: IPv6CidrAnyHelp())
                }
            }
            .onAppear {
                input = given.ipv6.description
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        displayScore = false
                    }
                }
            }
        }//if else
    }
}
struct IPv6CidrAnyDrillView_Previews: PreviewProvider {
    static var previews: some View {
        IPv6CidrAnyDrillView()
    }
}
