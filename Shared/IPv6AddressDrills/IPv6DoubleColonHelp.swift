//
//  IPv6HextetShorteningHelp.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/24/22.
//

import SwiftUI

struct IPv6DoubleColonHelp: View {
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
    ***IPv6 Double Colon Shortening***
    
    We already learned that IPv6 addresses have 128 bits, represented by eight hextets of 16 bits each:
    
    `0123:4567:89ab:cdef:0123:4567:89ab:cdef`
    
    We also learned that leading zeroes in each hextet can be omitted from its textual representation.  This does not change the IPv6 address, which is still 128 bits.  It just makes it easier to write.
    
    `123:4567:89ab:cdef:123:4567:89ab:cdef`
    
    Consider the following IPv6 address:
    
    `1111:0000:0000:2222:0000:0000:0000:3333`
    
    Applying our *first shortening rule*, we get:
    
    `1111:0:0:2222:0:0:0:3333`
    
    We have a *second shortening rule*: we can compress two or more hextets of all zeros into ::   But to avoid ambiguity, we can only do this once per IPv6 address.
    
    See https://datatracker.ietf.org/doc/html/rfc4291 and https://datatracker.ietf.org/doc/html/rfc5952 for details.
    
    It is possible that we will have two or three consecutive all-zero hextets.  For example:
    
    `0000:0000:1111:0000:0000:2222:0000:0000`
    
    To avoid ambiguity, we can only compress one.  Per RFC5952, we must "shorten as much as possible".  So for the above example:
    
    `1111:0:0:2222:0:0:0:3333`
    
    We would shorten the three hextets of all zeroes:
    
    `1111:0:0:2222::3333`
    
    If two or more all-zero hextets are of equal length, we must shorten the first instance.  So our new example:
    
    `0000:0000:1111:0000:0000:2222:0000:0000`
    
    would shorten to:
    
    `::1111:0:0:2222:0:0`
    
    To expand back to the full IPv6 address representation:
    
    1) Prepend zeroes to each hextet to make each hextet have four hexadecimal characters.
    
    2) Replace the one :: instance with sufficient :0000: hextets to result in a total of eight hextets.
    
    Example:
    `::1111:0:0:2222:0:0`
    `::1111:0000:0000:2222:0000:0000`
    `0000:0000:1111:0000:0000:2222:0000:0000`
    
    Example:
    `1111:0:0:2222::3333`
    `1111:0000:0000:2222::3333`
    `1111:0000:0000:2222:0000:0000:0000:3333`
    
    The two most dramatic cases of address shortening/lengthening are the unspecified address (128 binary zeroes) and the loopback address (127 binary 0's followed by a binary 1).
    
    Unspecified address shortening by steps:
    `0000:0000:0000:0000:0000:0000:0000:0000`
    `0:0:0:0:0:0:0:0`
    `::`
    
    Loopback address shortening by steps:
    `0000:0000:0000:0000:0000:0000:0000:0001`
    `0:0:0:0:0:0:0:1`
    `::1`
    
    For the "double colon" exercises, we want to concentrate on shortening/expanding double-colons.  So when expanding we will only expand to single-digit 0's.  This will save you a bit of typing.
    
    The next set of exercises will combine hextet shortening and double-colon shortening.
    
    """

}

struct IPv6DoubleColonHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv6DoubleColonHelp()
    }
}
