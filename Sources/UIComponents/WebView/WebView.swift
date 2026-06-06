//
//  WebView.swift
//  WebViewKit
//
//  Created by Daniel Saidi on 2022-03-24.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

typealias WebViewRepresentable = UIViewRepresentable
import SwiftUI
import WebKit
import Foundation

/**
 This view wraps a `WKWebView` and can be used to load local
 and online web pages.
 
 When you create this view, you can either provide it with a
 url, or an optional url and a configuration block, that can
 be used to configure the `WKWebView`.
 */
public struct WebView: WebViewRepresentable {
    
    @Binding var dynamicHeight: CGFloat
    @Binding var loadCompleted: Bool
    var webview: WKWebView = WKWebView()
    
    public class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        public func webView(_ webView: WKWebView,
                            didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
                    self.parent.dynamicHeight = height as! CGFloat
                    self.parent.loadCompleted = true
                })
            }
        }
    }
    
    public init(
        dynamicHeight: Binding<CGFloat>,
        loadCompleted: Binding<Bool>,
        url: URL? = nil,
        htmlString: String? = nil,
        configuration: @escaping (WKWebView) -> Void = { _ in }) {
            
            self._dynamicHeight = dynamicHeight
            self._loadCompleted = loadCompleted
            self.url = url
            self.htmlString = htmlString
            self.configuration = configuration
        }
    
    
    // MARK: - Properties
    
    private let url: URL?
    private let htmlString: String?
    private let configuration: (WKWebView) -> Void
    
    
    // MARK: - Functions
    
    public func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.scrollView.bounces = false
        view.navigationDelegate = context.coordinator
        configuration(view)
        tryLoad(into: view)
        return view
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

private extension WebView {
    
    func tryLoad(into view: WKWebView) {
        if let url = url {
            view.load(URLRequest(url: url))
        } else if let htmlString = htmlString {
            view.loadHTMLString(htmlString, baseURL: URL(fileURLWithPath: Bundle.main.bundlePath))
        }
    }
}

struct Previews_WebView_Previews: PreviewProvider {
    
    static var previews: some View {
        if let url = URL(string: "https://danielsaidi.com") {
            WebView(dynamicHeight: .constant(100.0),
                    loadCompleted: .constant(false),
                    url: url)
        } else {
            Color.orange
        }
    }
}
