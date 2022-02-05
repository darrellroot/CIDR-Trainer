//
//  DataController.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/5/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CoreModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
        for game in Games.allCases {
            let fetchRequest: NSFetchRequest<CoreGame> = NSFetchRequest(entityName: "CoreGame")
            let predicate = NSPredicate(format: "name == \(game.rawValue)")
            fetchRequest.predicate = predicate
            fetchRequest.sortDescriptors = []
            
            do {
                let gameTest = try container.viewContext.fetch(fetchRequest)
                switch gameTest.count {
                case 0:
                    print("Creating \(game.rawValue) entity")
                    let newGame = CoreGame(context: container.viewContext)
                    newGame.setName(game.rawValue)
                case 1:
                    print("Found 1 \(game.rawValue) entity")
                default:
                    print("Error: Found \(gameTest.count) \(game.rawValue) entities")
                }
            } catch {
                print("DataController init: Could not fetch \(game.rawValue) due to \(error.localizedDescription)")
            }

        }
    }
}

