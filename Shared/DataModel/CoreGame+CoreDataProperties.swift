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

    @NSManaged private(set) var name: String?
    @NSManaged private(set) var correctTotal: Int32
    @NSManaged private(set) var wrongTotal: Int32
    @NSManaged private(set) var last100: [Bool]?
    @NSManaged private(set) var nextPosition: Int32

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        last100 = []
        correctTotal = 0
        wrongTotal = 0
        nextPosition = 0
        name = "temporary \(UUID())"
        do {
            try managedObjectContext?.save()
        } catch {
            print("Unable to save core data: \(error)")
        }
    }
    func setName(_ name: String) {
        self.name = name
    }
    var totalAttempts: Int {
        return Int(self.correctTotal) + Int(self.wrongTotal)
    }
    var last100correct: Int {
        if let last100 = last100 {
            return last100.reduce(0) {$0 + ($1 ? 1 : 0)}
        } else {
            last100 = []
            print("unexpectedly resetting last100 in \(name)")
            return 0
        }
    }
    var last100wrong: Int {
        if let last100 = last100 {
            return last100.reduce(0) {$0 + ($1 ? 0 : 1)}
        } else {
            last100 = []
            print("unexpectedly resetting last100 in \(name)")
            return 0
        }
    }
    func correct() {
        correctTotal += 1
        
        // should not get here but just in case
        if nextPosition >= Globals.lastSize {
            nextPosition = 0
        }
        if last100 != nil {
            if nextPosition >= last100!.count {
                last100!.append(true)
            } else {
                last100![Int(nextPosition)] = true
            }
            nextPosition += 1
        }
        if nextPosition >= Globals.lastSize {
            nextPosition = 0
        }
    }
    func wrong() {
        wrongTotal += 1
        // should not get here but just in case
        if nextPosition >= Globals.lastSize {
            nextPosition = 0
        }

        if last100 != nil {
            if nextPosition >= last100!.count {
                last100!.append(false)
            } else {
                last100![Int(nextPosition)] = false
            }
            nextPosition += 1
            if nextPosition >= Globals.lastSize {
                nextPosition = 0
            }
        }
    }

}

extension CoreGame : Identifiable {

}
