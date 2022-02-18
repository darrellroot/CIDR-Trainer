//
//  OneDigitDecimalBinaryHelp.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import SwiftUI

struct BitwiseAndHelp: View {
    
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
    ***Bitwise AND Help***
    
    **Purpose:**
    
    Later in the course, you will learn to calculate the network number for a CIDR address (such as 10.12.14.117/24) by performing a *bitwise AND* between the IP address 10.12.14.117 and the netmask 255.255.255.0.  These will be done in binary.
    
    We will start doing bitwise AND with single bits, and then 8-bits.  Later we will theoretically need to do it with 32-bits, but we will learn shortcuts.
    
    **Procedure:**
    
    For a single bit, the AND operation results in 1 if both the first and second bit are 1.  Otherwise, it results in 0.  In other words:
    
    `0 AND 0 = 0`
    `0 AND 1 = 0`
    `1 AND 0 = 0`
    `1 AND 1 = 1`
    
    For groups of bits, a *bitwise AND* operation repeats that calculation for each of the bits in sequence.  Here's an example with 8-bits AND 8-bits resulting in 8-bits.  To ease our calculations, we put the bits over each other vertically:
    
    `00101101`
    `  AND  `
    `11111000`
    `   =    `
    `00101000`
    
    The only two bits *set* (meaning 1) at the result correspond to bits which were set in BOTH the inputs.
    
    You'll also note that the 2nd input to our AND started with all 1's and ended with all 0's.  While that is not necessary for arbitrary bitwise AND operations, we will practice that way because network masks (introduced later) are arranged that way.
    
    *Hint:*
    
    Because our 2nd input has all 1's to the left and all 0's to the right, the left part of our first input will be unchanged.  The right part will be set to 0.  The only question is how many bits are unchanged.  That is determined by the number of 1 bits in the 2nd input.
    """
}

struct BitwiseAndHelp_Previews: PreviewProvider {
    static var previews: some View {
        BitwiseAndHelp()
    }
}
