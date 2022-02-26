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
    var addressType: IPv6AddressType {
        switch self.uint128 {
        case IPv6AddressType.unspecified.range:
            return .unspecified
        case IPv6AddressType.loopback.range:
            return .loopback
        case IPv6AddressType.ipv4Mapped.range:
            return .ipv4Mapped
        case IPv6AddressType.uniqueLocal.range:
            return .uniqueLocal
        case IPv6AddressType.linkLocal.range:
            return .linkLocal
        case IPv6AddressType.siteLocal.range:
            return .siteLocal
        case IPv6AddressType.unicast.range:
            return .unicast
        case IPv6AddressType.multicast.range:
            return .multicast
        default:
            return .unknown
        }
    }
    init(uint128: UInt128) {
        let hextet0 = UInt16(uint128.value.upperBits >> 48)
        let hextet1 = UInt16((uint128.value.upperBits & 0x0000_ffff_0000_0000) >> 32)
        let hextet2 = UInt16((uint128.value.upperBits & 0x0000_0000_ffff_0000) >> 16)
        let hextet3 = UInt16((uint128.value.upperBits & 0x0000_0000_0000_ffff))
        let hextet4 = UInt16(uint128.value.lowerBits >> 48)
        let hextet5 = UInt16((uint128.value.lowerBits & 0x0000_ffff_0000_0000) >> 32)
        let hextet6 = UInt16((uint128.value.lowerBits & 0x0000_0000_ffff_0000) >> 16)
        let hextet7 = UInt16(uint128.value.lowerBits & 0x0000_0000_0000_ffff)
        
        let addressString = "\(hextet0.hex4):\(hextet1.hex4):\(hextet2.hex4):\(hextet3.hex4):\(hextet4.hex4):\(hextet5.hex4):\(hextet6.hex4):\(hextet7.hex4)"
        self.init(addressString)!
    }

}
