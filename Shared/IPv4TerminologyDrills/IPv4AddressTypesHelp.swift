//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct IPv4AddressTypesHelp: View {
    
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
    ***IPv4 Address Types***
    
    The IPv4 address 0.0.0.0 is sometimes called the "unspecified" address.  It is often used during boot when a host does not know its own IPv4 address yet.  But the terminology is not well defined so this program does not quiz on this name.
    
    Other IPv4 addresses with the first octet 0 (so 0.0.0.1 through 0.255.255.255) are known as "hosts on this network".  This is not commonly used any more, so this program does not quiz on this.
    
    IPv4 addresses starting with 127 are *loopback* addresses.  That includes the range 127.0.0.0 through 127.255.255.255.  The most commonly used loopback address is 127.0.0.1.  A host uses a loopback address to deliver network packets to itself.  This is often used in software testing or for two processes on the same host that need to communicate with each other.
    
    IPv4 addresses starting with 1 through 126, or 128 through 223, are *unicast* addresses.  That includes every IP from 1.0.0.0 through 126.255.255.255, and every IP from 128.0.0.0 through 223.255.255.255.  Each host on the network generally has at least one unicast address assigned to it.  A network packet sent to a unicast address will generally be delivered to one destination host.
    
    IPv4 addresses starting with 224 through 239 are *multicast* addresses.  The range is 224.0.0.0 through 239.255.255.255.  These are used for special applications where network packets may be sent from one host but delivered to multiple hosts.  A network packet may have a multicast destination, but never a multicast source.
    
    The IPv4 address 255.255.255.255 is the "broadcast" address.  It is used to deliver packets to every host on a specific local area network.
    
    IPv4 addresses starting with 240 through 255 (but not 255.255.255.255) are reserved for future use.  The range is 240.0.0.0 through 255.255.255.254.  Given the deployment of IPv6, it is likely they will never be used.
    
    To summarize:
    0.0.0.0   "Unspecified"
    0.0.0.1 - 0.255.255.255  "Hosts on this network"
    1.0.0.0 - 126.255.255.255  Unicast
    127.0.0.0 - 127.255.255.255  Loopback
    128.0.0.0 - 223.255.255.255  Unicast
    224.0.0.0 - 239.255.255.255  Multicast
    240.0.0.0 - 255.255.255.254  Reserved
    255.255.255.255  Broadcast
    
    """
}

struct IPv4AddressTypesHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv4AddressTypesHelp()
    }
}
