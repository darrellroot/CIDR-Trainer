//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct ValidIPv6AddressHelp: View {
    
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
    ***Valid IPv6 Address Help***
    
    An IPv6 address has 128 bits.
    
    For easier reading, we display them in 8 hextets of 16 bits each, separated by colons.  Each hextet constitutes 4 hexadecimal characters.
    
    Leading zeroes in each hextet can be removed.
    
    **One** consecutive set of multiple :0: hextets can be shortened to ::
    
    *From the "Invalid Hextet" drill, you already know:*
    
    If any hextet has 5 or more hexadecimal characters, the whole IPv6 address is invalid.
    
    If any hextet has an invalid hexadecimal character, the whole IPv6 address is invalid.
    
    *This drill focuses on:*
    
    If the IPv6 address has more than 8 hextets, it is invalid.
    
    If the IPv6 address has more than one :: instance (or a single ::: instance) it is invalid.
    
    If the IPv6 address begins or ends with a single :, it is invalid.

    """
}

struct ValidIPv6AddressHelp_Previews: PreviewProvider {
    static var previews: some View {
        ValidIPv6AddressHelp()
    }
}
