//
//  ValidIPv4AddressesView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/11/22.
//

import SwiftUI

struct ValidIPv4AddressesView: View, DrillHelper {
    static let staticFetchRequest = Games.validIPv4Addresses.fetchRequest
    let fetchRequest = staticFetchRequest
    @FetchRequest(fetchRequest: staticFetchRequest) var coreGames
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings
    
    @State var lastResult = ""
    @State var lastCorrect = true
    @State var displayCheck = false

    @State var octet1 = Int.random(in: 0..<275)
    @State var octet2 = Int.random(in: 0..<275)
    @State var octet3 = Int.random(in: 0..<275)
    @State var octet4 = Int.random(in: 0..<275)
    @State var octet5 = Int.random(in: 0..<275)
    @State var octets = 4

    var valid: Bool {
        if octets == 4 && octet1 < 256 && octet2 < 256 && octet3 < 256 && octet4 < 256 {
            return true
        } else {
            return false
        }
    }
    
    var address: String {
        if octets == 3 {
            return "\(octet1).\(octet2).\(octet3)"
        } else if octets == 4 {
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        } else if octets == 5 {
            return "\(octet1).\(octet2).\(octet3).\(octet4).\(octet5)"
        } else {
            fatalError("Unexpected # of octets \(octets)")
        }
    }
    
    var validReason: String {
        if octets != 4 {
            return "\(address) is invalid because it has \(octets) octets.  IPv4 addresses should have 4 octets."
        }
        if octet1 >= 256 {
            return "\(address) is invalid because the first octet is \(octet1). Each IPv4 octet should range from 0-255."
        }
        if octet2 >= 256 {
            return "\(address) is invalid because the second octet is \(octet2). Each IPv4 octet should range from 0-255."
        }
        if octet3 >= 256 {
            return "\(address) is invalid because the third octet is \(octet3). Each IPv4 octet should range from 0-255."
        }
        if octet4 >= 256 {
            return "\(address) is invalid because the fourth octet is \(octet4). Each IPv4 octet should range from 0-255."
        }
        return "\(address) is valid.  It has 4 octets and they all range from 0-255."
    }
    
    func wrongAnswer() {
        withAnimation {
            lastCorrect = false
        }
        thisGame?.wrong()
        
        lastResult = "Incorrect: \(validReason)"
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
        lastResult = "Correct: \(validReason)"
        displayCheck = true
        withAnimation {
            displayCheck = false
        }
        newQuestion()
    }
    
    func newQuestion() {
        octet1 = Int.random(in: 0..<285)
        octet2 = Int.random(in: 0..<285)
        octet3 = Int.random(in: 0..<285)
        octet4 = Int.random(in: 0..<285)
        let randomizer = Int.random(in: 0..<10)
        switch randomizer {
        case 0..<3:
            octets = 3
        case 3..<7:
            octets = 4
        case 7..<10:
            octets = 5
        default:
            fatalError("Unexpected randomizer value \(randomizer)")
        }
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
                            Text("Reminder: \"valid\" does not necessarily mean \"usable\" as a unicast IPv4 address")
                            RecentScoreView(nsFetchRequest: fetchRequest)
                            AllTimeScoreView(nsFetchRequest: fetchRequest)
                        }
                        Section("Next Task") {
                            Text("Is \(address) a valid IPv4 address?")
                        }
                        .foregroundColor(Color.accentColor)

                    }
                    Spacer()
                    Button(action: {
                        if valid == true {
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
                        if valid == false {
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
                (lastCorrect ? SFSymbol.checkmark.image : SFSymbol.xCircle.image)
                    .font(.system(size: 150)).opacity(displayCheck ? 0.4 : 0.0)

            }// zstack

            .navigationTitle("Valid IPv4 Addresses")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Help", destination: ValidIPv4AddressesHelp())
                }
            }

        }// if else
    }
}

struct ValidIPv4AddressesView_Previews: PreviewProvider {
    static var previews: some View {
        ValidIPv4AddressesView()
    }
}
