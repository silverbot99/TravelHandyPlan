import SwiftUI
import WebKit

//can not change UI when URL change -> but save data and improve performance (and more stable)
struct Dynamic_Static_Webview : UIViewRepresentable {
    
    @Binding var dynamicHeight: CGFloat
    
    @Binding var htmlString: String
    
    var webview: WKWebView = WKWebView()

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: Dynamic_Static_Webview

        init(_ parent: Dynamic_Static_Webview) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript(JavaScriptForWKWebKit, completionHandler: { (height, error) in
                DispatchQueue.main.async {
                    if height != nil {
                        self.parent.dynamicHeight = height as! CGFloat
                    }
                    else{
                        self.parent.dynamicHeight = 0
                    }
                }
            })
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView  {
        webview.scrollView.bounces = true
        webview.scrollView.isScrollEnabled = true
        webview.isUserInteractionEnabled = true
        webview.navigationDelegate = context.coordinator

        //WEBVIEW IS A SPECIAL CASE. BEFORE CALL, DATA IS NOT ALLOWING NULL -> MUST CHECK CONDITION

       // webview.loadHTMLString( loadingURL , baseURL:  nil)
        webview.load(URLRequest(url: URL(string: htmlString)!))
       
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
