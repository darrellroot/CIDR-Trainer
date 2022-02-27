//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct IPv6AddressTypesHelp: View {
    
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
    ***IPv6 Address Types***
    
    All IPv6 addresses are 128 bits, regardless of whether the textual representation of the address is shortened.
    
    Each address type is in a specific range.  Here are the IPv6 address types:
    
    `Unspecified:      ::/128`
    `Loopback:         ::1/128`
    `IPv4-mapped:      ::ffff/96`
    `Global unicast:   2000::/3`
    `Unique-local:     fc00::/7`
    `Link-Local:       fe80::/10`
    `Multicast:        ff00::/8`
    `Unknown:          everything else`
    
    Here is an explanation in detail for each:
    
    `Unspecified:      ::/128`
    When a host is first booting, it may not have learned its IPv6 address yet.  During this time, certain protocols will use the IPv6 address with 128 binary zeros.  This is the *unspecified* address.  Because the address is all zeros, it shortens to ::
    
    `Loopback:         ::1/128`
    The IPv6 address with 127 binary 0's followed by one binary 1 is the loopback address.  This is used by computers to communicate with itself.  Unlike IPv4, IPv6 has exactly one loopback address.  This address shortens to ::1
    
    `IPv4-mapped:      ::ffff/96`
    An "IPv4-mapped IPv6 address" is an IPv6 address that contains an embedded IPv4 address in the bottom 32 bits.  The first 80 bits are binary zeros, followed by 16 binary ones, followed by the 32 bits representing the IPv4 address.
    
    Some operating systems may display the bottom 32 bits in a 4-octet format similar to an IPv4 address.  That means that this is a valid IPv6 address representation:
    `::ffff:192.168.4.33`
    
    IPv4-mapped IPv6 addresses are used by some IPv6-only networks to communicate with IPv4-only destinations.  A protocol translation device is required.
    
    `Global unicast:   2000::/3`
    As of 2022, all globally unique IPv6 addresses are inside 2000::/3.  That means the first 3 bits are 001.  So these addresses could start with the first hex digit 2 (0010 binary) or 3 (0011 binary).
    
    `Unique-local:     fc00::/7`
    All IPv6 addresses starting with binary 1111110 are *unique-local*  These are unicast addresses which you can use within your organization, but cannot route on the Internet.
    
    All IPv6 addresses starting with fc (binary 11111100) or fd (binary 11111101) are unique-local.  Each enterprise is supposed to pick a random /48 inside this /7 and limit their use to that /48.  If two companies merge, it is unlikely they picked the same /48, so their addresses are unlikely to overlap.
    
    `Link-Local:       fe80::/10`
    All IPv6 addresses starting with binary 1111111010 are link-local.  While this could include first hextet ranging from fe80 through febf, in practice hosts self-assign link-local addresses inside fe80:0000:0000:0000::/64 on each interface.
    
    For example, my workstation currently has the following link-local addresses on various interfaces:
    
    fe80::1 (loopback interface link-local)
    fe80::38a3:31ff:fe05:83d4
    fe80::38a3:31ff:fe05:83d3
    fe80::461:b2a8:db42:3587
    fe80::a888:31ff:febe:a061
    and so on...
    
    Link-local IPv6 addresses are used for communicating on a specific LAN, but packets with link-local destination addresses are never forwarded by routers to other networks.
    
    In most IPv6 access networks, your "default route" will be a link-local address!  A packet's destination address may be a global-unicast address, but the packet can be forwarded to the ethernet address of a link-local address.
    
    `Multicast:        ff00::/8`
    
    All IPv6 addresses starting with binary 11111111 (hexadecimal ff) are multicast.
    
    `Unknown:          everything else`
    
    The majority of IPv6 addresses are not in any of the above categories and are reserved for future use.
    
    The following categories of IPv6 addresses are deprecated.  This app does not test on them, but it is good to be aware of them:
    
    `site-local:        fec0::/10`
    That includes all IPv6 addresses starting with fec, fed, fee, and fef.
    
    Site-local is similar to RFC1918 address space in IPv4.  It is deprecated because if two companies merge, they may have overlapping side-local space.  It was replaced with unique-local where each site would pick a random /48 inside fc00::/7.
    
    `IPv4-compatible IPv6 addresses:  ::/96`
    (but not including :: or ::1)
    
    This was an old transition mechanism where the first 96 bits are 0 and the last 32 bits correspond to an IPv4 address.
    
    Some computers still display IP addresses in this range in the following format:
    `::192.168.3.4`
    This could correspond to
    `::c0a8:0304`
    
    IPv4-compatible IPv6 addresses are deprecated in favor of IPv4-mapped IPv6 addresses inside ::ffff:0:0/96
    """
}

struct IPv6AddressTypesHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv4AddressTypesHelp()
    }
}
