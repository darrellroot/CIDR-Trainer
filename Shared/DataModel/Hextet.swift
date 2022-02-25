//
//  File.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/24/22.
//

import Foundation

struct Hextet {
    static let hexDigit = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]
    
    private(set) var value: String
    
    // hextet with leading zeroes gone
    var short: String {
        
        var position = value.startIndex
        
        for _ in 0..<3 {
            guard value[position] == "0" else {
                return String(value[position..<value.endIndex])
            }
            position = value.index(after: position)
        }
        return String(value[position..<value.endIndex])
    }
    init() {
        var value = ""
        for _ in 0..<4 {
            if Bool.random() {
                value += "0"
            } else {
                value += Hextet.hexDigit.randomElement()!
            }
        }
        self.value = value
    }
}
