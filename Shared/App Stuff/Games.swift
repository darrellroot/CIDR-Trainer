//
//  Games.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/9/22.
//

import Foundation
import CoreData

enum Games: String, CaseIterable {
    case oneDigitHex2Decimal
    case oneDigitDecimal2Hex
    case oneDigitHex2Binary
    
    var fetchRequest: NSFetchRequest<CoreGame> {
        let fetchRequest: NSFetchRequest<CoreGame> = NSFetchRequest(entityName: "CoreGame")
        fetchRequest.fetchLimit = 1
        
        let predicate = NSPredicate(format: "name == \"\(self.rawValue)\"")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = []
        return fetchRequest
    }
}
