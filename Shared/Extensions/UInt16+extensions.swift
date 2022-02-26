//
//  UInt16+extensions.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/25/22.
//

import Foundation

extension UInt16 {
    var hex4: String {
        var a = String(self,radix: 16)
        let prepend = 4 - a.count
        for _ in 0..<prepend {
            a = "0" + a
        }
        return a
    }
}
