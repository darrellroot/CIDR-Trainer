//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct ValidIPv6HextetHelp: View {
    
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
    ***Valid IPv6 Hextet Help***
    
    An IPv6 address has 128 bits.
    
    For easier reading, we display them in 8 hextets of 16 bits each, separated by colons.  Each hextet constitutes 4 hexadecimal characters.
    
    Example:
    `:02bd:`
    
    Thanks to IPv6 address shortening rules, we can remove 0's from the front.
    
    Examples after shortening:
    
    `:02bd: -> :2bd:`
    `:00bd: -> :bd:`
    `:000d: -> :d:`
    `:0000: -> :0:`
    
    The 2nd IPv6 shortening rule applies to multiple consecutive :0: hextets and is not considered in this exercise.
    
    A hextet can be invalid if it has a character that is not a valid hexadecimal character.  Or if it has more than 4 hexadecimal characters/
    
    Invalid hextet examples:
    `:02gd:  (g is not a valid hexadecimal character)`
    `:2bdf3: (5 hex characters exceeds 16 bits)`
    
    This exercise asks you to determine whether an IPv6 hextet is valid.  This is a "warm-up" for determining whether a full IPv6 address is valid.

    """
}

struct ValidIPv6HextetHelp_Previews: PreviewProvider {
    static var previews: some View {
        ValidIPv6HextetHelp()
    }
}
