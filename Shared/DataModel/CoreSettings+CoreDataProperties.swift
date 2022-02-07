//
//  CoreSettings+CoreDataProperties.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/6/22.
//
//

import Foundation
import CoreData


extension CoreSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreSettings> {
            let fetchRequest = NSFetchRequest<CoreSettings>(entityName: "CoreSettings")
            fetchRequest.fetchLimit = 1
            fetchRequest.sortDescriptors = []
            return fetchRequest
    }

    @NSManaged private(set) var fullUnlock: Bool

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        fullUnlock = false
        do {
            try managedObjectContext?.save()
        } catch {
            print("Unable to save core data: \(error)")
        }
    }
    
    public func setFullUnlock(_ newValue: Bool) {
        fullUnlock = newValue
        do {
            try managedObjectContext?.save()
        } catch {
            print("Unable to save core data: \(error)")
        }
    }
}

extension CoreSettings : Identifiable {

}
