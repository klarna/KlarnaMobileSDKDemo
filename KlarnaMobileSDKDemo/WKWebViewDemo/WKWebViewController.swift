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
        klarnaHybridSDK = KlarnaHybridSDK(webView: webView,
                                          returnUrl: URL(string: "your-app-scheme://")!,
                                          eventListener: self)
    }
}

// MARK: - WKNavigationDelegate
extension WKWebViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        klarnaHybridSDK?.newPageWillLoad(in: webView)
    }

    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        decisionHandler(klarnaHybridSDK?.shouldFollowNavigation(withRequest: navigationAction.request) == true ? .allow : .cancel)
    }
}

// MARK: - KlarnaHybridSDKEventListener
extension WKWebViewController: KlarnaHybridSDKEventListener {

    func klarnaHybridSDKWillShowFullscreen(inWebView webView: KlarnaWebView, completion: () -> Void) {
        // Handle fullscreen transitions
        print("[KlarnaHybridSDK]: will show fullscreen")
        completion()
    }

    func klarnaHybridSDKDidShowFullscreen(inWebView webView: KlarnaWebView, completion: () -> Void) {
        // Handle fullscreen transitions
        print("[KlarnaHybridSDK]: did show fullscreen")
        completion()
    }

    func klarnaHybridSDKWillHideFullscreen(inWebView webView: KlarnaWebView, completion: () -> Void) {
        // Handle fullscreen transitions
        print("[KlarnaHybridSDK]: will hide fullscreen")
        completion()
    }

    func klarnaHybridSDKDidHideFullscreen(inWebView webView: KlarnaWebView, completion: () -> Void) {
        // Handle fullscreen transitions
        print("[KlarnaHybridSDK]: did hide fullscreen")
        completion()
    }

    func klarnaHybridSDKFailed(inWebView webView: KlarnaWebView, withError error: KlarnaMobileSDKError) {
        // Handle Klarna hybrid SDK related errors
        print("[KlarnaHybridSDK]: did get error: \(error.debugDescription)")
    }
}
