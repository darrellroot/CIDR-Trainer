//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct IPv4Cidr2UsableIpHelp: View {
    
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
    ***CIDR to Usable IPs***
    
    Not all IPv4 addresses in a CIDR are usable unicast IP addresses.
    
    The IP address with all host bits set to 0 represents the "network address".  This is not a usable unicast IP address for a host on the network.
    
    The IP address with all host bits set to 1 represents the "broadcast address".  This is also not a usable unicast IP address for a host on the network.
    
    For most subnets, the **first usable IP** is 1 greater than the network ip.
    
    For example, in 192.168.3.0/24, the first usable IP address is 192.168.3.1.
    
    The **last usable IP** is 1 below the broadcast IP.
    
    For example, in 192.168.3.0/24, the broadcast IP is 192.168.3.255.  So the last usable IP is 192.168.3.254.
    
    Consider 10.3.4.64/29.  This is a /29 so it has 8 IPs:
    
    `10.3.4.64: network IP.  Not usable`
    `10.3.4.65: First usable IP`
    `...`
    `10.3.4.70: Last usable IP`
    `10.3.4.71: Broadcast IP for 10.3.4.64/29`
    `10.3.4.72: Start of the next subnet 10.3.4.72/29`
    
    **Special case for /31 and /32**
    
    To save address space, network engineers can use /31 CIDRs for point-to-point links between network devices.  Point-to-point links do not have a broadcast and do not reserve the network IP.  So in 192.168.3.12/31, the first usable IP is 192.168.3.12 and the last usable IP is 192.168.3.13.  In other words, every IP (both of them!) are usable in a /31.
    
    Network engineers can also use a /32 CIDR as a loopback interface on a network router.  A /32 has one IPv4 address and it is usable, but only for this special case.
    
    This training application will not ask for "usable IP addresses" for the /31 or /32 special cases.
    """
}

struct IPv4Cidr2UsableIpHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv4Cidr2UsableIpHelp()
    }
}
