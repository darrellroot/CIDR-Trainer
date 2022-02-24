//
//  IPv6Address+extensions.swift
//  Network Mom ACL Analyzer
//
//  Created by Darrell Root on 8/5/19.
//  Copyright © 2019 Network Mom LLC. All rights reserved.
//

import Foundation
import Network

extension IPv6Address {
    var uint128: UInt128 {
        let data = self.rawValue
        guard data.count == 16 else {
            fatalError("ipv6 data does not have 16 bytes")
        }
        var total: UInt128 = 0
        for byte in data {
            total = total * 256
            total = total + UInt128(byte)
        }
        return total
    }
}
