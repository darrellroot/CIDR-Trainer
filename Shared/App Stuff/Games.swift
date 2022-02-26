//
//  Games.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/9/22.
//

import Foundation
import CoreData

enum Games: String, CaseIterable {
    case oneDigitHex2Decimal
    case oneDigitDecimal2Hex
    case oneDigitHex2Binary
    case oneDigitBinary2Hex
    case oneDigitBinary2Decimal
    case oneDigitDecimal2Binary
    case oneDigitBitwiseAnd
    case twoDigitHex2DecimalEasy
    case twoDigitHex2Binary
    case twoDigitDecimal2HexEasy
    case twoDigitBinary2Hex
    case twoDigitDecimal2Binary
    case twoDigitBinary2Decimal
    case twoDigitDecimal2Hex
    case twoDigitHex2Decimal
    case eightBitAnd
    case validIPv4Addresses
    case ipv4AddressTypes
    case ipv4Prefix2BinaryNetmask
    case ipv4BinaryNetmask2PrefixLength
    case ipv4Prefix2HexNetmask
    case ipv4HexNetmask2Prefix
    case ipv4Prefix2DecimalNetmask
    case ipv4DecimalNetmask2Prefix
    case ipv4NumberIpsCidr
    case ipv4NumberUsableIpsCidr
    case ipv4Cidr2NetworkHard
    case ipv4Cidr2NetworkDecimal
    case ipv4Cidr2Broadcast
    case ipv4Cidr2FirstUsable
    case ipv4Cidr2LastUsable
    case ipv6HextetShortening
    case ipv6HextetLengthening
    case ipv6EightHextetShortening
    case ipv6EightHextetLengthening
    case ipv6DoubleColonLengthening
    case ipv6AddressShortening
    case ipv6AddressLengthening
    
    var fetchRequest: NSFetchRequest<CoreGame> {
        let fetchRequest: NSFetchRequest<CoreGame> = NSFetchRequest(entityName: "CoreGame")
        fetchRequest.fetchLimit = 1
        
        let predicate = NSPredicate(format: "name == \"\(self.rawValue)\"")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = []
        return fetchRequest
    }
}
