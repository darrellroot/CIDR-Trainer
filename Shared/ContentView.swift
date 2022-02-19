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
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var body: some View {
        NavigationView {
            List {
                Section("Preliminary Skills") {
                    NavigationLink("1-Digit Hex and Binary Drills", destination: OneDigitNumberDrillsView())
                    NavigationLink("2-Digit Hex and Binary Drills", destination: TwoDigitNumberDrillsView())
                }
                Section("IPv4") {
                    NavigationLink("IPv4 Terminology Drills", destination: IPv4TerminologyDrillsView())
                    NavigationLink("IPv4 Prefix Length Drills", destination: IPv4PrefixLengthDrillsView())
                    NavigationLink("IPv4 CIDR Drills", destination: IPv4CidrDrillsView())
                }
                Section("Other") {
                    NavigationLink("Support and Settings",destination: OtherViewsView())
                }
            }
            
            .navigationTitle("CIDR Trainer")
            
        }.onAppear {
            print("vertical size class \(String(describing: verticalSizeClass))")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
