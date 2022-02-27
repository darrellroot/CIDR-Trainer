//
//  HextetInvalid.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/26/22.
//

import Foundation

enum InvalidHextetType: CaseIterable {
    case valid
    case invalidHex
    case invalidSize
    
    var explanation: String {
        switch self {
            
        case .valid:
            return "it has 4 or fewer valid hexadecimal digits"
        case .invalidHex:
            return "it has a digit which is not hexadecimal"
        case .invalidSize:
            return "it has more than 4 hexadecimal characters"
        }
    }
}

struct InvalidHextet {
    private(set) var value: String
    private(set) var type: InvalidHextetType
    
    let invalidChars = ["g","h"]
    let validChars = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]
    
    var valid: Bool {
        switch self.type {
        case .valid:
            return true
        case .invalidHex, .invalidSize:
            return false
        }
    }
    static let types: [InvalidHextetType] = [.valid,.valid,.invalidHex,.invalidSize]
    init() {
        let type = InvalidHextet.types.randomElement()!
        self.type = type
        switch type {
            
        case .valid:
            let chars = Int.random(in: 1..<5)
            var value = ""
            for _ in 0..<chars {
                value += validChars.randomElement()!
            }
            self.value = value
        case .invalidHex:
            let chars = Int.random(in: 1..<5)
            let invalidChar = Int.random(in: 0..<chars)
            var value = ""
            for char in 0..<chars {
                if char == invalidChar {
                    value += invalidChars.randomElement()!
                } else {
                    value += validChars.randomElement()!
                }
            }
            self.value = value

        case .invalidSize:
            let chars = Int.random(in: 5..<6)
            var value = ""
            for _ in 0..<chars {
                value += validChars.randomElement()!
            }
            self.value = value
        }
    }
}
