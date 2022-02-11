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
        return coreGames.first
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
