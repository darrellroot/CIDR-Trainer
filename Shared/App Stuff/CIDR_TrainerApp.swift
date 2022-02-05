//
//  CIDR_TrainerApp.swift
//  Shared
//
//  Created by Darrell Root on 2/3/22.
//

import SwiftUI

@main
struct CIDR_TrainerApp: App {
    @StateObject var model = Model()
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView(model: model)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
