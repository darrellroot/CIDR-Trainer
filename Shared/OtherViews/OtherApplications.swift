//
//  OneDigitDecimalBinaryHelp.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct OtherApplications: View {
    
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
    ***Other Network Mom LLC Applications***
    
    **Network Mom ACL Analyzer**
    
    Do you have large Cisco access-lists?
    When you receive a request to permit a new socket through your ACL, can you determine if it is already permitted?
    Do you suspect you have earlier lines in your ACLs which match supersets of later lines?
    Are you worried that you may have netmask-format lines in a wildcard-format ACL?
    
    If yes, you need *Network Mom ACL Analyzer*
    
    It supports ACL formats on several Cisco platforms, including both wildcard and netmask format.
    It supports IPv4 and IPv6!
    US price is only $10 in the MacOS App Store.
    [https://apps.apple.com/us/app/network-mom-acl-analyzer/id1472093792?mt=12](https://apps.apple.com/us/app/network-mom-acl-analyzer/id1472093792?mt=12)
    
    **Network Mom Availability**
    
    Do you want an easy-to-use GUI tool to ping devices from your Mac?
    
    Do you want periodic reports showing network availability?
    
    Do you want to import lists of devices via text (in either IP address or domain-name format).
    
    Network Mom Availability is only $10 in the MacOS App Store.  It can only ping targets (via IPv4 and IPv6).  It does not support HTTP or other application monitoring.  Its alerting is via email which can be problematic given anti-spam defenses.
    
    But it pings very efficiently (over 1000 targets tested without significant CPU use).
    
    So if you want an inexpensive tool to test that your 742 network devices are pingable, Network Mom Availability is a quick way to get it done at a reasonable cost.
    
    [https://apps.apple.com/us/app/network-mom-availability/id1451571383?mt=12](https://apps.apple.com/us/app/network-mom-availability/id1451571383?mt=12)
    
    """
}

struct OtherApplications_Previews: PreviewProvider {
    static var previews: some View {
        OtherApplications()
    }
}
