//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

// this is used for
import SwiftUI

struct TwoDigitHex2BinaryHelp: View {
    
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
    ***2-digit Hexadecimal to Binary Conversion***
    
    You already know how to convert a 1-digit hexadecimal number to binary.
    
    You follow the exact same procedure to convert a 2-digit hexadecimal number to binary.  You just do it twice!
    
    The left hex digit will turn into the leftmost four binary digits.
    
    The right hex digit will turn into the rightmost four binary digits (provided you leave the leading zeroes there).
    
    Do *not* convert the 2-digit hex number to decimal.  That's more work!  You may convert each 1-digit hex number to decimal to binary in your head if that makes it easier.  Just do it twice: once for each digit.
    
    Here's an example:
    
    `0xe -> 14 -> 0b1110`
    `0x4 -> 4  -> 0b0100`
    `0xef -> "14 4" -> 0b1110 0100 -> 0b11100100`
    
    This can go in reverse to convert an 8-digit binary number to a 2-digit hexadecimal number.
    
    `0b1100 -> 12 -> 0xc`
    `0b0101 -> 5 -> 0x5`
    `0b11000101 -> 0b1100 0101 -> 0xc 5 -> 0xc5`
    
    This is why hexadecimal numbers are so useful in networking.  Each 4 bits can be represented by 1 hexadecimal digit.  Each 4 bits can be converted independently of the digits to the left or right.
    
    By contrast, converting decimal 173 to binary is hard.  We will cover that in a later session.

    """
    
}

struct TwoDigitHex2BinaryHelp_Previews: PreviewProvider {
    static var previews: some View {
        TwoDigitHex2BinaryHelp()
    }
}
