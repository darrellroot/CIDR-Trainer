//
//  OneDigitHex2DecimalHelp.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

// this is used for
import SwiftUI

struct OneDigitHexadecimalHelp: View {
    
    var body: some View {
        ScrollView {
            Text(attributedString)
        }.padding()
        //HTMLStringView(htmlContent: htmlString)
    }
    
    let attributedString = try! AttributedString(markdown: OneDigitHexadecimalHelp.markdownString, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace))

    static let markdownString = """
    ***1-digit Hexadecimal Digits***
    
    **Purpose:**
    
    Hexadecimal digits have 16 values ranging from 0 through 15.  This makes them useful for representing 4 bits because 2^4 == 16.
    
    IPv4 addresses have 32 bits and can be represented by 8 hexadecimal characters (8 x 4 = 32).  Fluency with hexadecimal numbers is essential for CIDR calculations.
    
    **Values:**
    
    16 characters represent the 16 hexadecimal values: 0-9 and a-f:
    
    0. 0
    1. 1
    2. 2
    3. 3
    4. 4
    5. 5
    6. 6
    7. 7
    8. 8
    9. 9
    10. a
    11. b
    12. c
    13. d
    14. e
    15. f
    
    **Explanation:**
    
    Hexadecimal digits could be uppercase (A-F) or lowercase (a-f).  In this program we use lowercase but both are equivalent.
    
    To avoid confusion, hexadecimal numbers are often preceeded by "0x".  Example: 0x5 means "the hexadecimal digit 5" and 5 means "the decimal digit 5".  For single-digit hexadecimal numbers those are equivalent (at least until you get to a-f), but multi-digit numbers have  different values depending on whether they are decimal or hexadecimal (more on that in a later drill).
    
    The 1-digit decimal<->hexadecimal exercises present you with a number in one format and ask you to type in the equivalent number.
    
    As a trivial example, if the app presented you with 0x5 (the hexadecimal digit 5) you would be expected to type in 5.
    
    If the app presented you with 0xe, you would enter the corresponding decimal value 14.
    
    If the 1-digit decimal->hexadecimal drill presented you with 10, you would type in the hexadecimal digit a (which has the corresponding decimal value of 10).
    
    To repeat, here is the table showing the corresponding values between decimal and hexadecimal:

    0. 0
    1. 1
    2. 2
    3. 3
    4. 4
    5. 5
    6. 6
    7. 7
    8. 8
    9. 9
    10. a
    11. b
    12. c
    13. d
    14. e
    15. f
    
    Go back and give it a try!
    """
                                    
    let htmlString = """
    <h1>Header</h1>
    <h2>Small header</h2>
    body
    """
    
}

struct OneDigitHexadecimalHelp_Previews: PreviewProvider {
    static var previews: some View {
        OneDigitHexadecimalHelp()
    }
}
