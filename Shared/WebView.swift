//
//  WebView.swift
//  SmartRSS
//
//  Created by Seyyed Parsa Neshaei on 9/2/21.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var text: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(text, baseURL: nil)
    }
}
