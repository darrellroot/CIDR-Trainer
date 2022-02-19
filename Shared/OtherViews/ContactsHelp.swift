//
//  OneDigitDecimalBinaryHelp.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct ContactsHelp: View {
    
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
    ***CIDR Trainer Support and Credits***
    
    CIDR Trainer is written by Darrell Root and sold by Network Mom LLC.
    
    If you like this app, please leave a positive review!
    
    If you need support, have a feature request, or other feedback, we would love for you to email feedback@networkmom.net
    
    I am grateful to the iOS developer community.  In particular:
    Paul Hudson https://www.hackingwithswift.com/
    Mark Moeykens https://bigmountainstudio.com/
    John Sundell https://www.swiftbysundell.com/
    
    And (of course) to all my former coworkers at Apple who brought MacOS, iOS, Swift, and SwiftUI to the world!
    """
}

struct ContactsHelp_Previews: PreviewProvider {
    static var previews: some View {
        ContactsHelp()
    }
}
