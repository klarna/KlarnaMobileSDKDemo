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
        klarnaHybridSDK = KlarnaHybridSDK(returnUrl: URL(string: "your-app-scheme://")!, eventListener: self)
        klarnaHybridSDK?.addWebView(webView)
    }
}

// MARK: - UIWebViewDelegate
extension UIWebViewController: UIWebViewDelegate {

    func webViewDidFinishLoad(_ webView: UIWebView) {
        klarnaHybridSDK?.newPageLoad(in: webView)
    }

    func webView(_ webView: UIWebView,
                 shouldStartLoadWith request: URLRequest,
                 navigationType: UIWebView.NavigationType) -> Bool {

        return klarnaHybridSDK?.shouldFollowNavigation(withRequest: request) == true ? true : false
    }
}

// MARK: - KlarnaHybridSDKEventListener
extension UIWebViewController: KlarnaHybridEventListener {

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
