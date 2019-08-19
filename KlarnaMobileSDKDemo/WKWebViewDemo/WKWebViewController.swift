//
//  WKWebViewController.swift
//  KlarnaMobileSDKDemo
//

import UIKit
import WebKit
import KlarnaMobileSDK

// MARK: - WKWebViewController demo
class WKWebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
            webView.loadHTMLString(Bundle.harryHtmlString, baseURL: nil)
        }
    }

    private var klarnaHybridSDK: KlarnaHybridSDK?

    override func viewDidLoad() {
        super.viewDidLoad()
        klarnaHybridSDK = KlarnaHybridSDK(returnUrl: URL(string: "your-app-scheme://")!, eventListener: self)
        klarnaHybridSDK?.addWebView(webView)
    }
}

// MARK: - WKNavigationDelegate
extension WKWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        klarnaHybridSDK?.newPageLoad(in: webView)
    }

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        decisionHandler(klarnaHybridSDK?.shouldFollowNavigation(withRequest: navigationAction.request) == true ? .allow : .cancel)
    }
}

// MARK: - KlarnaHybridSDKEventListener
extension WKWebViewController: KlarnaHybridEventListener {

    func klarnaWillShowFullscreen(inWebView webView: KlarnaWebView, completionHandler: @escaping () -> Void) {
        print("[KlarnaHybridSDK]: will show fullscreen")
        completionHandler()
    }
    
    func klarnaDidShowFullscreen(inWebView webView: KlarnaWebView, completionHandler: @escaping () -> Void) {
        print("[KlarnaHybridSDK]: did show fullscreen")
        completionHandler()
    }
    
    func klarnaWillHideFullscreen(inWebView webView: KlarnaWebView, completionHandler: @escaping () -> Void) {
        print("[KlarnaHybridSDK]: will hide fullscreen")
        completionHandler()
    }
    
    func klarnaDidHideFullscreen(inWebView webView: KlarnaWebView, completionHandler: @escaping () -> Void) {
        print("[KlarnaHybridSDK]: did hide fullscreen")
        completionHandler()
    }
    
    func klarnaFailed(inWebView webView: KlarnaWebView, withError error: KlarnaMobileSDKError) {
        // Handle Klarna hybrid SDK related errors
        print("[KlarnaHybridSDK]: did get error: \(error.debugDescription)")
    }
}
