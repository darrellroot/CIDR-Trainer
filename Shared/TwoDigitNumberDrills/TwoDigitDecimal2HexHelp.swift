//
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

// this is used for
import SwiftUI

struct TwoDigitDecimal2HexHelp: View {
    
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
    ***Decimal to 2-digit Hex Conversion***
    
    Converting from decimal numbers (ranging from 0-255) to 2-digit hexadecimal numbers is difficult, but there is a trick.
    
    Remember when we "counted by 16s" to convert from decimal to hex?
    
    16 -> 0x10
    32 -> 0x20
    48 -> 0x30
    64 -> 0x40
    80 -> 0x50
    96 -> 0x60
    112 -> 0x70
    128 -> 0x80
    144 -> 0x90
    160 -> 0xa0
    176 -> 0xb0
    192 -> 0xc0
    208 -> 0xd0
    224 -> 0xe0
    240 -> 0xf0
    
    Lets convert decimal 221 to hex.  Can you remember which decimal number is evenly divisible by 16 and closest to 221 without going over?  208.  And you remember that corresponds to 0xd0.
    
    So the first hex digit is d!  Then you subtract 221 - 208 = 13.  That is the remainder that you need to account for with the 2nd hex digit.  13 in decimal is d in hex!
    
    So 221 in hex is 0xdd
    
    Feel free to go back to the "Decimal -> 2-digit hex (easy)" drill if you need more practice "counting by 16's".
    
    """
    
}

struct TwoDigitDecimal2HexHelp_Previews: PreviewProvider {
    static var previews: some View {
        TwoDigitDecimal2HexHelp()
    }
}
