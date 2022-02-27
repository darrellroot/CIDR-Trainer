//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct IPv6Cidr4Help: View {
    
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
    ***IPv6 CIDR Help (prefix-length divisible by 4)***
    
    Every IPv6 address is 128 bits in length.  Each hexadecimal character represents 4 bits.  So it is possible to perform CIDR calculations for prefix-lengths evenly divisible by 4 without any hex math.  But it is important to expand IPv6 addresses.  A shortened hextet might be missing a leading 0, but that 0 still counts as 4 bits.
    
    Our first example:
    `0123:4567:89ab:cdef:0123:4567:89ab:cdef/36`
    
    The /36 includes the first two hextets, plus one additional hexadecimal character, making our netmask:
    
    `ffff:ffff:f000:0000:0000:0000:0000:0000`
    
    Performing our bitwise AND:
    
    `0123:4567:8000:0000:0000:0000:0000:0000/36`
    
    And shortening:
    
    `123:4567:8000::/36`
    
    **Important** Be careful with that shortening.  You can only shorten leading zeroes in a hextet.  123:4567:8::/36 would be incorrect because that would be the same as 123:4567:0008::/36.
    
    A second example:
    
    `4567:89ab:cdef:123:4567:89ab:cdef:123/52`
    
    Our /52 covers three 16-bit hextets plus one 4-bit hexadecimal character.  This IPv6 address is already shortened.  We must consider the expansion of the 4th hextet to do this correctly:
    
    `4567:89ab:cdef:0123:4567:89ab:cdef:0123/52`
    `ffff:ffff:ffff:f000:0000:0000:0000:0000 netmask`
    `4567:89ab:cdef:0000:0000:0000:0000:0000/52 result`
    `4567:89ab:cdef::/52 result shortened`
    
    """
}

struct IPv6Cidr4Help_Previews: PreviewProvider {
    static var previews: some View {
        IPv6Cidr4Help()
    }
}
