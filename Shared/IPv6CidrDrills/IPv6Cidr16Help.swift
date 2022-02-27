//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct IPv6Cidr16Help: View {
    
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
    ***IPv6 CIDR Help (prefix-length divisible by 16)***
    
    This exercise gives you a random IPv6 address and asks you to respond with the well-formed CIDR for that address.  For our first practice exercise, the prefix-length is divisible by 16.
    
    Consider the following IPv6 CIDR:
    
    `0123:4567:89ab:cdef:0123:4567:89ab:cdef/64`
    
    The network prefix is the first 64 bits.  The host portion is the remaining 128-64=64 bits.
    
    Each hextet is 16 bits, so we could represent the network mask in hexadecimal like this:
    
    `ffff:ffff:ffff:ffff:0000:0000:0000:0000`
    
    Performing a bitwise-AND between the IPv6 address and the /64 netmask we get:
    
    `0123:4567:89ab:cdef:0000:0000:0000:0000/64`
    
    Which shortens to:
    
    `123:4567:89ab:cdef::/64`
    
    Here's another example:
    
    `0123:4567:89ab:cdef:0123:4567:89ab:cdef/48`
    
    Because each hextet is 16 bits, we know the /48 means the first three hextets are network and the last five hextets are host.  So we just change the last 5 hextets to all 0's and then shorten:
    
    `0123:4567:89ab:0000:0000:0000:0000:0000/48`
    `123:4567:89ab::/64`
    
    If a double-colon exists in the network-portion, it is important to consider its expansion while calculating the CIDR.  Consider this example:
    
    `1234::5678/32`
    
    /32 means two hextets are in the network portion.  If we expand it, perform the CIDR, and then shrink it, here are the results:
    
    `1234:0000:0000:0000:0000:0000:0000:5678/32`
    `1234:0000:0000:0000:0000:0000:0000:0000/32 (well-formed)`
    `1234::/32 (well-formed and shortened)`
    
    """
}

struct IPv6Cidr16Help_Previews: PreviewProvider {
    static var previews: some View {
        IPv6Cidr16Help()
    }
}
