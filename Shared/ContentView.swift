//
//  ContentView.swift
//  Shared
//
//  Created by Darrell Root on 2/3/22.
//

import SwiftUI

struct ContentView: View {
    //@ObservedObject var model: Model
    @EnvironmentObject private var store: Store

    var body: some View {
        NavigationView {
            List {
                Section("IPv4") {
                    NavigationLink("1-Digit Hexadecimal and Binary Drills", destination: OneDigitNumberDrillsView())
                    NavigationLink("2-Digit Hexadecimal and Binary Drills", destination: TwoDigitNumberDrillsView())
                    NavigationLink("IPv4 Terminology Drills", destination: IPv4TerminologyDrillsView())
                    NavigationLink("IPv4 Prefix Length Drills", destination: IPv4PrefixLengthDrillsView())
                    NavigationLink("IPv4 CIDR Drills", destination: IPv4CidrDrillsView())
                }
                Section("Other") {
                    NavigationLink("Support, Settings, Contacts, and Credits",destination: OtherViewsView())
                }
            }
            
            .navigationTitle("CIDR Trainer")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
