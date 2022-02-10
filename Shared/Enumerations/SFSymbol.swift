//
//  SFSymbol.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import Foundation
import SwiftUI

enum SFSymbol: String {
    //static let checkmark = Image(systemName: "checkmark")
    //static let xCircle = Image(systemName: "x.circle")
    
    case checkmark
    case xCircle = "x.circle"
    
    var image: Image {
        return Image(systemName: self.rawValue)
    }
}
