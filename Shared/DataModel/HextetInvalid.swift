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
}

struct HextetInvalid {
    private(set) var value: String
    private(set) var type: InvalidHextetType
    
    let invalidChars = ["g","h"]
    let validChars = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]
    init() {
        let type = InvalidHextetType.allCases.randomElement()!
        self.type = type
        switch type {
            
        case .valid:
            let chars = Int.random(in: 1..<4)
            var value = ""
            for _ in 0..<chars {
                value += validChars.randomElement()!
            }
            self.value = value
        case .invalidHex:
            <#code#>
        case .invalidSize:
            <#code#>
        }
    }
}
