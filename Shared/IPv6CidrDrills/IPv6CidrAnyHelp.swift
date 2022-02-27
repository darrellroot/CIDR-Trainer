//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct IPv6CidrAnyHelp: View {
    
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
    ***IPv6 CIDR Help (any prefix)***
    
    We already know how to perform IPv6 CIDR calculations when the prefix length is a multiple of 16 bits (hextet-size) or 4 bits (hexadecimal character size).  Occasionally you may need to perform an IPv6 CIDR with arbitrary size.
    
    For example, all IPv6 globally unique unicast addreses are currently inside 2000::/3
    
    Convert the first hexadecimal character to bits:
    
    `0010`
    Here's the first 4 bits of the netmask in binary:
    `1110`
    
    So the following two binary prefixes would both be within 2000:/3:
    
    `0010 (2 in hexadecimal)`
    `0011 (3 in hexadecimal)`
    
    That is why all globally unique IPv6 unicast addresses start with the hex digit 2 or 3!
    
    Lets do another example:
    
    `0123:4567:89ab:cdef:0123:4567:89ab:cdef/37`
    
    /37 means our netmask includes two hextets, one hexadecimal character, and one bit.  Here's an attempt at putting our netmask into hexadecimal:
    
    `ffff:ffff:f?00:0000:0000:0000:0000:0000`

    At this point, we know our result is going to look like this:
    
    `0123:4567:8?00::/37`
    
    The question is what we put for that last ? hex digit.
    
    Here's 9 in binary:
    
    `1001`
    
    And our netmask includes 1 bit in this hex digit:
    
    `1000`
    
    A bitwise AND results in:
    
    `1000 (8 in hex)`
    
    So our result is:
    
    `123:4567:8800::/37`
    (again we were careful not to incorrectly shorten the 3rd hextet)
    
    Lets do another example:
    
    `0123:4567:89ab:cdef:0123:4567:89ab:cdef/43`
    
    A 43-bit prefix-length means our netmask covers 2 hextets, 2 hex characters, and 3 bits (2 * 16 + 2 * 4 + 3 == 43)
    
    Here's our preliminary netmask in hex:
    
    `ffff:ffff:ff?0:0000:0000:0000:0000:0000`
    
    Here's our ? digit (hexadecimal a) in binary:
    
    `1010`
    And our 3 bits of netmask in binary:
    `1110`
    
    Bitwise-AND result:
    
    `1010 (a in hex)`
    
    Final result:
    
    `0123:4567:89a0:0000:0000:0000:0000:0000/43`
    `123:4567:89a0::/43`
    
    """
}

struct IPv6CidrAnyHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv6CidrAnyHelp()
    }
}
