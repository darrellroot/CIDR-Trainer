//
//  DataController.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/5/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentCloudKitContainer(name: "CoreModel")
    
    init() {
        container.loadPersistentStores { description, error in
            self.container.viewContext.automaticallyMergesChangesFromParent = true
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
                // There can only be one record of each type
                print("Warning: Found \(coreSettings.count) CoreSetting entities")
                var keepNumber: Int? = nil
                for (number,coreSetting) in coreSettings.enumerated() {
                    // keep first setting with full unlock
                    if keepNumber == nil && coreSetting.fullUnlock {
                        keepNumber = number
                    }
                }
                // default is keep first settings record
                if keepNumber == nil {
                    keepNumber = 0
                }
                for (number, coreSetting) in coreSettings.enumerated() {
                    if keepNumber == number {
                        print("keeping settings record \(number)")
                    } else {
                        print("deleting settings record \(number)")
                        container.viewContext.delete(coreSetting)
                    }
                }
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
                    // delete duplicate entities
                    print("Error: Found \(gameTest.count) \(game.rawValue) entities")
                    var maxTotalAttempts = 0
                    var keepRecordNumber = 0
                    for (gameNumber,gameRecord) in gameTest.enumerated() {
                        if gameRecord.totalAttempts > maxTotalAttempts {
                            keepRecordNumber = gameNumber
                            maxTotalAttempts = gameRecord.totalAttempts
                        }
                    }
                    for (gameNumber,gameRecord) in gameTest.enumerated() {
                        if gameNumber == keepRecordNumber {
                            print("keeping \(String(describing: gameRecord.name)) attempts \(gameRecord.totalAttempts)")
                        } else {
                            print("deleting \(String(describing: gameRecord.name)) attempts \(gameRecord.totalAttempts)")
                            container.viewContext.delete(gameRecord)
                        }
                    }
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

