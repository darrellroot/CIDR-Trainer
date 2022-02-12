//
//  IPv4AddressTypesView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/11/22.
//

import SwiftUI

struct IPv4AddressTypesView: View, DrillHelper {
    static let staticFetchRequest = Games.ipv4AddressTypes.fetchRequest
    let fetchRequest = staticFetchRequest
    @FetchRequest(fetchRequest: staticFetchRequest) var coreGames
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    @State var lastResult = ""
    @State var lastCorrect = true
    @State var displayCheck = false

    @State var ipv4Address = IPv4Address(type: IPv4AddressType.allCases.randomElement()!)

    func wrongAnswer() {
        withAnimation {
            lastCorrect = false
        }
        thisGame?.wrong()
        
        lastResult = "Incorrect: \(ipv4Address) is \(ipv4Address.type.rawValue) because \(ipv4Address.type.explanation)"
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
        lastResult = "Correct: \(ipv4Address) is \(ipv4Address.type.rawValue) because \(ipv4Address.type.explanation)"
        displayCheck = true
        withAnimation {
            displayCheck = false
        }
        newQuestion()
    }

    func newQuestion() {
        ipv4Address = IPv4Address(type: IPv4AddressType.allCases.randomElement()!)
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
                            Text("What type of IPv4 address is \(ipv4Address.description)")
                        }
                        .foregroundColor(Color.accentColor)

                    }
                    Spacer()
                    ForEach(IPv4AddressType.allCases.sorted(by: {$0.rawValue < $1.rawValue}), id: \.self) { type in
                        Button(action: {
                            if type == ipv4Address.type {
                                correctAnswer()
                            } else {
                                wrongAnswer()
                            }
                        }) {
                            Text("\(type.rawValue)")
                                .frame(maxWidth: .infinity)
                        }.buttonStyle(.borderedProminent)
                            .controlSize(.regular)

                    }
                }.onDisappear {
                    saveMoc()
                }//main vstack
                (lastCorrect ? SFSymbol.checkmark.image : SFSymbol.xCircle.image)
                    .font(.system(size: 150)).opacity(displayCheck ? 0.4 : 0.0)

            }// zstack

            .navigationTitle("IPv4 Address Types")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Help", destination: IPv4AddressTypesHelp())
                }
            }

        }// if else
    }
}



struct IPv4AddressTypesView_Previews: PreviewProvider {
    static var previews: some View {
        IPv4AddressTypesView()
    }
}
