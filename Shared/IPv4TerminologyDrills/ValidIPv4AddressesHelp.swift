//
//  OneDigitDecimalBinaryHelp.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct ValidIPv4AddressesHelp: View {
    
    var attributedString: AttributedString {
        try! AttributedString(markdown: markdownString, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace))
    }

    var body: some View {
        ScrollView {
            Text(attributedString)
                
                
        }.padding()
        //HTMLStringView(htmlContent: htmlString)
    }
    

    let markdownString = """
    ***Valid IPv4 addresses help***
    
    An IPv4 address has 32 bits.  Numerically that could range from 0 to 4,294,967,295.  That is hard to read so instead IPv4 addresses are displayed in 4 "octets" each representing 8 bits, separated by periods.  For example:
    
    198.51.100.212
    
    Each octet has 8 bits so each octet can range from 0 to 255.
    
    The following are examples of invalid IPv4 addresses:
    
    `1.2.3       This only has three octets`
    `1.2.3.4.5   This has five octets`
    `256.1.2.3  The first octet is larger than 255 so it is invalid`
    `a.1.2.3    Only decimal digits are valid in each octet`
    
    Just because an IPv4 address is "valid" does not mean that it is "usable" as (for example) an IPv4 unicast address.  We will learn about the different types of IPv4 addresses later.  Different ranges of IPv4 addresses are used for different types of addresses.
    """
}

struct ValidIPv4AddressesHelp_Previews: PreviewProvider {
    static var previews: some View {
        ValidIPv4AddressesHelp()
    }
}
