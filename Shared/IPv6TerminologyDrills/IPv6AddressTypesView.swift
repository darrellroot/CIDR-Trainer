//
//  IPv6AddressTypesView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/26/22.
//

import SwiftUI
import Network

struct IPv6AddressTypesView: View, DrillHelper {
    static let staticFetchRequest = Games.ipv6AddressTypes.fetchRequest
    let fetchRequest = staticFetchRequest
    @FetchRequest(fetchRequest: staticFetchRequest) var coreGames
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    @State var lastResult = ""
    @State var lastCorrect = true
    @State var displayCheck = false
    @State var displayScore = true

    // any case except unknown IPv6 type
    static let cases: [IPv6AddressType] = [.unspecified,.loopback,.ipv4Mapped,.uniqueLocal,.linkLocal,.unicast,.multicast]
    
    @State var ipv6Address = IPv6Address(type: cases.randomElement()!)

    func wrongAnswer() {
        displayScore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                displayScore = false
            }
        }
        withAnimation {
            lastCorrect = false
        }
        thisGame?.wrong()
        
        lastResult = """
            Incorrect:
            \(ipv6Address)
            is \(ipv6Address.addressType) because
            \(ipv6Address.addressType.explanation)
            """
        displayCheck = true
        withAnimation {
            displayCheck = false
        }
        newQuestion()
    }
    
    func correctAnswer() {
        displayScore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                displayScore = false
            }
        }
        withAnimation {
            lastCorrect = true
        }
        thisGame?.correct()
        lastResult = """
            Correct:
            \(ipv6Address)
            is \(ipv6Address.addressType) because
            \(ipv6Address.addressType.explanation)
            """
        displayCheck = true
        withAnimation {
            displayCheck = false
        }
        newQuestion()
    }
    
    func newQuestion() {
        ipv6Address = IPv6Address(type: IPv6AddressTypesView.cases.randomElement()!)
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
                            Text("\(ipv6Address.description) is what type of IPv6 address?")
                        }
                        .foregroundColor(Color.accentColor)

                    }
                    Spacer()
                    ForEach(IPv6AddressTypesView.cases.sorted(by: {$0.description < $1.description}), id: \.self) { type in
                        Button(action: {
                            if type == ipv6Address.addressType {
                                correctAnswer()
                            } else {
                                wrongAnswer()
                            }
                        }) {
                            Text("\(type.description)")
                                .frame(maxWidth: .infinity)
                        }.buttonStyle(.borderedProminent)
                            .controlSize(.regular)

                    }
                }.onDisappear {
                    saveMoc()
                }//main vstack
                ResultControlView(displayScore: $displayScore)
                (lastCorrect ? SFSymbol.checkmark.image : SFSymbol.xCircle.image)
                    .font(.system(size: 150)).opacity(displayCheck ? 0.4 : 0.0)

            }// zstack

            .navigationTitle("IPv6 Address Types")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Help", destination: IPv6AddressTypesHelp())
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
struct IPv6AddressTypesView_Previews: PreviewProvider {
    static var previews: some View {
        IPv6AddressTypesView()
    }
}
