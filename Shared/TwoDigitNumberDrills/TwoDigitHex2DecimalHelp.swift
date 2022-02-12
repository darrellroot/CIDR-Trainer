//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

// this is used for
import SwiftUI

struct TwoDigitHex2DecimalHelp: View {
    
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
    ***2-Digit Hex to Decimal Conversion***
    
    Converting from 2-digit hexadecimal to decimal numbers is difficult, but there is a trick.
    
    Remember when we "counted by 16s" to convert from hex to decimal?
    
    0x10 -> 16
    0x20 -> 32
    0x30 -> 48
    0x40 -> 64
    0x50 -> 80
    0x60 -> 96
    0x70 -> 112
    0x80 -> 128
    0x90 -> 144
    0xa0 -> 160
    0xb0 -> 176
    0xc0 -> 192
    0xd0 -> 208
    0xe0 -> 224
    0xf0 -> 240
    
    To convert a 2-digit hex number to decimal, use the "count by 16 trick" to convert the first hex digit to decimal.  Then add the value of the 2nd hex digit.
    
    Lets convert hex 0xca to decimal.
    
    0xc0 is 192.
    Add the value of 0xa (10).
    
    202!
    
    Go back to the "2-digit hex -> decimal (easy)" drill if you need more practice "counting by 16's".
    """
    
}

struct TwoDigitHex2DecimalHelp_Previews: PreviewProvider {
    static var previews: some View {
        TwoDigitHex2DecimalHelp()
    }
}
