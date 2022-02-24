//
//  IPv6Cidr.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/24/22.
//

import Foundation
import Network

struct IPv6Cidr: CustomStringConvertible {
    
    var ip: UInt128 {
        return ipv6.uint128
    }
    private(set) var prefixLength: Int
    private(set) var ipv6: IPv6Address
    
    init?(cidr: String) {
        let portions = cidr.split(separator: "/")
        guard portions.count == 2 else { return nil }
        guard let ipSubstring = portions.first else { return nil }
        guard let lengthString = portions.last else { return nil }
        guard let ipv6 = IPv6Address(String(ipSubstring)) else {
            return nil
        }
        self.ipv6 = ipv6
        guard let prefixLength = Int(lengthString) else { return nil }
        guard prefixLength >= 0 && prefixLength <= 128 else { return nil }
        self.prefixLength = prefixLength
    }
    
    var description: String {
        return ipv6.debugDescription + "/" + String(prefixLength)
    }
    
    var networkIp: UInt128 {
        var mask = UInt128.max
        mask = mask >> (128 - prefixLength)
        mask = mask << (128 - prefixLength)
        
        return ipv6.uint128 & mask
    }
    
    var networkIPv6: IPv6Address {
        let networkIp = self.networkIp.ipv6
        guard let networkIPv6 = IPv6Address(networkIp) else {
            fatalError("Unable to convert \(networkIp) to IPv6 address")
        }
        return networkIPv6
    }
    
    var hostMask: UInt128 {
        var mask = UInt128.max
        mask = mask << prefixLength
        mask = mask >> prefixLength
        return mask
    }
    
    var highestIp: UInt128 {
        let ip = self.ipv6.uint128
        var hostMask = UInt128.max
        hostMask = hostMask << prefixLength
        hostMask = hostMask >> prefixLength
        return ip | hostMask
    }
    
    var highestIPv6: IPv6Address {
        let highestIPv6String = self.highestIp.ipv6
        guard let highestIPv6 = IPv6Address(highestIPv6String) else {
            fatalError("Unable to convert \(highestIPv6String) to IPv6 address")
        }
        return highestIPv6
    }
    
    var wellFormedCidr: IPv6Cidr {
        let newString = "\(self.networkIPv6.debugDescription)/\(self.prefixLength)"
        guard let wellFormed = IPv6Cidr(cidr: newString) else {
            fatalError("Unable to create IPv6Cidr from newString \(newString)")
        }
        return wellFormed
    }
    
    var wellFormedCidrString: String {
        return wellFormedCidr.description
    }
}
