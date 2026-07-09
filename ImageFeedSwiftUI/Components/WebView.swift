//
//  WebView.swift
//  ImageFeedSwiftUI
//
//  Created by Мамытов Руслан on 09.07.2026.
//
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: URL?
    var getCodeFromNavigationAction: (WKNavigationAction) -> Bool
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var getCodeFromNavigationAction: (WKNavigationAction) -> Bool
        
        init(getCodeFromNavigationAction: @escaping (WKNavigationAction) -> Bool) {
            self.getCodeFromNavigationAction = getCodeFromNavigationAction
        }
        
        func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            if getCodeFromNavigationAction(navigationAction) {
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(getCodeFromNavigationAction: getCodeFromNavigationAction)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let preferences = WKPreferences()
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        
        let webView = WKWebView(
            frame: CGRect.zero,
            configuration: configuration
        )
        
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        webView.navigationDelegate = context.coordinator
        
        if let urlValue = url  {
            webView.load(URLRequest(url: urlValue))
        }
        
        return webView
        
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        context.coordinator.getCodeFromNavigationAction = getCodeFromNavigationAction
    }
}
