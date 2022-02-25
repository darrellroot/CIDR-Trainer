//
//  IPv4CidrCalculatorView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/22/22.
//

import SwiftUI
import UniformTypeIdentifiers

struct IPv4CidrCalculatorView: View {
    @State var input = ""
    @State var cidr: IPv4Cidr? = nil
    
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
                        cidr = IPv4Cidr(cidr: input)
                    }
                }
                
                Section("Results") {
                    HStack {
                        Text("Well-Formed-Cidr: ").textSelection(.disabled)
                        Text(wellFormedCidr)
                    }
                    HStack {
                        Text("Network Address: ").textSelection(.disabled)
                        Text(networkAddress)
                    }
                    HStack {
                        Text("First IP: ").textSelection(.disabled)
                        Text(firstIp)
                    }
                    HStack {
                        Text("Last IP: ").textSelection(.disabled)
                        Text(lastIp)
                    }
                    HStack {
                        Text("First usable unicast IP: ").textSelection(.disabled)
                        Text(firstUsableIp)
                    }
                    HStack {
                        Text("Last usable unicast IP: ").textSelection(.disabled)
                        Text(lastUsableIp)
                    }
                    HStack {
                        Text("Broadcast Address: ").textSelection(.disabled)
                        Text(broadcastAddress)
                    }
                    HStack {
                        Text("Number of IPs: ").textSelection(.disabled)
                        Text(numberOfIps)
                    }
                    HStack {
                        Text("Number of usable unicast IPs: ").textSelection(.disabled)
                        Text(numberUsableIps)
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
        .navigationTitle("IPv4 CIDR Calculator")
    }
    
    var wellFormedCidr: String {
        return "\(cidr?.wellFormed.description ?? "")"
    }
    var networkAddress: String {
        return "\(cidr?.networkIp.ipv4 ?? "")"
    }
    var firstIp: String {
        if let cidr = cidr {
            return "\(cidr.firstIp.ipv4) (\(IPv4Cidr.addressType(ip: cidr.firstIp)))"
        } else {
            return ""
        }
    }
    
    var lastIp: String {
        if let cidr = cidr {
            return "\(cidr.lastIp.ipv4) (\(IPv4Cidr.addressType(ip: cidr.lastIp)))"
        } else {
            return ""
        }
    }

    var firstUsableIp: String {
        if cidr != nil && cidr!.cidrType == .unicast {
            return "\(cidr?.firstUsableIp.ipv4 ?? "")"
        } else {
            return ""
        }
    }
    var lastUsableIp: String {
        if cidr != nil && cidr!.cidrType == .unicast {
            return "\(cidr?.lastUsableIp.ipv4 ?? "")"
        } else {
            return ""
        }
    }
    var broadcastAddress: String {
        return "\(cidr?.broadcastIp.ipv4 ?? "")"
    }
    var numberOfIps: String {
        if cidr != nil {
            return "\(cidr!.numberIps)"
        } else {
            return ""
        }
    }
    var numberUsableIps: String {
        if cidr != nil  && cidr!.cidrType == .unicast {
            return "\(cidr!.numberUsableIps)"
        } else {
            return ""
        }
    }
    func copyToClipboard() {
        let result = """
            Input: \(input)
            Well-Formed-CIDR: \(wellFormedCidr)
            Network Address: \(networkAddress)
            First IP: \(firstIp)
            Last IP: \(lastIp)
            First usable unicast IP: \(firstUsableIp)
            Last usable unicast IP: \(lastUsableIp)
            Broadcast address: \(broadcastAddress)
            Number of IPs: \(numberOfIps)
            Number of usable unicast IPs: \(numberUsableIps)
            
            """
        UIPasteboard.general.setValue(result, forPasteboardType: "public.utf8-plain-text")

    }
}

struct IPv4CidrCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        IPv4CidrCalculatorView()
    }
}
