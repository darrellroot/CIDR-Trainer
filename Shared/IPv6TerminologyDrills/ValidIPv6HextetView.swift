//
//  ValidIPv6HextetView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/26/22.
//

import SwiftUI

struct ValidIPv6HextetView: View, DrillHelper {
    static let staticFetchRequest = Games.validIPv6Hextet.fetchRequest
    let fetchRequest = staticFetchRequest
    @FetchRequest(fetchRequest: staticFetchRequest) var coreGames
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(fetchRequest: CoreSettings.fetchRequest()) var coreSettings

    @State var lastResult = ""
    @State var lastCorrect = true
    @State var displayCheck = false
    @State var displayScore = true

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ValidIPv6HextetView_Previews: PreviewProvider {
    static var previews: some View {
        ValidIPv6HextetView()
    }
}
