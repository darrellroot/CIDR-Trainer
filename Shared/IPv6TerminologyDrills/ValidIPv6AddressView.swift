//
//  ValidIPv6AddressView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/26/22.
//

import SwiftUI

struct ValidIPv6AddressView: View, DrillHelper {
    static let staticFetchRequest = Games.validIPv6Address.fetchRequest
    let fetchRequest = staticFetchRequest
    @FetchRequest(fetchRequest: staticFetchRequest) var coreGames
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    @State var lastResult = ""
    @State var lastCorrect = true
    @State var displayCheck = false
    @State var displayScore = true

    @State var given = InvalidIPv6Address()

    func wrongAnswer() {
        withAnimation {
            lastCorrect = false
        }
        thisGame?.wrong()
        lastResult = """
            Incorrect:
            \(given.value)
            is \(given.valid ? "valid" : "invalid") because
            \(given.type.explanation)
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
            \(given.value)
            is \(given.valid ? "valid" : "invalid") because
            \(given.type.explanation)
            """
        displayCheck = true
        withAnimation {
            displayCheck = false
        }
        newQuestion()
    }
    
    func newQuestion() {
        given = InvalidIPv6Address()
    }

    var body: some View {
        if displayPurchaseView {
            PurchaseView()
        } else {
            ZStack {
                VStack {
                    List {
                        if displayScore {
                            Section("Results") {
                                Text("\(lastResult)")
                                    .foregroundColor(lastCorrect ? Color.green : Color.red)
                                    .fontWeight(.bold)
                                RecentScoreView(nsFetchRequest: fetchRequest)
                                AllTimeScoreView(nsFetchRequest: fetchRequest)
                            }
                        }
                        Section("Next Task") {
                            Text("Is \(given.value) a valid IPv6 address?")
                        }
                        .foregroundColor(Color.accentColor)

                    }
                    Spacer()
                    Button(action: {
                        if given.valid == true {
                            correctAnswer()
                        } else {
                            wrongAnswer()
                        }
                    }) {
                        Text("Yes")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    Spacer()
                    Button(action: {
                        if given.valid == false {
                            correctAnswer()
                        } else {
                            wrongAnswer()
                        }
                    }) {
                        Text("No")
                            .frame(maxWidth: .infinity)
                    }.buttonStyle(.borderedProminent)
                        .controlSize(.large)
                    Spacer()
                }.onDisappear {
                    saveMoc()
                }//main vstack
                ResultControlView(displayScore: $displayScore)
                (lastCorrect ? SFSymbol.checkmark.image : SFSymbol.xCircle.image)
                    .font(.system(size: 150)).opacity(displayCheck ? 0.4 : 0.0)

            }// zstack

            .navigationTitle("Valid IPv6 Addresses")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Help", destination: ValidIPv6AddressHelp())
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        displayScore = false
                    }
                }
            }

        }// if else
    }
}
struct ValidIPv6AddressView_Previews: PreviewProvider {
    static var previews: some View {
        ValidIPv6AddressView()
    }
}
