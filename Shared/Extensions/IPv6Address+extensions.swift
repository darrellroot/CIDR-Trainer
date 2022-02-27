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
    
    //debugDescription is buggy in some cases
    // see test cases and FB9931840 for examples
    var description: String {
        let debugDescription = self.debugDescription
        if debugDescription == "?" || debugDescription.contains("%") {
            var result = ""
            for (position,octet) in self.rawValue.enumerated() {
                let output = String(format: "%02x",octet)
                result += output
                if position % 2 == 1 && position < 14 {
                    result += ":"
                }
            }
            return result
        } else {
            return debugDescription
        }
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
    
    init(type: IPv6AddressType) {
        switch type {
            
        case .unspecified:
            self = IPv6Address("::")!
        case .loopback:
            self = IPv6Address("::1")!
        case .ipv4Mapped:
            let address: UInt128 = UInt128.random(in: IPv6AddressType.ipv4Mapped.range)
            self = IPv6Address(uint128: address)
        case .uniqueLocal:
            let address: UInt128 = UInt128.random(in: IPv6AddressType.uniqueLocal.range)
            self = IPv6Address(uint128: address)
        case .linkLocal:
            // we will pick recognizable link-local
            // even though the range is larger
            let linkMin = UInt128(upperBits: 0xfe80_0000_0000_0000, lowerBits: 0)
            let linkMax = UInt128(upperBits: 0xfe80_0000_0000_0001, lowerBits: 0)
            let shortLinkRange: Range<UInt128> = linkMin..<linkMax

            let address: UInt128 = UInt128.random(in: shortLinkRange)
            self = IPv6Address(uint128: address)
        case .siteLocal:
            let address: UInt128 = UInt128.random(in: IPv6AddressType.siteLocal.range)
            self = IPv6Address(uint128: address)
        case .unicast:
            let address: UInt128 = UInt128.random(in: IPv6AddressType.unicast.range)
            self = IPv6Address(uint128: address)
        case .multicast:
            let multicastMin = UInt128(upperBits: 0xff00_0000_0000_0000, lowerBits: 0)
            let multicastMax = UInt128(upperBits: 0xff10_0000_0000_0000, lowerBits: 0)
            let shortMulticastRange: Range<UInt128> = multicastMin..<multicastMax
            // some multicast addresses print out incorrectly, so we have to use a subset
            let address: UInt128 = UInt128.random(in: shortMulticastRange)
            //let address: UInt128 = UInt128.random(in: IPv6AddressType.multicast.range)
            self = IPv6Address(uint128: address)
        case .unknown:
            fatalError("we dont want to do this")
        }
    }

}
