//
//  IPv6Cidr.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/24/22.
//

import Foundation
import Network

struct IPv6Cidr: CustomStringConvertible {
    
    static let nonZeroHexDigit = ["1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]

    var ip: UInt128 {
        return ipv6.uint128
    }
    private(set) var prefixLength: Int
    private(set) var ipv6: IPv6Address
    
    // this is the long unshortened IPv6 address for "practice drills"
    private(set) var unshortened: String?

    init(practice: PracticeType) {
        switch practice {
        
        // doubleColon generates an IPv6 address where each hextet has a 50% chance of being 0 and a 50% chance of it being xxxx where x is not 0
        case .doubleColon:
            self.prefixLength = 128 // not used for this practice
            var result = ""
            let specialCase = Int.random(in: 0..<20)
            if specialCase == 0 {
                result = "0:0:0:0:0:0:0:0"
                self.unshortened = result
                self.ipv6 = IPv6Address(result)!
                return
            }
            if specialCase == 1 {
                result = "0:0:0:0:0:0:0:1"
                self.unshortened = result
                self.ipv6 = IPv6Address(result)!
                return
            }

            for i in 0..<8 {
                var nonZeroFirstSix = false
                if Bool.random() {
                    // prevent ipv4-compatible address
                    if i == 6 && nonZeroFirstSix {
                        result += "1111"
                    } else {
                        result += "0"
                    }
                } else {
                    var digit = IPv6Cidr.nonZeroHexDigit.randomElement()!
                    // prevent ipv4-compatible address
                    if i == 5 && nonZeroFirstSix && digit == "f" {
                        digit = "e"
                    }
                    for _ in 0 ..< 4 {
                        result.append(digit)
                    }
                    nonZeroFirstSix = true
                }
                if i < 7 {
                    result += ":"
                }
            }
            self.unshortened = result
            self.ipv6 = IPv6Address(result)!
            return
        // for hextetShortening we want an IPv6 address without consecutive zeroes
        case .hextetShortening:
            var result = ""
            var priorHextetZero = false
            for i in 0..<8 {
                var valid = false
                var newHextet: Hextet
                repeat {
                    //
                    newHextet = Hextet()
                    // if prior hextet was 0, this one cannot be
                    if priorHextetZero == false || newHextet.value != "0000" {
                        valid = true
                    } else {
                        valid = false // should not be necessary
                    }
                    // if this hextet is 0, prevent next one
                    if newHextet.value == "0000" {
                        priorHextetZero = true
                    }
                } while !valid
                result += newHextet.value
                if i < 7 {
                    result += ":"
                }
            }
            guard let resultV6 = IPv6Address(result) else {
                fatalError("cannot initialize ipv6 address from \(result)")
            }
            self.ipv6 = resultV6
            self.unshortened = result
            self.prefixLength = 128 // not used for this practice
            return
            // for addressShortening we want an IPv6 address with many zeros but never ipv4-compatible
        case .addressShortening:
            self.prefixLength = 128 // not used for this practice
            let specialCase = Int.random(in: 0..<20)
            var result = ""
            if specialCase == 0 {
                result = "0:0:0:0:0:0:0:0"
                self.unshortened = result
                self.ipv6 = IPv6Address(result)!
                return
            }
            if specialCase == 1 {
                result = "0:0:0:0:0:0:0:1"
                self.unshortened = result
                self.ipv6 = IPv6Address(result)!
                return
            }
            var possibleV4Compatible = true
            for i in 0..<8 {
                var newHextet = Hextet()
                if i<5 && newHextet.value != "0000" {
                    possibleV4Compatible = false
                }
                if possibleV4Compatible && i == 5 && (newHextet.value == "0000" || newHextet.value == "ffff") {
                    newHextet.setValue("1111")
                }
                
                result += newHextet.value
                if i < 7 {
                    result += ":"
                }
            }
            
            guard let resultV6 = IPv6Address(result) else {
                fatalError("cannot initialize ipv6 address from \(result)")
            }
            self.ipv6 = resultV6
            self.unshortened = result
            return

        }
    }
    
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
    
    //Generates an IPv6 cidr where the prefix length is an integer multiple of divisor
    init(divisor: Int) {
        let ipHigh = UInt64.random(in: 0..<UINT64_MAX)
        let ipLow = UInt64.random(in: 0..<UINT64_MAX)
        let ip = UInt128(upperBits: ipHigh, lowerBits: ipLow)
        let address = IPv6Address(uint128: ip)
        let prefix = (Int.random(in: 0...128) / divisor) * divisor
        self.ipv6 = address
        self.prefixLength = prefix
        self.unshortened = "\(ipv6.description)/\(prefix)"

        
    }
    
    var description: String {
        return ipv6.description + "/" + String(prefixLength)
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
        let newString = "\(self.networkIPv6.description)/\(self.prefixLength)"
        guard let wellFormed = IPv6Cidr(cidr: newString) else {
            fatalError("Unable to create IPv6Cidr from newString \(newString)")
        }
        return wellFormed
    }
    
    var wellFormedCidrString: String {
        return wellFormedCidr.description
    }
}
