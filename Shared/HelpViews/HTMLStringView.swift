//
//  HTMLStringView.swift
//  CIDR Trainer
//
//  Created by Darrell Root on 2/10/22.
//

import Foundation
// from https://stackoverflow.com/questions/56892691/how-to-show-html-or-markdown-in-a-swiftui-text
import WebKit
import SwiftUI
struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
