//
//  UInt128+extensions.swift
//  Network Mom ACL Analyzer
//
//  Created by Darrell Root on 8/4/19.
//  Copyright © 2019 Network Mom LLC. All rights reserved.
//

import Foundation
import Network

extension UInt128 {
    //performance optimziation
    static let hexstring: [String] = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]
    
    static var MAXIPV4: UInt128 {
        return UInt128(UInt32.max)
    }
    var ipv4: String {
        let octet1 = self / (256 * 256 * 256)
        let octet2 = (self / (256 * 256)) % 256
        let octet3 = (self / 256) % 256
        let octet4 = self % 256
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }

    var ipv6: String {
        var runningValue = self
        var output: String = ""
        for position in 0..<32 {
            //let lastDigitValue = Int(runningValue % 16)
            //let lastDigitValue = Int(runningValue & 0xf)
            let lastDigitValue = Int(runningValue.words[0] & 0xf)
            //runningValue = runningValue / 16
            runningValue = runningValue >> 4
            //let character = String(format: "%x",lastDigitValue)
            let character = UInt128.hexstring[lastDigitValue]
            output = "\(character)\(output)"
//            if position % 4 == 3 && position != 0 && position != 31 {
            if position & 3 == 3 && position != 0 && position != 31 {
                output = ":\(output)"
            }
        }
        return output
    }
    
    init(ipv6: IPv6Address) {
        let data = ipv6.rawValue
        guard data.count == 16 else {
            fatalError("ipv6 data does not have 16 bytes")
        }
        var total: UInt128 = 0
        for byte in data {
            //performance optimization
            //total = total * 256
            total = total << 8
            total = total + UInt128(byte)
        }
        self = total
    }
    var netmaskBits: UInt? {
        // returns number of bits in a netmask
        switch self {
        case
        2147483648:     /*128.0.0.0*/
            return 1
        case 3221225472:     /*192.0.0.0*/
            return 2
        case 3758096384:     /*224.0.0.0*/
            return 3
        case 4026531840:     /*240.0.0.0*/
            return 4
        case 4160749568:     /*248.0.0.0*/
            return 5
        case 4227858432:     /*252.0.0.0*/
            return 6
        case 4261412864:     /*254.0.0.0*/
            return 7
        case 4278190080:     /*255.0.0.0*/
            return 8
        case 4286578688:     /*255.128.0.0*/
            return 9
        case 4290772992:     /*255.192.0.0*/
            return 10
        case 4292870144:     /*255.224.0.0*/
            return 11
        case 4293918720:     /*255.240.0.0*/
            return 12
        case 4294443008:     /*255.248.0.0*/
            return 13
        case 4294705152:     /*255.252.0.0*/
            return 14
        case 4294836224:     /*255.254.0.0*/
            return 15
        case 4294901760:     /*255.255.0.0*/
            return 16
        case 4294934528:     /*255.255.128.0*/
            return 17
        case 4294950912:     /*255.255.192.0*/
            return 18
        case 4294959104:     /*255.255.224.0*/
            return 19
        case 4294963200:     /*255.255.240.0*/
            return 20
        case 4294965248:     /*255.255.248.0*/
            return 21
        case 4294966272:     /*255.255.252.0*/
            return 22
        case 4294966784:     /*255.255.254.0*/
            return 23
        case 4294967040:     /*255.255.255.0*/
            return 24
        case 4294967168:     /*255.255.255.128*/
            return 25
        case 4294967232:     /*255.255.255.192*/
            return 26
        case 4294967264:     /*255.255.255.224*/
            return 27
        case 4294967280:     /*255.255.255.240*/
            return 28
        case 4294967288:     /*255.255.255.248*/
            return 29
        case 4294967292:     /*255.255.255.252*/
            return 30
        case 4294967294:     /*255.255.255.254*/
            return 31
        case 4294967295:     //255.255.255.255
            return 32
        case 0:
            return 0         //0.0.0.0
        default:
            return nil
        }
    }
    var netmaskHosts: UInt128? {
        // returns number of hosts in a netmask range
        switch self {
        case
        2147483648,     /*128.0.0.0*/
        3221225472,     /*192.0.0.0*/
        3758096384,     /*224.0.0.0*/
        4026531840,     /*240.0.0.0*/
        4160749568,     /*248.0.0.0*/
        4227858432,     /*252.0.0.0*/
        4261412864,     /*254.0.0.0*/
        4278190080,     /*255.0.0.0*/
        4286578688,     /*255.128.0.0*/
        4290772992,     /*255.192.0.0*/
        4292870144,     /*255.224.0.0*/
        4293918720,     /*255.240.0.0*/
        4294443008,     /*255.248.0.0*/
        4294705152,     /*255.252.0.0*/
        4294836224,     /*255.254.0.0*/
        4294901760,     /*255.255.0.0*/
        4294934528,     /*255.255.128.0*/
        4294950912,     /*255.255.192.0*/
        4294959104,     /*255.255.224.0*/
        4294963200,     /*255.255.240.0*/
        4294965248,     /*255.255.248.0*/
        4294966272,     /*255.255.252.0*/
        4294966784,     /*255.255.254.0*/
        4294967040,     /*255.255.255.0*/
        4294967168,     /*255.255.255.128*/
        4294967232,     /*255.255.255.192*/
        4294967264,     /*255.255.255.224*/
        4294967280,     /*255.255.255.240*/
        4294967288,     /*255.255.255.248*/
        4294967292,     /*255.255.255.252*/
        4294967294:     /*255.255.255.254*/
            return 4294967296 - self
        case 4294967295:
            return 1
        case 0:
            return 4294967296
        default:
            return nil
        }
    }
    var dontCareHosts: UInt128? {
        // returns number of hosts in a dont care bit range
        switch self {
        case 1,3,7,15,31,63,127,255,511,1023,2047,4095,8191,16383,32767,65535,131071,262143,524287,1048575,2097151,4194303,8388607,16777215,33554431,67108863,134217727,268435455,536870911,1073741823,2147483647:
            return self + 1
        case
        0,4294967295:
            return self + 1
        default:
            return nil
        }
    }

}
