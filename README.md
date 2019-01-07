## KlarnaMobileSDK Demo

This demo shows how you can integrate KlarnaMobileSDK into your existing web views, UIWebView or WKWebView.

It loads a local `harry.html` file into webviews for demonstrations. 

### Run the demo app

This demo demonstrate how you can use Cocoapods to integrate KlarnaMobileSDK into your XCode project, this is included `Podfile`:

```ruby
use_frameworks!

platform :ios, "10.0"

target "KlarnaMobileSDKDemo" do
   pod "KlarnaMobileSDK"
end
```

To run the demo app, just open `KlarnaMobileSDKDemo.xcworkspace`, click on `Run`. 

### Important steps during integration

There are a few important steps that you need to perform to have a successful integration:

* Initialize `KlarnaHybridSDK` with a `UIWebView` or `WKWebView`, make sure providing a `returnUrl` and `eventListener` during the initialization. 

```swift
	klarnaHybridSDK = KlarnaHybridSDK(webView: webView,
                                   returnUrl: URL(string: "your-app-scheme://")!,
                                   eventListener: self)
```

* Implement WebView's delegate, call	relavant `KlarnaHybridSDK` methods.
	* For `UIWebView`:

		```swift
		func webViewDidFinishLoad(_ webView: UIWebView) {
	        klarnaHybridSDK?.newPageWillLoad(in: webView)
	    }
	
	    func webView(_ webView: UIWebView,
	                 shouldStartLoadWith request: URLRequest,
	                 navigationType: UIWebView.NavigationType) -> Bool {
	
	        return klarnaHybridSDK?.shouldFollowNavigation(withRequest: request) == true ? true : false
	    }
		```
	* For `WKWebView`:

		```swift
		func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
	        klarnaHybridSDK?.newPageWillLoad(in: webView)
	    }
	
	    func webView(_ webView: WKWebView,
	                 decidePolicyFor navigationAction: WKNavigationAction,
	                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
	
	        decisionHandler(klarnaHybridSDK?.shouldFollowNavigation(withRequest: navigationAction.request) == true ? .allow : .cancel)
	    }
		```
	
* Implement `KlarnaHybridSDKEventListener`.

```swift
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
```	






