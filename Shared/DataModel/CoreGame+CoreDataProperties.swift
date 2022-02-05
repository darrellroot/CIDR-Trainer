//
//  CoreGame+CoreDataProperties.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/5/22.
//
//

import Foundation
import CoreData


extension CoreGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreGame> {
        return NSFetchRequest<CoreGame>(entityName: "CoreGame")
    }

    @NSManaged public var name: String?
    @NSManaged public var correctTotal: Int32
    @NSManaged public var wrongTotal: Int32
    @NSManaged public var last100: [Bool]?
    @NSManaged public var nextPosition: Int32

}

extension CoreGame : Identifiable {

}
