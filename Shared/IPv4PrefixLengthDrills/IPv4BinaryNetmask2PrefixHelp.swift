//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct IPv4BinaryNetmask2PrefixHelp: View {
    
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
    ***Converting IPv4 Binary Netmask to Prefix Length***
    
    An IPv4 address has 32 bits.  It starts with a "network portion" and ends with a "host portion".
    
    An IPv4 netmask is a sequence of 32 bits which are set to 1 for the leading network portion, and 0 for the trailing host portion.
    
    Here is an example IPv4 netmask:
    `11111111111111110000000000000000`
    
    That netmask starts with 16 1's, indicating that the network portion of the associated IPv4 address is 16 bits in length.
    
    That netmask ends with 16 0's, indicating that the host portion of the associated IPv4 address is also 16 bits in length.
    
    Every IPv4 netmask has exactly 32 bits.
    
    The netmask is useful because a bitwise-AND of an IPv4 address and its netmask will result in the "network address", which has many network applications.  We will practice determining network addresses in a later drill.
    
    The binary netmask is inconvenient to read.  Sometimes it is displayed in hex:
    
    `ffff0000`
    
    Sometimes it is displayed as a "prefix-length", with an integer after a slash identifying the number of binary 1's in the netmask.  For example:
    
    `/16`
    
    Prefix lengths can range from /0 through /32.
    
    To convert from a binary netmask to a prefix-length, just count the number of leading 1's.  Example:
    
    `11111111111111111111111100000000 -> /24`
        
    Here are more conversion examples:
    
    `00000000000000000000000000000000 -> /0`
    `10000000000000000000000000000000 -> /1`
    `11111111111111111111111110000000 -> /25`
    `11111111111111111111111111111111 -> /32`
    
    Drill hints:
    
    This applications' keyboard does not have a /, so just type in the integer for the prefix-length.
    
    The prefix-length will always range from /0 through /32
    
    Sometimes it is easier to count the trailing number of 0's and subtract from 32.  The following example is a /30 because it has 2 0's at the end and the total number of bits is always 32.
    
    `11111111111111111111111111111100 -> /30`
        
    Completing this drill a small number of times should be sufficient to understand the concept.
    
    """
}

struct IPv4BinaryNetmask2PrefixHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv4BinaryNetmask2PrefixHelp()
    }
}
