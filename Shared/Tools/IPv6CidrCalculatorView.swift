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
                    HStack {
                        Text("Well-Formed-CIDR: ").textSelection(.disabled)
                        Text(wellFormedCidr)
                    }
                    HStack {
                        Text("Network Address: ").textSelection(.disabled)
                        Text(networkAddress)
                    }
                    HStack {
                        Text("Last IP: ").textSelection(.disabled)
                        Text(lastIp)
                    }
                }.textSelection(.enabled)
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
        return "\(cidr?.wellFormedCidrString ?? "")"
    }
    
    var networkAddress: String {
        return "\(cidr?.networkIPv6.description ?? "")"
    }
    
    var lastIp: String {
        return "\(cidr?.highestIPv6.description ?? "")"
    }
    
    func copyToClipboard() {
        let result = """
            Input: \(input)
            Well-Formed CIDR: \(wellFormedCidr)
            Network Address: \(networkAddress)
            Last IP: \(lastIp)
            """
        UIPasteboard.general.setValue(result, forPasteboardType: "public.utf8-plain-text")
    }
}

struct IPv6CidrCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        IPv6CidrCalculatorView()
    }
}
