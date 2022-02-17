//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct IPv4Prefix2DecimalNetmaskHelp: View {
    
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
    ***Converting IPv4 Prefix Length To Dotted-Decimal Netmask***
    
    An IPv4 address has 32 bits.  It starts with a "network portion" and ends with a "host portion".
    
    An IPv4 netmask is a sequence of 32 bits which are set to 1 for the leading network portion, and 0 for the trailing host portion.
    
    Here is an example IPv4 netmask:
    `11111111111111110000000000000000`
    
    That netmask starts with 16 1's, indicating that the network portion of the associated IPv4 address is 16 bits in length.
    
    That netmask ends with 16 0's, indicating that the host portion of the associated IPv4 address is also 16 bits in length.
    
    Every IPv4 netmask has exactly 32 bits.
    
    The netmask is useful because a bitwise-AND of an IPv4 address and its netmask will result in the "network address", which has many network applications.  We will practice determining network addresses in a later drill.
    
    The binary netmask is inconvenient to read.  Sometimes it is displayed in dotted decimal notation similar to an IPv4 address:
    
    `/16 -> 255.255.0.0`
    
    In the above, each "octet" represents 8 binary digits.  The first 16 binary digits in the netmask are set to 1, so the first two octets each consist of 8 binary 1's.  This results in a dotted decimal netmask of 255.255.0.0.
    
    To convert from a prefix length to a dotted-decimal netmask, consider the prefix length 8 bits at a time and convert them to dotted decimal octets:
    
    `11111111 -> 255`
    `11111110 -> 254`
    `11111100 -> 252`
    `11111000 -> 248`
    `11110000 -> 240`
    `11100000 -> 224`
    `11000000 -> 192`
    `10000000 -> 128`
    `00000000 -> 0`
    
    No other dotted-decimal digits will be present in a netmask.  The hexadecimal netmask will always have 8 characters
    
    Here are example conversions from prefix-length to dotted-decimal:
    
    
    `/0 -> 0.0.0.0`
    `/1 -> 128.0.0.0`
    `/8 -> 255.0.0.0`
    `/16 -> 255.255.0.0`
    `/23 -> 255.255.254.0`
    `/24 -> 255.255.255.0`
    `/25 -> 255.255.255.128`
    `/32 -> 255.255.255.255`
    
    """
}

struct IPv4Prefix2DecimalNetmaskHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv4Prefix2DecimalNetmaskHelp()
    }
}
