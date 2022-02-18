//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct IPv4NumberIpsHelp: View {
    
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
    ***Number of IPs in a CIDR***
    
    The number of IPv4 addresses in a CIDR depends on the prefix length.
    
    Every bit in the host portion of the CIDR doubles the number of possible IPs.
    
    A /24 netmask has 8 bits in the host portion, allowing 2 ^ 8 or 256 IPs.
    
    A /32 has 0 bits in the host portion, allowing 2 ^ 0 or 1 IP.
    
    A /16 has 16 bits in the host portion, allowing 65536 IPs.
    
    The number of IPs is different from the number of *usuable unicast IP addresses*.  When asked a question, make certain you understand whether they are asking for the number of IPs in the CIDR or the number of usable unicast addresses (also sometimes referred to as "number of hosts allowed on this subnet")
    
    Here is a table of number of IPs based on prefix length:
    
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

    `/16 -> 65536`
    This drill program will only ask number of IPs for the prefixes listed above.
    
    ***Number of usable unicast IPs in a CIDR***
    
    In each unicast subnet, two IPs are not usable by hosts:
    
    The IP where the host portion is all 0's (the network address).
    The IP where the host portion is all 1's (the broadcast address).
    
    That means for most subnets, the number of **usable unicast IPs for hosts** is 2 less than the number of IPs in the CIDR.
    
    There are two special cases:
    
    Network engineers may use a /32 for a router loopback address.
    Network engineers may use a /31 for a router-router point-to-point link.
    
    That results in the following table of **usable unicast IPs** in a subnet:
    
    `/32 -> 1  special case for network enginers`
    `/31 -> 2  special case for network engineers`
    `/30 -> 2`
    `/29 -> 6`
    `/28 -> 14`
    `/27 -> 30`
    `/26 -> 62`
    `/25 -> 126`
    `/24 -> 254`
    `/23 -> 510`
    `/22 -> 1022`
    
    `/16 -> 65534`

    """
}

struct IPv4NumberIpsHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv4NumberIpsHelp()
    }
}
