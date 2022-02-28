//
//  IPv4AddressType.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/11/22.
//

import Foundation

enum IPv4AddressType: String, CaseIterable {
    case broadcast
    case loopback
    case multicast
    case reserved
    case unicast
    case mixed // for CIDR starting in one and ending in the other
    case unspecified
    case thisNetwork
    
    // for cases to generate
    static var cases: [IPv4AddressType] = [.broadcast, .loopback, .multicast, .reserved,.unicast,.unspecified,.thisNetwork]
    
    var explanation: String {
        switch self {
            
        case .broadcast:
            return "255.255.255.255 is the IPv4 broadcast address"
        case .loopback:
            return "any IPv4 address with 127 in the first octet is a loopback address"
        case .multicast:
            return "any IPv4 address with 224 through 239 in the first octet is a multicast address"
        case .reserved:
            return "any IPv4 address ranging from 240.0.0.0 through 255.255.255.254 is reserved for future use"
        case .unicast:
            return "any IPv4 address with the first octet ranging from 1 through 126, or 128 through 223, is a unicast address"
        case .unspecified:
            return "The IPv4 address 0.0.0.0 is unspecified and is often during boot before a host knows its own address"
        case .mixed:
            return "This CIDR spans multiple types of IPv4 addresses"
        case .thisNetwork:
            return "any IPv4 address starting ranging from 0.0.0.1 through 0.255.255.255 refers to a host on 'this network'.  This is no longer commonly used."
        }
    }
}
