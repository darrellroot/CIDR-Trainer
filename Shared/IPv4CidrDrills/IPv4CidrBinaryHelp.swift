//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct IPv4CidrBinaryHelp: View {
    
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
    ***Calculating the IPv4 Network from a CIDR***
    
    An arbitrary IPv4 CIDR may have a non-zero host portion.  To calculate the network address, you need to do a bitwise-AND between the IPv4 address and the network mask.
    
    For example, consider 176.164.162.89/24:
    
    `IP:   10110000 10100100 10100010 01011001`
    `Mask: 11111111 11111111 11111111 00000000`
    `I&M:  10110000 10100100 10100010 00000000`
    `Resulting network ip: 176.164.162.0`
    `"Well-formed" CIDR: 176.164.162.0/24`
    
    Because the prefix-length was a /24, the first three octets were entirely covered by the network-mask.  That meant those three octets were unchanged after performing the bitwise AND.  So converting 176.164.162.89 to binary was not necessary for the first three octets!
    
    Also because of the /24, the last octet network mask was entirely 0s'.  So the network address' last octet was guaranteed to be 0.  Converting the last .89 to binary was also not necessary!
    
    In general, any time you calculate a network address from an arbitrary CIDR, at least 3 octets are the "easy cases" where the mask is always 1 or 0.  Converting the CIDR to binary is, at most, necessary for one octet.  This is a big time-saver!
    
    Consider the harder case 92.130.133.84/22:
    
    `IP:   01011100 10000010 10000101 01010100`
    `Mask: 11111111 11111111 11111100 00000000`
    `I&M:  01011100 10000010 10000100 00000000`
    `Resulting network ip: 92.130.132.0`
    `"Well-formed" CIDR: 92.130.132.0/22`
    
    In this case the network mask completely covered the first two octets.  So we can determine our network ip started with 92.130. without doing any bit conversions.
    
    The network mask did not cover any of the fourth octet.  So the last octet of our network IP had to be 0.
    
    The network mask included the first six bits of the 3rd octet.  We needed to convert .133 to binary to determine that the 3rd octet of our network IP was 132.
    
    Our next example: 48.72.102.144/26:
    
    We know the network-mask completely covers the first three octets.  So our resulting network IP starts with 48.72.102.
    
    Here is the calculation for our last octet: .144:
    `Octet:  10010000`
    `Mask:   11000000   (our prefix is /26, so 2 mask bits in 4th octet)`
    `Result: 10000000 = 128`
    
    `Resulting network ip: 48.72.102.128`
    `"Well-formed" CIDR: 48.72.102.128/26`
    
    Another trick useful for prefix-lengths between /25 and /31 is remembering how many IPs are in a particular subnet size.  As a reminder:
    
    `/31 2`
    `/30 4`
    `/29 8`
    `/28 16`
    `/27 32`
    `/26 64`
    `/25 128`
    
    For those prefix-lengths, a network IP will always end with a multiple of that number.  For example, a /25 network address will always end in .0 or .128
    
    Here are the valid endings for the prefixes:
    
    `/25  .0   .128`
    `/26  .0  .64  .128  .192`
    `/27  .0  .32  .64  .96  .128  .160  .192  .224`
    `/28  (evenly divisible by 16)`
    `/29  (evenly divisible by 8)`
    `/30  (evenly divisible by 4)`
    `/31  (any even last octet)`
    
    The last octet of the network IP will be the closest even multiple **less than or equal** to the original IP.
    
    Calculate 155.191.116.69/27's network IP:
    
    First three octets are unchanged, so 155.191.116.
    It's a /27, so last octet has to be an even multiple of 32 less than .69.
    .64 is the closest even multiple of 32 less than .69.
    
    Resulting network IP: 155.191.116.64
    Resulting "well formed" CIDR: 155.191.116.64/27
    
    No bit arithmetic needed!
    
    Our next example: 78.170.99.131/23
    
    First two octets are completely covered by the network mask, so 78.170.
    Last octet is not covered at all by the mask, so .0
    How do we calculate the network IP for the third octet?
    
    How many /24's would fit in a /23?
    A /24 has 256 IPs.  A /23 has 512 IPs.  So 2 /24's would fit in a /23.
    
    So the 3rd octet of our network IP has to be evenly divisible by 2 (and below .99).  Answer: .98
    
    Final answer: 78.170.99.131/23's network IP is 78.170.98.0
    
    Here are how many /24's fit in each of these prefix lengths:
    
    `/23  2`
    `/22  4`
    `/21  8`
    `/20 16`
    
    I could go on, but it is rare to run into larger CIDRs.
    
    So the 3rd octet network IP of any /23 is even.
    The 3rd octet network IP of any /22 is evenly divisible by 4.
    The 3rd octet network IP of any /21 is evenly divisible by 8.

    For reference, the February 2022 version of this application only drills on CIDRs which are /16's, or /22 through /32.
    """
}

struct IPv4CidrBinaryHelp_Previews: PreviewProvider {
    static var previews: some View {
        IPv4CidrBinaryHelp()
    }
}
