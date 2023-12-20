//
//  WebView.swift
//  app
//
//  Created by William Brendel on 11/29/22.
//

import SwiftUI
import WebKit
import AudioToolbox

// For identifying what type of url should load into WebView
enum WebUrlType {
    case localUrl, publicUrl
}

struct WebView: UIViewRepresentable {
    var src: String = "index"
    var ext: String = "html"
    var dir: String = "html"
    var type: WebUrlType = .localUrl

    // To add javascript capabilities.
    private func evaluateJavascript(_ webView: WKWebView, _ javascript: String, sourceURL: String? = nil, completion: ((_ error: String?) -> Void)? = nil) {
        var js = javascript

        // Adding a sourceURL comment makes the javascript source visible when debugging the simulator via Safari in Mac OS
        if let sourceURL = sourceURL {
            js = "//# sourceURL=\(sourceURL).js\n" + js
        }

        webView.evaluateJavaScript(js) { _, error in
            completion?(error?.localizedDescription)
        }
    }

    // To add delegate functionalities.
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "console" {
                guard let dict = message.body as? [String: AnyObject],
                      let msg = dict["msg"] as? String,
                      let type = dict["type"] as? String else { return }
                print(type, msg)
            }

            if message.name == "vibrate" {
                switch message.body as? String {
                    case "success", "1":
                        UIImpactFeedbackGenerator(style: .heavy).impactOccurred() // 1 slow
                    case "warning", "warn", "2":
                        UINotificationFeedbackGenerator().notificationOccurred(.warning) // 2 slow
                    case "error", "err", "3":    
                        UINotificationFeedbackGenerator().notificationOccurred(.error) // 3 fast
                    case "buzz":    
                        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate) // Long buzz
                    case "peek":    
                        AudioServicesPlayAlertSound(1519) // Actuate "Peek" feedback (weak boom)
                    case "pop":    
                        AudioServicesPlayAlertSound(1520) // Actuate "Pop" feedback (strong boom)
                    case "nope":    
                        AudioServicesPlayAlertSound(1521) // Actuate "Nope" feedback (series of three weak booms)
                    default:
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                }
            }

            if message.name == "share" {
                guard let dict = message.body as? [String: AnyObject],
                      let title = dict["title"] as? String,
                      let text = dict["text"] as? String,
                      let url = dict["url"] as? String,
                      let files = dict["files"] as? [Any] else { return }

                // Call native share module
                var items = [Any]()
                if text != "" {
                    items.append(text)
                }
                if url != "" {
                    items.append(URL(string: url)!)
                }
                if files.count > 0 {
                    
                }
            }
        }

        // Find the controller.
        private func topMostViewController() -> UIViewController? {
            guard let rootController = keyWindow()?.rootViewController else {
                return nil
            }
            return topMostViewController(for: rootController)
        }

        private func keyWindow() -> UIWindow? {
            return UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive}
            .compactMap {$0 as? UIWindowScene}
            .first?.windows.filter {$0.isKeyWindow}.first
        }

        private func topMostViewController(for controller: UIViewController) -> UIViewController {
            if let presentedController = controller.presentedViewController {
                return topMostViewController(for: presentedController)
            } else if let navigationController = controller as? UINavigationController {
                guard let topController = navigationController.topViewController else {
                    return navigationController
                }
                return topMostViewController(for: topController)
            } else if let tabController = controller as? UITabBarController {
                guard let topController = tabController.selectedViewController else {
                    return tabController
                }
                return topMostViewController(for: topController)
            }
            return controller
        }

        // Delegate methods go here

        // The webView(_:, runJavaScriptAlertPanelWithMessage:, initiatedByFrame:, completionHandler:)
        // is called when window.alert("message") is called in Javascript. One implementation on iOS in
        // Swift might use a UIAlertController to display the alert to the user.
        func webView(_ webView: WKWebView, 
            runJavaScriptAlertPanelWithMessage message: String, 
            initiatedByFrame frame: WKFrameInfo, 
            completionHandler: @escaping () -> Void) {
            
            // Set the message as the UIAlertController message
            let alert = UIAlertController(
                title: nil,
                message: message,
                preferredStyle: .alert
            )

            // Add a confirmation action "OK"
            let okAction = UIAlertAction(
                title: "OK",
                style: .default,
                handler: { _ in
                    // Call completionHandler
                    completionHandler()
                }
            )
            alert.addAction(okAction)

            // Display the NSAlert
            if let controller = topMostViewController() {
                controller.present(alert, animated: true, completion: nil)
            }
        }

        // The webView(_:, runJavaScriptConfirmPanelWithMessage:, initiatedByFrame:, completionHandler:)
        // is called when window.confirm("message") is called in Javascript. One implementation on iOS in
        // Swift might use a UIAlertController to display the confirmation to the user, calling
        // completionHandler(true) if the user chose to confirm the action.
        func webView(_ webView: WKWebView, 
            runJavaScriptConfirmPanelWithMessage message: String, 
            initiatedByFrame frame: WKFrameInfo, 
            completionHandler: @escaping (Bool) -> Void) {

            // Set the message as the UIAlertController message
            let alert = UIAlertController(
                title: nil,
                message: message,
                preferredStyle: .alert
            )

            // Add a confirmation action "OK"
            let okAction = UIAlertAction(
                title: "OK",
                style: .default,
                handler: { _ in
                    // Call completionHandler confirming the choice
                    completionHandler(true)
                }
            )
            alert.addAction(okAction)

            // Add a cancel action "Cancel"
            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: { _ in
                    // Call completionHandler cancelling the choice
                    completionHandler(false)
                }
            )
            alert.addAction(cancelAction)

            // Display the NSAlert
            if let controller = topMostViewController() {
                controller.present(alert, animated: true, completion: nil)
            }
        }

        // The webView(_:, runJavaScriptTextInputPanelWithPrompt:, initiatedByFrame:, completionHandler:)
        // is called when window.prompt("prompt", "default response") is called in Javascript.
        // One implementation on iOS in Swift might use a UIAlertController to display a text field
        // for user input, calling completionHandler with the user’s input text.
        func webView(_ webView: WKWebView, 
            runJavaScriptTextInputPanelWithPrompt message: String, 
            defaultText: String?, 
            initiatedByFrame frame: WKFrameInfo, 
            completionHandler: @escaping (String?) -> Void) {
            
            // Set the prompt as the UIAlertController message
            let alert = UIAlertController(
                title: nil,
                message: message,
                preferredStyle: .alert
            )

            // Add a text field to the UIAlertController
            alert.addTextField() 

            // Add a confirmation action "Submit"
            let submitAction = UIAlertAction(
                title: "Submit",
                style: .default,
                handler: { [unowned alert] _ in
                    // Call completionHandler with the user input 
                    let input = alert.textFields?.first
                    completionHandler(input?.text)
                }
            )
            alert.addAction(submitAction)

            // Display the NSAlert
            if let controller = topMostViewController() {
                controller.present(alert, animated: true, completion: nil)
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // To create the webview View.
    func makeUIView(context: Context) -> WKWebView {
        // Define configuration
        let webConfiguration = WKWebViewConfiguration()

        // Allow javascript execution.
        webConfiguration.defaultWebpagePreferences.allowsContentJavaScript = true
        webConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = true // !!

        // Media configs.
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.mediaTypesRequiringUserActionForPlayback = []
        webConfiguration.allowsAirPlayForMediaPlayback = true

        // Post message handler.
        webConfiguration.userContentController.add(context.coordinator, name:"console")
        webConfiguration.userContentController.add(context.coordinator, name:"vibrate")
        webConfiguration.userContentController.add(context.coordinator, name:"share")

        // Define webview
        let webView = WKWebView(frame:CGRect( x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height ), configuration: webConfiguration )
        
        // Add delegate.
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator

        // No scrolling
        webView.scrollView.isScrollEnabled = false
        
        // No inset padding
        webView.scrollView.contentInsetAdjustmentBehavior = .never

        // Background color.
        webView.isOpaque = false
        webView.backgroundColor = UIColor.black
        
        return webView
    }
    
    // To update the webview View.
    func updateUIView(_ webView: WKWebView, context: Context) {
        if type == .localUrl {
            // Load local website
            if let url = Bundle.main.url(forResource: src, withExtension: ext, subdirectory: dir) {
                webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
            }
        } else if type == .publicUrl {
            // Load a public website, for example I used here google.com
            if let url = URL(string: src) {
                webView.load(URLRequest(url: url))
            }
        }
    }
}

struct Previews_WebView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
