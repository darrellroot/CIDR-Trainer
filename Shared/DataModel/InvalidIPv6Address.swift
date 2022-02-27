//
//  InvalidIPv6Address.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/26/22.
//

import Foundation

enum InvalidIPv6AddressType {
    case valid
    case tooManyHextets
    case quadrupleColon
    
    var explanation: String {
        switch self {
        case .valid:
            return "it has 8 or fewer valid hextets and at most one double-colon"
        case .tooManyHextets:
            return "it has more than 8 valid hextets"
        case .quadrupleColon:
            return "it has more than one double-colon, or it begins or ends with a single-colon"
        }
    }
}

enum IPv6AddressComponent {
    case hextet
    case doubleColon
}

struct InvalidIPv6Address {
    
    static let types: [InvalidIPv6AddressType] = [.valid, .valid, .tooManyHextets, .quadrupleColon]
    var value: String
    var type: InvalidIPv6AddressType
    
    var valid: Bool {
        switch type {
            
        case .valid:
            return true
        case .tooManyHextets:
            return false
        case .quadrupleColon:
            return false
        }
    }
    init() {
        let type = InvalidIPv6Address.types.randomElement()!
        self.type = type
        switch type {
        case .tooManyHextets:
            var value = ""
            for i in 0..<9 {
                value += Hextet().value
                if i < 8 {
                    value += ":"
                }
            }
            self.value = value
        case .quadrupleColon:
            var value = ""
            let double1 = Int.random(in: 0..<5)
            let double2 = Int.random(in: 0..<5)
            for i in 0..<5 {
                if i == double1 {
                    value += ":"
                }
                if i == double2 {
                    value += ":"
                }
                value += Hextet().value
                if i < 4 {
                    value += ":"
                }
            }
            self.value = value
        case .valid:
            switch Bool.random() {
            case true:
                // double colon present
                var value = ""
                let double1 = Int.random(in: 1..<6)
                for i in 0..<7 {
                    if i == double1 {
                        // do nothing
                    } else {
                        value += Hextet().value
                    }
                    if i < 6 {
                        value += ":"
                    }
                }
                self.value = value
            case false:
                //no double colon
                var value = ""
                for i in 0..<8 {
                    value += Hextet().value
                    if i < 7 {
                        value += ":"
                    }
                }
                self.value = value
            }
        }
    }
}
