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
    @Environment(\.managedObjectContext) var moc
    // used to detect when we go into background
    // see https://www.hackingwithswift.com/books/ios-swiftui/how-to-be-notified-when-your-swiftui-app-moves-to-the-background
    @Environment(\.scenePhase) var scenePhase

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
                Section("IPv6") {
                    NavigationLink("IPv6 Address Shortening and Lengthening Drills",destination: IPv6AddressDrillsView())
                    NavigationLink("IPv6 CIDR Drills",destination: IPv6CidrDrillsView())


                }
                Section("Other") {
                    NavigationLink("Network Tools and CIDR Calculators",destination: ToolsView())
                    NavigationLink("Support and Settings",destination: OtherViewsView())
                }
            }
            
            .navigationTitle("CIDR Trainer")
            
        }.onAppear {
            print("vertical size class \(String(describing: verticalSizeClass))")
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .inactive || newPhase == .background {
                do {
                    try moc.save()
                    print("Saved core data context")
                } catch {
                    print("Failed to save core data context \(error.localizedDescription)")
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
