//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

// this is used for
import SwiftUI

struct TwoDigitHexadecimalEasyHelp: View {
    
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
    ***2-digit Hexadecimal Digits (Easy) ***
    
    Remember how the decimal number 23 has a value of 2 * 10 + 1 * 3?  The 2 is in the "tens" digit and the 3 is in the "ones" digit.  Each digit represents 10x the value of the digit to the right.  That's why they call it *Decimal*.
    
    Multi-digit hexadecimal numbers are like that, except each digit is 16x the value of the digit to the right.  So the value of 0x23 is 2 * 16 + 3.  The two is in the "sixteens" digit.
    
    In the three-digit hexadecimal number 0x423, the 4 represents 256 * 4 (because that position's value is 16 * 16 = 256).  So 0x423 is equivalent to 4 * 256 + 2 * 16 + 3 = 1024 + 32 + 3 = 1059.
    
    Converting even 2-digit hexadecimal numbers to decimal is hard without a calculator, but it is possible with practice.  We will start with "easy ones" where the ones digit is 0.
    
    Here's a table showing the conversion.  In effect, we are "counting by sixteens".
    
    `0x00. 0`
    `0x10. 16`
    `0x20. 32`
    `0x30. 48`
    `0x40. 64`
    `0x50. 80`
    `0x60. 96`
    `0x70. 112`
    `0x80. 128`
    `0x90. 144`
    `0xa0. 160`
    `0xb0. 176`
    `0xc0. 192`
    `0xd0. 208`
    `0xe0. 224`
    `0xf0. 240`

    I suggest 10 minutes of drill to become fluent with these conversions.  One goal is, given any decimal number between 0 and 255, to know instinctively which multiple of 16 is immediately below it.  For example, given the number 203, you should recognize that 192 is the closest multiple of 16 below it.
    
    """
    
}

struct TwoDigitHexadecimalEasyHelp_Previews: PreviewProvider {
    static var previews: some View {
        TwoDigitHexadecimalEasyHelp()
    }
}
