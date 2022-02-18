//
//  IPv4Cidr.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/17/22.
//

import Foundation

struct IPv4Cidr: CustomStringConvertible {
    
    private(set) var ip: UInt32
    private(set) var prefixLength: Int
    
    init(ip: UInt32, prefixLength: Int) {
        guard prefixLength >= 0 && prefixLength <= 32 else {
            fatalError("Invalid prefix length \(prefixLength)")
        }
        self.ip = ip
        self.prefixLength = prefixLength
    }
    var description: String {
        return "\(ip.ipv4)/\(prefixLength)"
    }
    
    var numberIps: Int {
        var number = 1
        for _ in prefixLength..<32 {
            number = number * 2
        }
        return number
    }
    var numberUsableIps: Int {
        if prefixLength == 32 { return 1 }
        if prefixLength == 31 { return 2 }
        return numberIps - 2
    }
    static var randomWellFormed: IPv4Cidr {
        let prefix = Int.random(in: 0...32)
        let ip = UInt32.random(in: 0...UINT32_MAX)
        var mask = UINT32_MAX
        mask = mask << (32 - prefix)
        let ipFormed = ip & mask
        let cidr = IPv4Cidr(ip: ipFormed,prefixLength: prefix)
        return cidr
    }
    
    // makes random cidr of /16 or /22 - /32
    static var smallWellFormed: IPv4Cidr {
        var prefix = Int.random(in: 21...32)
        if prefix == 21 { prefix = 16 }
        let ip = UInt32.random(in: 0...UINT32_MAX)
        var mask = UINT32_MAX
        mask = mask << (32 - prefix)
        let ipFormed = ip & mask
        let cidr = IPv4Cidr(ip: ipFormed,prefixLength: prefix)
        return cidr
    }
    
    /* makes small random cidr of /16 or /22 - /32
     with first octet in range 1..126 or 128...223
     we use bitshifting to form the left 8 bits
     from our restricted range, and 24 right bits randomly*/
    static var unicastWellFormed: IPv4Cidr {
        var prefix = Int.random(in: 21...32)
        if prefix == 21 { prefix = 16 }
        var firstOctet = UInt32.random(in: 1...222)
        if firstOctet == 127 { firstOctet = 223 }
        firstOctet = firstOctet << 24
        var otherOctets = UInt32.random(in: 0...UINT32_MAX)
        otherOctets = otherOctets >> 8
        var ip = firstOctet | otherOctets
        
        // now we need to make it well-formed
        // using bitshifting to make the right bits 0
        ip = ip >> (32 - prefix)
        ip = ip << (32 - prefix)
        return IPv4Cidr(ip: ip, prefixLength: prefix)
    }
    

}
