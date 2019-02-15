//
//  UIWebViewController.swift
//  KlarnaMobileSDKDemo
//

import UIKit
import KlarnaMobileSDK

// MARK: - UIWebViewController demo
class UIWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView! {
        didSet {
            webView.delegate = self
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

// MARK: - UIWebViewDelegate
extension UIWebViewController: UIWebViewDelegate {

    func webViewDidFinishLoad(_ webView: UIWebView) {
        klarnaHybridSDK?.newPageWillLoad(in: webView)
    }

    func webView(_ webView: UIWebView,
                 shouldStartLoadWith request: URLRequest,
                 navigationType: UIWebView.NavigationType) -> Bool {

        return klarnaHybridSDK?.shouldFollowNavigation(withRequest: request) == true ? true : false
    }
}

// MARK: - KlarnaHybridSDKEventListener
extension UIWebViewController: KlarnaHybridSDKEventListener {

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
