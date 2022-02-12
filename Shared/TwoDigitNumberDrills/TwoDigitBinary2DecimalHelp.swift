//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

// this is used for
import SwiftUI

struct TwoDigitBinary2DecimalHelp: View {
    
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
    ***8-digit Binary to Decimal Conversion***
    
    Converting an 8-digit binary number to decimal is work and often requires a pen and paper.
    
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
    
    To convert an 8-digit binary number to decimal, we just add the values of whichever bits are set.
    
    Lets convert the binary number 11010011 to decimal
    
    The 128-digit (leftmost) is set
    The 64-digit (2nd left) is set
    
    The 16-digit (4th left) is set
    
    The 2-digit (2nd right) is set
    The 1-digit (rightmost) is set
    
    128 + 64 + 16 + 2 + 1 = 211
    
    This is easier than converting from decimal -> binary (which requires subtraction), but it is still easy to make an error doing this manually.  I suggest using a pen and paper.
    
    In production, I suggest using a calculator (to avoid human error), but it is important to practice the procedure to fully understand CIDR calculations.
    """
    
}

struct TwoDigitBinary2DecimalHelp_Previews: PreviewProvider {
    static var previews: some View {
        TwoDigitBinary2DecimalHelp()
    }
}
