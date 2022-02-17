//
//  UInt32+Extensions.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/17/22.
//

import Foundation

extension UInt32 {
    var ipv4: String {
        let octet1 = self / (256 * 256 * 256)
        let octet2 = (self / (256 * 256)) % 256
        let octet3 = (self / 256) % 256
        let octet4 = self % 256
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
}
