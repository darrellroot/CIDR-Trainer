//
//  IPv4Address.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/11/22.
//

import Foundation

struct IPv4Address: CustomStringConvertible {
    private(set) var octet1: Int
    private(set) var octet2: Int
    private(set) var octet3: Int
    private(set) var octet4: Int
    
    var description: String {
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
    
    var type: IPv4AddressType
    
    // generates a random ipv4 address of the correct type
    init(type: IPv4AddressType) {
        self.type = type
        switch type {
            
        case .broadcast:
            octet1 = 255
            octet2 = 255
            octet3 = 255
            octet4 = 255
        case .loopback:
            octet1 = 127
            octet2 = Int.random(in: 0..<256)
            octet3 = Int.random(in: 0..<256)
            octet4 = Int.random(in: 0..<256)
        case .multicast:
            octet1 = Int.random(in: 224..<240)
            octet2 = Int.random(in: 0..<256)
            octet3 = Int.random(in: 0..<256)
            octet4 = Int.random(in: 0..<256)
        case .reserved:
            octet1 = Int.random(in: 240..<256)
            octet2 = Int.random(in: 0..<256)
            octet3 = Int.random(in: 0..<256)
            // guaranteeing last one is not 255
            octet4 = Int.random(in: 0..<255)
        case .unicast:
            octet1 = Int.random(in: 1..<224)
            octet2 = Int.random(in: 0..<256)
            octet3 = Int.random(in: 0..<256)
            octet4 = Int.random(in: 0..<256)
            if octet1 == 127 {
                octet1 = 126
            }
        }
    }
}
