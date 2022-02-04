//
//  ContentView.swift
//  Shared
//
//  Created by Darrell Root on 2/3/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Hexadecimal and Binary Drills", destination: NumberDrillsView())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
