//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct IPv4Prefix2BinaryNetmaskHelp: View {
    
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
    ***Converting IPv4 Prefix Length To Binary Netmask***
    
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
    
    To convert from a prefix length to a binary netmask, just type the correct number of 1's, followed by sufficient 0's to bring the total number of bits up to 32.
    
    For example, to convert the prefix-length /24 to binary, type 24 1's followed by 8 0's:
    
    `/24 -> 11111111111111111111111100000000`
    
    Here are more conversion examples:
    
    `/0 -> 00000000000000000000000000000000`
    `/1 -> 10000000000000000000000000000000`
    `/25 -> 11111111111111111111111110000000`
    `/32 -> 11111111111111111111111111111111`
    
    Drill hints:
    
    Each keypress on the binary keyboard in this application generates 4 digits. For these drills you will always press the binary keyboard 8 times.
    
    Every binary netmask has consecutive 1's followed by consecutive 0's, so the only useful binary keys are:
    
    1111
    1110
    1100
    1000
    0000
        
    Completing this drill a small number of times should be sufficient to understand the concept.
    
    """
}

struct IPv4Prefix2BinaryNetmaskHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv4Prefix2BinaryNetmaskHelp()
    }
}
