//
//  OneDigitDecimalBinaryHelp.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct OneDigitBinaryHelp: View {
    
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
    ***4-digit binary conversion help***
    
    **Purpose:**
    
    A binary digit has 2 values: 0 and 1.  An IPv4 address is composed of 32 binary digits.  Fluency with binary numbers is essential for CIDR calculations.
    
    **Values:**
    
    Consider the decimal number 23.  The 3 is in the "ones digit".  The 3's value is therefore 3 * 1 = 3.  The 2 is in the "tens digit".  The 2's value is 2 * 10 = 20.  So the value of 23 is 20 + 3 = 23.
    
    Yes that seems trivial, but thats because you learned that in grade school.  Most importantly, each digit is 10x the value of the digit to the right of it.  That is why they are called "decimal" numbers".
    
    Consider the binary number 1011.  The rightmost 1 is the "ones digit".  It's value is 1 * 1 = 1.  But the 2nd 1 from the right is the "twos digit".  *In binary each digit is 2x the value of the digit to its right.*  So the 2nd 1 from the right has a value of 2 * 1.   The 0 is in the "fours digit".  Because it is 0 its value is 4 * 0.   The leftmost one is in the "eights digit".  Its value is 8 * 1 = 8.
    
    So the binary number 1011's value is (adding from leftmost digit to rightmost digit): 8 * 1 + 4 * 0 + 2 * 1 + 1 * 1.  As always multiplication comes before addition so that is 8 + 0 + 2 + 1 = 11 (decimal)
    
    To avoid confusion, sometimes binary numbers are prefaced with 0b.  So 0b1011 is the binary number 1011.  This is similar to 0xe which represents the hexadecimal number e (value of 14 in decimal).  Decimal numbers do not have a prefix.
    
    Here is a full conversion table between decimal and binary numbers.  I always show 4 binary digits (even though leading binary 0's would normally be removed).  I also show the value calculation in parenthesis to the right.
    
    `0. 0000`
    `1. 0001 (1 * 1)`
    `2. 0010 (2 * 1)`
    `3. 0011 (2 * 1 + 1 * 1)`
    `4. 0100 (4 * 1)`
    `5. 0101 (4 * 1 + 1 * 1)`
    `6. 0110 (4 * 1 + 2 * 1)`
    `7. 0111 (4 * 1 + 2 * 1 + 1 * 1)`
    `8. 1000 (8 * 1)`
    `9. 1001 (8 * 1 + 1 * 1)`
    `10. 1010 (8 * 1 + 2 * 1)`
    `11. 1011 (8 * 1 + 2 * 1 + 1 * 1)`
    `12. 1100 (8 * 1 + 4 * 1)`
    `13. 1101 (8 * 1 + 4 * 1 + 1 * 1)`
    `14. 1110 (8 * 1 + 4 * 1 + 2 * 1)`
    `15. 1111 (8 * 1 + 4 * 1 + 2 * 1 + 1 * 1)`
    
    Here is the exact same table with hexadecimal digits to the left.
    
    `0. 0000`
    `1. 0001 (1 * 1)`
    `2. 0010 (2 * 1)`
    `3. 0011 (2 * 1 + 1 * 1)`
    `4. 0100 (4 * 1)`
    `5. 0101 (4 * 1 + 1 * 1)`
    `6. 0110 (4 * 1 + 2 * 1)`
    `7. 0111 (4 * 1 + 2 * 1 + 1 * 1)`
    `8. 1000 (8 * 1)`
    `9. 1001 (8 * 1 + 1 * 1)`
    `a. 1010 (8 * 1 + 2 * 1)`
    `b. 1011 (8 * 1 + 2 * 1 + 1 * 1)`
    `c. 1100 (8 * 1 + 4 * 1)`
    `d. 1101 (8 * 1 + 4 * 1 + 1 * 1)`
    `e. 1110 (8 * 1 + 4 * 1 + 2 * 1)`
    `f. 1111 (8 * 1 + 4 * 1 + 2 * 1 + 1 * 1)`

    One reason hexadecimal digits are used in networking is because each hexadecimal digit corresponds to exactly 4 bits.  This is why I'm showing leading zeroes even though a math textbook would not.  In networking, a hexadecimal digit represents 4 bits transmitted over the network, even if the leading bits were zeroes.
    
    In the "one digit binary" exercises, you will be presented with one decimal or hexadecimal digit and have to type in the corresponding binary digits.  This app has a special keyboard allowing you to type (or delete) 4 bits at a time.
    
    Conversely, you may be presented with 4 binary digits and need to type in the corresponding hexadecimal or decimal numbers.  For decimal, that may require 2 digits.
    
    Later exercises will require you to convert larger numbers (ranging from 0-255, which can be represented with two hexadecimal digits or eight binary digits).
    
    Click "Back" and try to convert to and from binary!
    """
}

struct OneDigitBinaryHelp_Previews: PreviewProvider {
    static var previews: some View {
        OneDigitBinaryHelp()
    }
}
