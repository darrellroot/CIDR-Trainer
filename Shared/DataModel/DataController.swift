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
        do {
            let coreSettings = try container.viewContext.fetch(CoreSettings.fetchRequest())
            switch coreSettings.count {
            case 0:
                print("Creating CoreSettings entity")
                let newSettings = CoreSettings(context: container.viewContext)
                print("Newly created Core Settings full unlock \(newSettings.fullUnlock)")
            case 1:
                print("Found \(coreSettings.count) CoreSetting entity")
                if let coreSetting = coreSettings.first {
                    print("Core Settings full unlock: \(coreSetting.fullUnlock)")
                } else {
                    // should never get here
                    print("Error: cannot access first core settings entity")
                }
            default:
                print("Error: unexpectedly found \(coreSettings.count) CoreSettings entities")
            }
        } catch {
            print("DataController init: Could not fetch CoreSettings due to \(error.localizedDescription)")
        }
        for game in Games.allCases {
            let fetchRequest: NSFetchRequest<CoreGame> = NSFetchRequest(entityName: "CoreGame")
            let predicate = NSPredicate(format: "name == \"\(game.rawValue)\"")
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
        do {
            try container.viewContext.save()
            print("DataController: saved core data context")
        } catch {
            print("DataController: failed to save core data context: \(error.localizedDescription)")
        }
    }
}

