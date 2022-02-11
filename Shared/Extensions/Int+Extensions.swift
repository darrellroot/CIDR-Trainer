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
    var hex: String {
        return String(format: "%x",self)
    }
}
