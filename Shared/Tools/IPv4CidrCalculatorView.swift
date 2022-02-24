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
    
    
    func submit() {
        self.cidr = IPv4Cidr(cidr: input)
    }
    var body: some View {
        VStack {
            List {
                Section("Input or paste CIDR") {
                    HStack {
                        TextField("",text: $input)
                            .keyboardType(.numbersAndPunctuation)
                            .disableAutocorrection(true)
                            /*.onSubmit {
                                cidr = IPv4Cidr(cidr: input)
                            }*/
                        
                            /*.toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    HStack {
                                        Spacer()
                                        Button {
                                            submit()
                                        } label: {
                                            Image(systemName: "arrow.up").font(.title)
                                        }.buttonStyle(.bordered)
                                        Spacer()
                                        Button {
                                            input.append("/")
                                        } label: {
                                            Text("/").font(.title)
                                        }.buttonStyle(.bordered)
                                        Spacer()
                                    }
                                }
                            }*/
                    }
                    .onChange(of: input) { value in
                        cidr = IPv4Cidr(cidr: input)
                    }
                }
                
                Section("Results") {
                    Text("Well-formed CIDR: \(cidr?.wellFormed.description ?? "") ")
                    Text("Network Address: \(cidr?.networkIp.ipv4 ?? "")")
                    Text("First usable IP: \(cidr?.firstUsableIp.ipv4 ?? "")")
                    Text("Last usable IP: \(cidr?.lastUsableIp.ipv4 ?? "")")
                    Text("Broadcast Address: \(cidr?.broadcastIp.ipv4 ?? "")")
                    
                    (cidr != nil && cidr!.unicast) ?
                    Text("Number of IPs: \(cidr!.numberIps)")
                    :
                    Text("Number of IPs: ")
                    
                    (cidr != nil && cidr!.unicast) ?
                    Text("Number usable IPs: \(cidr!.numberUsableIps)")
                    :
                    Text("Number usable IPs: ")
                }
                
                
            }
            Spacer()
            //CidrV4KeyboardView(input: $input,submit: submit)
        }
    }
}

struct IPv4CidrCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        IPv4CidrCalculatorView()
    }
}
