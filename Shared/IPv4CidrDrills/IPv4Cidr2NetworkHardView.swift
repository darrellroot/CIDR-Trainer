//
//  IPv4Cidr2NetworkHardView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/18/22.
//

import SwiftUI

struct IPv4Cidr2NetworkHardView: View, DrillHelper {
    static let staticFetchRequest = Games.ipv4Cidr2NetworkHard.fetchRequest
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

    var inputSpaced: String {
        var result = ""
        for (position,bit) in input.enumerated() {
            if position == 8 || position == 16 || position == 24 {
                result += " "
            }
            result.append(bit)
        }
        return result
    }
    
    var inputDottedDecimal: String {
        var result = ""
        let inputCount = input.count
        guard inputCount >= 8 else {
            return result
        }
        let oneIndex = input.index(input.startIndex, offsetBy: 8)
        guard let firstOctet = Int(input[input.startIndex..<oneIndex], radix: 2) else {
            return result
        }
        result += "\(firstOctet)."
        guard inputCount >= 16 else {
            return result
        }
        let twoIndex = input.index(oneIndex, offsetBy: 8)
        guard let secondOctet = Int(input[oneIndex..<twoIndex], radix: 2) else {
            return result
        }
        result += "\(secondOctet)."
        guard inputCount >= 24 else {
            return result
        }
        let threeIndex = input.index(twoIndex, offsetBy: 8)
        guard let thirdOctet = Int(input[twoIndex..<threeIndex], radix: 2) else {
            return result
        }
        result += "\(thirdOctet)."
        guard inputCount >= 32 else {
            return result
        }
        let fourIndex = input.index(threeIndex, offsetBy: 8)
        guard let fourthOctet = Int(input[threeIndex..<fourIndex], radix: 2) else {
            return result
        }
        result += "\(fourthOctet)"
        return result
    }
    func wrongAnswer() {
        withAnimation {
            lastCorrect = false
        }
        thisGame?.wrong()
        lastResult = "Incorrect: \(given.description) network address is \(given.wellFormed.ip.ipv4)"

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
        lastResult = "Correct: \(given.description) network address is \(given.wellFormed.ip.ipv4)"
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
        guard let answer = Int(input, radix: 2) else {
            wrongAnswer()
            return
        }
        if answer == given.wellFormed.ip {
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
                            Text("What is the network address for  \(given.description) in binary?")
                            Text("ip:   \(given.binarySpace)").font(.body.monospaced())
                            Text("mask: \(given.maskBinarySpace)").font(.body.monospaced())
                            Text("      \(inputSpaced)").font(.body.monospaced())
                            Text("\(inputDottedDecimal)")
                        }
                        .foregroundColor(Color.accentColor)

                    }
                    Spacer()
                    BinaryKeyboardView(input: $input,submit: submit)
                }.onDisappear {
                    saveMoc()
                }// main vstack
                ResultControlView(displayScore: $displayScore)
                (lastCorrect ? SFSymbol.checkmark.image : SFSymbol.xCircle.image)
                    .font(.system(size: 150)).opacity(displayCheck ? 0.4 : 0.0)
            }// zstack
            .navigationTitle("CIDR 2 Network Binary")
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
struct IPv4Cidr2NetworkHardView_Previews: PreviewProvider {
    static var previews: some View {
        IPv4Cidr2NetworkHardView()
    }
}
