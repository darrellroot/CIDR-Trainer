//
//  Keypress.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/3/22.
//

import Foundation

enum Keypress: CustomStringConvertible {
    
    case zero,one,two,three,four,five,six,seven,eight,nine
    case DEL
    case ENTER
    case a,b,c,d,e,f
    
    init(_ digit: Int) {
        switch digit {
        case 0:
            self = .zero
        case 1:
            self = .one
        case 2:
            self = .two
        case 3:
            self = .three
        case 4:
            self = .four
        case 5:
            self = .five
        case 6:
            self = .six
        case 7:
            self = .seven
        case 8:
            self = .eight
        case 9:
            self = .nine
        case 10:
            self = .a
        case 11:
            self = .b
        case 12:
            self = .c
        case 13:
            self = .d
        case 14:
            self = .e
        case 15:
            self = .f
        default:
            fatalError("Keypress: invalid digit \(digit)")
        }
    }
    var description: String {
        switch self {
            
        case .zero:
            return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .a:
            return "a"
        case .b:
            return "b"
        case .c:
            return "c"
        case .d:
            return "d"
        case .e:
            return "e"
        case .f:
            return "f"
        case .DEL:
            return "DEL"
        case .ENTER:
            return "ENTER"
        }
    }

    
}