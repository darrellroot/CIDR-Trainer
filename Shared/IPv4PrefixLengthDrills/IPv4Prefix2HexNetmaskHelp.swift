//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct IPv4Prefix2HexNetmaskHelp: View {
    
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
    ***Converting IPv4 Prefix Length To Hexadecimal Netmask***
    
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
    
    To convert from a prefix length to a hexadecimal netmask, consider the prefix length 4 bits at a time and type the appropriate hex digit:
    
    `1111 -> f`
    `1110 -> e`
    `1100 -> c`
    `1000 -> 8`
    `0000 -> 0`
    
    No other hexadecimal digits will be present in a netmask.  The hexadecimal netmask will always have 8 characters
    
    Here are example conversions, showing the binary representation in the middle:
    
    `/24 -> 11111111111111111111111100000000 -> ffffff00`
    
    Here are more conversion examples:
    
    `/0 -> 00000000000000000000000000000000 -> 00000000`
    `/1 -> 10000000000000000000000000000000 -> 80000000`
    `/25 -> 11111111111111111111111110000000 -> ffffff80`
    `/32 -> 11111111111111111111111111111111 -> ffffffff`
    
    
    """
}

struct IPv4Prefix2HexNetmaskHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv4Prefix2HexNetmaskHelp()
    }
}
