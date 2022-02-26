//
//  IPv6AddressType.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/25/22.
//

import Foundation

enum IPv6AddressType: CustomStringConvertible {
    
    case unspecified
    case loopback
    case ipv4Mapped
    case uniqueLocal
    case linkLocal
    case siteLocal
    case unicast
    case multicast
    case unknown
    
    //These maxes are 1 beyond the max, letting us set up an open range
    static let uniqueLocalMin = UInt128(upperBits: 0xfc00_0000_0000_0000, lowerBits: 0)
    static let uniqueLocalMax = UInt128(upperBits: 0xfe00_0000_0000_0000, lowerBits: 0)

    static let linkLocalMin = UInt128(upperBits: 0xfe80_0000_0000_0000, lowerBits: 0)
    static let linkLocalMax = UInt128(upperBits: 0xfec0_0000_0000_0000, lowerBits: 0)

    static let siteLocalMin = UInt128(upperBits: 0xfec0_0000_0000_0000, lowerBits: 0)
    static let siteLocalMax = UInt128(upperBits: 0xff00_0000_0000_0000, lowerBits: 0)

    static let unicastMin = UInt128(upperBits: 0x2000_0000_0000_0000, lowerBits: 0)
    static let unicastMax = UInt128(upperBits: 0x4000_0000_0000_0000, lowerBits: 0)

    static let multicastMin = UInt128(upperBits: 0xff00_0000_0000_0000, lowerBits: 0)
    // this is one off, multicast with all 1's bits will not be in the half-open range
    static let multicastMax = UInt128(upperBits: 0xffff_ffff_ffff_ffff, lowerBits: 0xffff_ffff_ffff_ffff)
    var range: Range<UInt128> {
        switch self {
            
        case .unspecified:
            return 0..<1
        case .loopback:
            return 1..<2
        case .ipv4Mapped:
            return 0xffff00000000..<0x1000000000000
        case .uniqueLocal:
            
            return IPv6AddressType.uniqueLocalMin..<IPv6AddressType.uniqueLocalMax
        case .linkLocal:
            return IPv6AddressType.linkLocalMin..<IPv6AddressType.linkLocalMax
        case .siteLocal:
            return IPv6AddressType.siteLocalMin..<IPv6AddressType.siteLocalMax
        case .unicast:
            return IPv6AddressType.unicastMin..<IPv6AddressType.unicastMax
        case .multicast:
            return IPv6AddressType.multicastMin..<IPv6AddressType.multicastMax
        case .unknown:
            // default case, needs to run last
            return 0..<IPv6AddressType.multicastMax
        }
    }
    var description: String {
        switch self {
            
        case .unspecified:
            return "Unspecified"
        case .loopback:
            return "Loopback"
        case .ipv4Mapped:
            return "IPv4-Mapped IPv6 Address"
        case .uniqueLocal:
            return "Unique local"
        case .linkLocal:
            return "Link local"
        case .siteLocal:
            return "Site local (deprecated)"
        case .unicast:
            return "Unicast"
        case .multicast:
            return "Multicast"
        case .unknown:
            return "Unknown"
        }
    }
}
