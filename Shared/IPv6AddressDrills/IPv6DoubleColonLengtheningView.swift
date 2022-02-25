//
//  IPv6DoubleColonLengtheningView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/25/22.
//

import SwiftUI

struct IPv6DoubleColonLengtheningView: View, DrillHelper {
    static let staticFetchRequest = Games.ipv6DoubleColonLengthening.fetchRequest
    let fetchRequest = staticFetchRequest
    @FetchRequest(fetchRequest: staticFetchRequest) var coreGames
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    @State var input: String = ""

    @State var given = IPv6Cidr(practice: .doubleColon)
    
    @State var lastResult = "Press your answer and hit the up arrow"
    @State var lastCorrect = true
    @State var displayCheck = false
    @State var displayScore = true

    init() {
        self.input = self.given.ipv6.debugDescription
    }
    
    func wrongAnswer() {
         withAnimation {
             lastCorrect = false
         }
         thisGame?.wrong()
        lastResult = "Incorrect: \(given.ipv6.debugDescription) with double-colons expanded is \(given.unshortened!) not \(input)"

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
        lastResult = "Correct: \(given.ipv6.debugDescription) with double-colons expanded is \(given.unshortened!)"
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
        if input == given.unshortened! {
            correctAnswer()
            return
        } else {
            wrongAnswer()
            return
        }
    }
    
    func newQuestion() {
        given = IPv6Cidr(practice: .doubleColon)
        input = given.ipv6.debugDescription
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
                            Text("Special instructions for this exercise: only expand each all-zeroes hextet to one zero")
                            Text("Expand double-colons in IPv6 Address \(given.ipv6.debugDescription)")
                            TextField("",text: $input)
                                .onSubmit {
                                    submit()
                                }
                                .keyboardType(.numbersAndPunctuation)
                                .disableAutocorrection(true)
                        }
                        .foregroundColor(Color.accentColor)

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
            .navigationTitle("IPv6 Double Colon Lengthening")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Help", destination: IPv6DoubleColonHelp())
                }
            }
            .onAppear {
                input = given.ipv6.debugDescription
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        displayScore = false
                    }
                }
            }
        }//if else
    }
}

struct IPv6DoubleColonLengtheningView_Previews: PreviewProvider {
    static var previews: some View {
        IPv6DoubleColonLengtheningView()
    }
}
