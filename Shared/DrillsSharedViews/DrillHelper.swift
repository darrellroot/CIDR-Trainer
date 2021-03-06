//
//  DrillHelper.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/9/22.
//

import Foundation
import CoreData
import SwiftUI

protocol DrillHelper {
    var coreGames: FetchedResults<CoreGame> { get }
    var coreSettings: FetchedResults<CoreSettings> { get }
    var moc: NSManagedObjectContext { get }

}
extension DrillHelper {
    var displayPurchaseView: Bool {
        if coreSettings.first?.fullUnlock == true {
            return false
        }
        if let coreGame = coreGames.first {
            if coreGame.totalAttempts >= Globals.freeSampleNumber {
                return true
            }
        }
        return false
    }
    
    var thisGame: CoreGame? {
        if coreGames.count == 1 {
            return coreGames.first!
        }
        var saveNumber: Int? = nil
        var maxTotalAttempts = -1
        // need to total up all records, then put in 1 record
        var allCorrectTotal: Int32 = 0
        var allWrongTotal: Int32 = 0
        for (recordNumber,coreGame) in coreGames.enumerated() {
            allCorrectTotal += coreGame.correctTotal
            allWrongTotal += coreGame.wrongTotal
            if coreGame.totalAttempts > maxTotalAttempts {
                saveNumber = recordNumber
                maxTotalAttempts = coreGame.totalAttempts
            }
        }
        guard let saveNumber = saveNumber else {
            return nil
        }
        let result = coreGames[saveNumber]
        for (recordNumber, coreGame) in coreGames.enumerated() {
            if recordNumber != saveNumber {
                print("deleting duplicate game record with total \(coreGame.totalAttempts)")
                moc.delete(coreGame)
            } else {
                print("keeping game record with \(coreGame.totalAttempts) setting correct total \(allCorrectTotal) wrong total \(allWrongTotal)")
                coreGame.setCorrectTotal(allCorrectTotal)
                coreGame.setWrongTotal(allWrongTotal)
            }
        }
        return result
    }
    
    func saveMoc() {
        do {
            try moc.save()
            print("Saved core data context")
        } catch {
            print("Failed to save core data context \(error.localizedDescription)")
        }
    }

}
