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
    
    init?(cidr: String) {
        let portions = cidr.split(separator: "/")
        guard portions.count == 2 else { return nil }
        guard let ipSubstring = portions.first else { return nil }
        guard let lengthString = portions.last else { return nil }
        let octets = ipSubstring.split(separator: ".")
        guard let octet1 = UInt8(octets[0]) else { return nil }
        guard let octet2 = UInt8(octets[1]) else { return nil }
        guard let octet3 = UInt8(octets[2]) else { return nil }
        guard let octet4 = UInt8(octets[3]) else { return nil }
        guard let passedInLength = Int(lengthString) else { return nil }
        guard passedInLength >= 0 && passedInLength <= 32 else { return nil }
        self.prefixLength = passedInLength
        let octet1Value = UInt32(octet1) << 24
        let octet2Value = UInt32(octet2) << 16
        let octet3Value = UInt32(octet3) << 8
        self.ip = octet1Value + octet2Value + octet3Value + UInt32(octet4)
    }
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
    
    static let smallestMulticast = 224 * 256 * 256 * 256
    
    // true for unicast and loopback
    var unicast: Bool {
        if self.ip < IPv4Cidr.smallestMulticast {
            return true
        } else {
            return false
        }
    }
        
    //we're being careful with overflow
    //this is not useful for /31 or /32
    var broadcastIp: UInt32 {
        if self.networkIp == 0 {
            return UInt32(numberIps) - 1
        } else {
            return self.networkIp - 1 + UInt32(numberIps)
        }
    }
    
    var firstUsableIp: UInt32 {
        if prefixLength == 31 || prefixLength == 32 {
            return self.networkIp
        } else {
            return self.networkIp + 1
        }
    }
    
    var lastUsableIp: UInt32 {
        let networkIp = self.networkIp
        if prefixLength == 32 {
            return networkIp
        } else if prefixLength == 31 {
            return networkIp + 1
        } else if networkIp == 0 {
            return UInt32(numberIps) - 2
        } else if networkIp == 1 {
            return networkIp + UInt32(numberIps) - 2
        } else {
            return networkIp - 2 + UInt32(numberIps)
        }
    }

    
    var binary: String {
        var result = ""
        for bit in stride(from: 31, to: -1, by: -1) {
            // goal is to set 1 bit in a mask
            var mask = UInt32.max
            mask = mask >> bit
            mask = mask << bit
            mask = mask << (31 - bit)
            mask = mask >> (31 - bit)
            if (self.ip & mask) != 0 {
                result += "1"
            } else {
                result += "0"
            }
        }
        // result should have 32 characters
        return result
    }
    
    var binarySpace: String {
        var result = ""
        for bit in 0..<32 {
            if bit == 8 || bit == 16 || bit == 24 {
                result += " "
            }
            // goal is to set 1 bit in a mask
            var mask = UInt32.max
            mask = mask >> (31 - bit)
            mask = mask << (31 - bit)
            mask = mask << bit
            mask = mask >> bit
            if (self.ip & mask) != 0 {
                result += "1"
            } else {
                result += "0"
            }
        }
        // result should have 32 characters
        return result
    }

    
    var maskBinary: String {
        var result = ""
        for _ in 0..<prefixLength {
            result += "1"
        }
        for _ in 0..<(32-prefixLength) {
            result += "0"
        }
        return result
    }
    
    var maskBinarySpace: String {
        var result = ""
        for bit in 0..<32 {
            if bit == 8 || bit == 16 || bit == 24 {
                result += " "
            }
            if bit < prefixLength {
                result += "1"
            } else {
                result += "0"
            }
        }
        return result
    }

    
    // returns current cidr with host portion set to 0
    var wellFormed: IPv4Cidr {
        let mask = UINT32_MAX << (32 - prefixLength)
        let newIP = self.ip & mask
        return IPv4Cidr(ip: newIP, prefixLength: self.prefixLength)
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
     from our restricted range, and 24 right bits randomly.  "well formed" means host portion 0*/
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
    
    var networkIp: UInt32 {
        var result = self.ip
        result = result >> (32 - prefixLength)
        result = result << (32 - prefixLength)
        return result
    }
    
    /* makes small random cidr of /16 or /22 - /30
     with first octet in range 1..126 or 128...223
     we use bitshifting to form the left 8 bits
     from our restricted range, and 24 right bits randomly.  "well formed" means host portion 0*/
    static var unicastWellFormed30: IPv4Cidr {
        var prefix = Int.random(in: 21...30)
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

    
    /* makes small random cidr of /16 or /22 - /32
     with first octet in range 1..126 or 128...223
     we use bitshifting to form the left 8 bits
     from our restricted range, and 24 right bits randomly.  Host portion probably not 0*/
    static var unicastRandom: IPv4Cidr {
        var prefix = Int.random(in: 21...32)
        if prefix == 21 { prefix = 16 }
        var firstOctet = UInt32.random(in: 1...222)
        if firstOctet == 127 { firstOctet = 223 }
        firstOctet = firstOctet << 24
        var otherOctets = UInt32.random(in: 0...UINT32_MAX)
        otherOctets = otherOctets >> 8
        let ip = firstOctet | otherOctets
        
        return IPv4Cidr(ip: ip, prefixLength: prefix)
    }
    

}
