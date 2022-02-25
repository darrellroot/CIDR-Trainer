//
//  IPv6HextetShorteningHelp.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/24/22.
//

import SwiftUI

struct IPv6HextetShorteningHelp: View {
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
    ***IPv6 Hextet Shortening***
    
    An IPv6 address has 128 bits. Each hexadecimal character represents 4 bits so an IPv6 address can be represented by 32 hexadecimal characters.
    
    To make IPv6 addresses easier to read, they are displayed in 8 hextets (16-bit units) separated by colons :
    
    Each hextet of 16-bits is represented by 4 hexadecimal characters.
    
    Example:
    
    `2001:0db8:0012:0003:0000:4560:7800:9000`
    
    Note the 8 hextets, each with 4 hexadecimal characters.
    
    Some IPv6 addresses have many 0's.  To make them easier to write, _some_ 0's may be omitted when writing down the IPv6 address. This can be called "compression" or "shortening".
    
    In each hextet, you may remove _leading_ 0's, but leave at least one 0 in each hextet.
    
    Going back to our example:
    
    `2001:0db8:0012:0003:0000:4560:7800:9000`
    
    Removing leading 0's from each hextet we get:
    
    `2001:db8:12:3:0:4560:7800:9000`

    Note how the 5th hextet still has one 0.
    
    Note how the 6th, 7th, and 8th hextets still have their trailing 0's.  You may only shorten leading 0's.
    
    Because we removed leading 0's, we can restore the IPv6 address' representation to it's full length by prepending 0's to bring each hextet up to 4 digits.
    
    `2001:db8:12:3:0:4560:7800:9000`
    becomes
    `2001:0db8:0012:0003:0000:4560:7800:9000`

    In the acompanying drill, you will shorten one hextet at a time.

    **Important** We are only shortening the textual representation of the IPv6 address.  Every IPv6 address is exactly 128 bits!
    """

}

struct IPv6HextetShorteningHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv6HextetShorteningHelp()
    }
}
