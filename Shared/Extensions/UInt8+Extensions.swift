//
//  UInt8+Extensions.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/17/22.
//

import Foundation

extension UInt8 {
    //this returns a UInt8 starting with 1's and ending with 0's, like a prefix length
    static var randomPrefix: UInt8 {
        let possibleValues: [UInt8] = [0,128,192,224,240,248,252,254,255]
        return possibleValues.randomElement()!
    }
    var bitString: String {
        var result = ""
        if (self & 0b10000000) > 0 {
            result += "1"
        } else {
            result += "0"
        }
        if (self & 0b01000000) > 0 {
            result += "1"
        } else {
            result += "0"
        }
        if (self & 0b00100000) > 0 {
            result += "1"
        } else {
            result += "0"
        }
        if (self & 0b00010000) > 0 {
            result += "1"
        } else {
            result += "0"
        }
        if (self & 0b00001000) > 0 {
            result += "1"
        } else {
            result += "0"
        }
        if (self & 0b00000100) > 0 {
            result += "1"
        } else {
            result += "0"
        }
        if (self & 0b00000010) > 0 {
            result += "1"
        } else {
            result += "0"
        }
        if (self & 0b00000001) > 0 {
            result += "1"
        } else {
            result += "0"
        }
        return result
    }
}
