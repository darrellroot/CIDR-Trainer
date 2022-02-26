//
//  IPv6HextetShorteningHelp.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/24/22.
//

import SwiftUI

struct IPv6AddressShorteningHelp: View {
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
    ***IPv6 Address Shortening***
    
    It is time to put our two address shortening rules together:
    
    1) Leading 0's in each hextet may be removed
    
    2) Two or more consecutive :0: hextets may be replaced with :: but only once per IPv6 address.  If there are multiple such instances, the largest chain of consecutive :0: hextets should be shortened to ::   If there is a tie, the first one should be shortened to ::
    
    Example:
    
    `2001:0db8:0012:0003:0000:0000:7800:9000`
    
    Applying shortening rule #1:
    
    `2001:db8:12:3:0:0:7800:9000`
    
    Applying shortening rule #2:
    
    `2001:db8:12:3::7800:9000`
    
    To expand that back to a full IPv6 address, here is the procedure:
    
    1) Prepend enough 0's in each hextet so each hextet has four hex digits.
    
    2) Replace the double-colon with sufficient :0000: hextets so there are a total of 8 hextets.
    
    Reversing our example:
    
        `2001:db8:12:3::7800:9000`
    
    Expansion rule #1 (prepending zeros):
    
    `2001:0db8:0012:0003::7800:9000`
    
    Expansion rule #2 (expanding :: to yield 8 hextets)
    
    `2001:0db8:0012:0003:0000:0000:7800:9000`

    """

}

struct IPv6AddressShorteningHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv6AddressShorteningHelp()
    }
}
