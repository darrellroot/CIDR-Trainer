//
//  Int+Extensions.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/9/22.
//

import Foundation

extension Int {
    var binary: String {
        return String(self,radix: 2)
    }
    
    // return int as binary string, prepending zeroes if necessary to always give at least 4 digits
    var binary4: String {
        let result = String(self,radix: 2)
        switch result.count {
        case 0:
            return "0000"
        case 1:
            return "000" + result
        case 2:
            return "00" + result
        case 3:
            return "0" + result
        default:
            return result
        }
    }
    
    // return int as binary string, prepending zeroes if necessary to always give at least 8 digits
    var binary8: String {
        let result = String(self, radix: 2)
        let targetLength = 8
        let prependLength: Int
        if result.count >= targetLength {
            prependLength = 0
        } else {
            prependLength = targetLength - result.count
        }
        let prepend = String(repeating: "0",count: prependLength)
        return prepend + result
    }
    var hex: String {
        return String(format: "%x",self)
    }
    
    var hex2: String {
        let result = String(self, radix: 16)
        let targetLength = 2
        let prependLength: Int
        if result.count >= targetLength {
            prependLength = 0
        } else {
            prependLength = targetLength - result.count
        }
        let prepend = String(repeating: "0",count: prependLength)
        return prepend + result

    }
}
