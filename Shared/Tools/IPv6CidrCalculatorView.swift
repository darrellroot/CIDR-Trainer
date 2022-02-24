//
//  IPv6CidrCalculatorView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/24/22.
//

import SwiftUI

struct IPv6CidrCalculatorView: View {
    @State var input = ""
    @State var cidr: IPv6Cidr? = nil
    
    var body: some View {
        VStack {
            List {
                Section("Input or paste CIDR") {
                    HStack {
                        TextField("",text: $input)
                            .keyboardType(.numbersAndPunctuation)
                            .disableAutocorrection(true)
                            .foregroundColor(cidr == nil ? .red : .primary)
                    }
                    .onChange(of: input) { value in
                        cidr = IPv6Cidr(cidr: input)
                    }
                }
                
                Section("Results") {
                    Text(wellFormedCidr)
                    Text(networkAddress)
                    Text(lastIp)
                }
            }
            Button {
                copyToClipboard()
            } label: {
                Text("Copy To Clipboard")
            }.buttonStyle(.borderedProminent)
                .disabled(cidr == nil)
            Spacer()
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("IPv6 CIDR Calculator")
    }
    
    var wellFormedCidr: String {
        return "Well Formed CIDR: \(cidr?.wellFormedCidrString ?? "")"
    }
    
    var networkAddress: String {
        return "Network Address: \(cidr?.networkIPv6.debugDescription ?? "")"
    }
    
    var lastIp: String {
        return "Last IP: \(cidr?.highestIPv6.debugDescription ?? "")"
    }
    
    func copyToClipboard() {
        let result = """
            Input: \(input)
            \(wellFormedCidr)
            \(networkAddress)
            \(lastIp)
            """
        UIPasteboard.general.setValue(result, forPasteboardType: "public.plain-text")
    }
}

struct IPv6CidrCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        IPv6CidrCalculatorView()
    }
}
