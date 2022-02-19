//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct IPv4Cidr2BroadcastHelp: View {
    
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
    ***CIDR to Broadcast IP***
    
    In this exercise, you are given a "well-formed" CIDR (where the host portion are all binary 0's) and asked to calculate the broadcast IP.
    
    The broadcast IP is the same IP except with all the host bits set to 1.
    
    Consider 147.7.135.192/28 in binary:
    
    `IP   10010011 00000111 10000111 11000000`
    `Mask 11111111 11111111 11111111 11110000`
    If we set the 4 host bits to 1's we get:
    `Bcst 10010011 00000111 10000111 11001111`
    
    Or 147.7.135.207
    
    As usual, the first 3 octets are unchanged because the network mask of /28 covers them completely.  Converting them to binary was unnecessary.
    
    Another way of calculating this is remembering how many IPs per subnet:
    
    `/32 -> 1`
    `/31 -> 2`
    `/30 -> 4`
    `/29 -> 8`
    `/28 -> 16`
    `/27 -> 32`
    `/26 -> 64`
    `/25 -> 128`
    `/24 -> 256`
    `/23 -> 512`
    `/22 -> 1024`

    Given that we have a /28 starting at 147.7.135.192, the next /28 would start at the last octet +16, or 147.7.135.208.  The broadcast address is 1 below that or 147.7.135.207.
    
    Alternatively, if we have 16 IPs per subnet, the broadcast address is 15 IPs above the start of the subnet.  192 + 15 = 207.
    
    Lets do another example:
    
    What is the broadcast address for well-formed CIDR 56.127.2.128/26?
    
    The prefix of /26 covers the first three octets, so it our answer starts with 56.127.2.
    
    A /26 has 64 IPs.  1 less than that is 63.  128 + 63 is 191.
    
    So our broadcast IP is 56.127.2.191.
    
    
    Lets do a hard example:
    
    What is the broadcast address for well-formed CIDR 56.127.8.0/22?
    
    The /22 covers only the first two octets, so our broadcast address starts with 56.127.
    
    The last octet is all host addresses, which are all set to 1 for the broadcast address.  So the last octet of our broadcast address is .255     Any IPv4 CIDR with a prefix length between /0 and /24 has a broadcast address ending in .255!
    
    But what about the third octet?
    
    `Binary: 00001000`
    `Mask:   11111100`
    Setting the host bits (the last 2 on the right) to 1:
    `3rd oc: 00001011 = .11`
    
    So the broadcast address for 56.127.8.0/22 is 56.127.11.255
    
    Another way to calculate that is to remember that a /22 contains four /24s.  So our subnet ranges from 56.127.8.0 - 56.127.11.255.  And the highest IP address in the subnet is the broadcast address for the subnet.
    
    /31 and /32 are special cases uses by network engineers.  A /31 is uses only for point-to-point links and do not use a broadcast address.  A /32 is a loopback address on a router, and also does not use a broadcast address.  This training program will not ask you to calculate a broadcast address for those special cases.
    
    If you ever need to calculate the broadcast IP for a CIDR which is not well formed, convert it to a well-formed CIDR (with the hosts bits all set to 0) first.  Then it is easy to add the number of IPs in the subnet, subtract 1, and get the broadcast IP.
    """
}

struct IPv4Cidr2BroadcastHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv4Cidr2BroadcastHelp()
    }
}
