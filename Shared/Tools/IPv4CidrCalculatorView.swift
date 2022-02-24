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
                    Text(wellFormedCidr)
                    Text(networkAddress)
                    Text(firstIp)
                    Text(lastIp)
                    Text(firstUsableIp)
                    Text(lastUsableIp)
                    Text(broadcastAddress)
                    Text(numberOfIps)
                    Text(numberUsableIps)
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
        .navigationTitle("IPv4 CIDR Calculator")
    }
    
    var wellFormedCidr: String {
        return "Well Formed CIDR: \(cidr?.wellFormed.description ?? "")"
    }
    var networkAddress: String {
        return "Network Address: \(cidr?.networkIp.ipv4 ?? "")"
    }
    var firstIp: String {
        if let cidr = cidr {
            return "First IP: \(cidr.firstIp.ipv4) (\(IPv4Cidr.addressType(ip: cidr.firstIp)))"
        } else {
            return "First IP:"
        }
    }
    
    var lastIp: String {
        if let cidr = cidr {
            return "Last IP: \(cidr.lastIp.ipv4) (\(IPv4Cidr.addressType(ip: cidr.lastIp)))"
        } else {
            return "Last IP:"
        }
    }

    var firstUsableIp: String {
        if cidr != nil && cidr!.cidrType == .unicast {
            return "First usable unicast IP: \(cidr?.firstUsableIp.ipv4 ?? "")"
        } else {
            return "First usable unicast IP:"
        }
    }
    var lastUsableIp: String {
        if cidr != nil && cidr!.cidrType == .unicast {
            return "Last usable unicast IP: \(cidr?.lastUsableIp.ipv4 ?? "")"
        } else {
            return "Last usable unicast IP:"
        }
    }
    var broadcastAddress: String {
        return "Broadcast Address: \(cidr?.broadcastIp.ipv4 ?? "")"
    }
    var numberOfIps: String {
        if cidr != nil {
            return "Number of IPs: \(cidr!.numberIps)"
        } else {
            return "Number of IPs:"
        }
    }
    var numberUsableIps: String {
        if cidr != nil  && cidr!.cidrType == .unicast {
            return "Number usable unicast IPs: \(cidr!.numberUsableIps)"
        } else {
            return "Number usable unicast IPs:"
        }
    }
    func copyToClipboard() {
        let result = """
            Input: \(input)
            \(wellFormedCidr)
            \(networkAddress)
            \(firstIp)
            \(lastIp)
            \(firstUsableIp)
            \(lastUsableIp)
            \(broadcastAddress)
            \(numberOfIps)
            \(numberUsableIps)
            
            """
        UIPasteboard.general.setValue(result, forPasteboardType: "public.plain-text")
    }
}

struct IPv4CidrCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        IPv4CidrCalculatorView()
    }
}
