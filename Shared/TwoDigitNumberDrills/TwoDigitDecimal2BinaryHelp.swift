//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

// this is used for
import SwiftUI

struct TwoDigitDecimal2BinaryHelp: View {
    
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
    ***Decimal to 8-digit Binary Conversion***
    
    Converting an integer between 0-255 from decimal to binary is *hard*.
    
    First, recall the value of each binary digit in an 8-digit binary number:
    
    Rightmost: 1 if set
    2nd right: 2 if set
    3rd right: 4 if set
    4th right: 8 if set
    5th right: 16 if set
    6th right: 32 if set
    7th right: 64 if set
    8th right: 128 if set
    
    The same table, but starting at the leftmost binary digit (this table only applies to 8-digit binary numbers):
    
    Leftmost: 128 if set
    2nd left: 64 if set
    3rd left: 32 if set
    4th left: 16 if set
    5th left: 8 if set
    6th left: 4 if set
    7th left: 2 if set
    8th left: 1 if set (this is also the rightmost)
    
    Lets convert the integer 211 to binary:
    
    The integer is >= 128. We set the leftmost digit to 1 and subtract 211-128 = 83.  Here's our binary number so far:
    
    1xxxxxxx
    
    83 is >= 64.  We set the 2nd leftmost digit to 1 and subtract 83-64 = 19.  Here's our binary number so far:
    
    11xxxxxx
    
    19 is not >= 32.  So the 3rd leftmost digit is 0.  No subtraction this step.
    
    110xxxxx
    
    19 is >= 16.  So the 4th leftmost digit is 1 and we subtract 19 - 16 = 3.
    
    1101xxxx
    
    3 is not >= 8, so 5th left digit is 0.  No subtraction.
    
    11010xxx
    
    3 is not >= 4, so 6th left digit is 0.  No subtraction.
    
    110100xx
    
    3 is >= 2, so 7th left digit is 1.  3-2 = 1:
    
    1101001x
    
    1 is >= 1, so 8th left digit (rightmost digit) is 1.  1-1 = 0.  We are done.
    
    11010011 (binary) = 211 (decimal).
    
    Yes that is hard and annoying.  This is why people use CIDR and binary calculators.  But it is important to understand the procedure.  I suggest using a pen and paper when practicing.
    
    You can even use your phone by saying "Hey Siri, convert 211 to binary".  I myself used that to double-check the calculation above while writing this documentation :-)
    
    During CIDR training we will start by converting all four IPv4 octets from decimal to binary.  But we will quickly learn that it is only necessary to convert (at most) one octet from decimal to binary for each CIDR calculation.
    
    One advantage of IPv6 is that IPv6 addresses are in hexadecimal format rather than "dotted decimal" format.  This makes bitwise math easier (even if the addresses themselves are longer and, at first glance, more intimidating).
    """
    
}

struct TwoDigitDecimal2BinaryHelp_Previews: PreviewProvider {
    static var previews: some View {
        TwoDigitHex2BinaryHelp()
    }
}
