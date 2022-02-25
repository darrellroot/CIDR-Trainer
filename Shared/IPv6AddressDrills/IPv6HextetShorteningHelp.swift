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
    
    **Remember** When *lengthening* IPv6 address representations the result should have 8 hextets, each with 4 hexadecimal digits.

    In the acompanying drills, you will shorten or lengthen one hextet at a time.
    
    Then we have a more advanced drill where you shorten or lengthen eight hextets at a time.
    
    Later drills will cover an additional rule to further shorten IPv6 addresses with multiple consecutive hextets of "0000".  But the IPv6 addresses generated for these drills will not trigger that rule.

    **Important** We are only shortening the textual representation of the IPv6 address.  Every IPv6 address is always 128 bits! (even if every bit is zero)
    """

}

struct IPv6HextetShorteningHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv6HextetShorteningHelp()
    }
}
