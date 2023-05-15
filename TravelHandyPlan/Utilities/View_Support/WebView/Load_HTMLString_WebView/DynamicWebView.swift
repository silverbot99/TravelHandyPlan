import SwiftUI
import WebKit

let JavaScriptForWKWebKit: String = "Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight)"


struct DynamicWebview: UIViewRepresentable {
    
    @Binding var dynamicHeight: CGFloat
    
    @Binding var htmlString: String
    
    var webview: WKWebView = WKWebView(frame: CGRect(x: 0.0, y: 0.0, width: 0.1, height: 0.1))

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: DynamicWebview

        init(_ parent: DynamicWebview) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
            webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
                
                //if complete != nil {
                guard let completeOK = complete as? String else{
                    return
                }
                if completeOK == "complete" {
                    
                    webView.evaluateJavaScript(JavaScriptForWKWebKit, completionHandler: { [self] (height, error) in

                        self.parent.dynamicHeight = height as? CGFloat ?? 0.0
                    })
                }
            })
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webview.scrollView.bounces = true
        webview.scrollView.isScrollEnabled = true
        webview.isUserInteractionEnabled = true
        webview.navigationDelegate = context.coordinator

        //WEBVIEW IS A SPECIAL CASE. BEFORE CALL, DATA IS NOT ALLOWING NULL -> MUST CHECK CONDITION

        let loadingURL = htmlString
        if htmlString != "" {
            
            DispatchQueue.main.async {
                //reset to default
                self.dynamicHeight = 0.0
                
                webview.loadHTMLString( loadingURL , baseURL:  nil)
            }
        }
        return webview
    }
     //reload webView when htmlString change
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.scrollView.isScrollEnabled = false
        uiView.isUserInteractionEnabled = true
        if htmlString != "" {
            uiView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
        }
    }
}


//struct Webview : UIViewRepresentable {
//    @Binding var dynamicHeight: CGFloat
//    var webview: WKWebView = WKWebView()
//
//    class Coordinator: NSObject, WKNavigationDelegate {
//        var parent: Webview
//
//        init(_ parent: Webview) {
//            self.parent = parent
//        }
//
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
//                DispatchQueue.main.async {
//                    self.parent.dynamicHeight = height as! CGFloat
//                }
//            })
//        }
//        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//            self.parent.dynamicHeight = 0
//        }
//
////        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
////            self.parent.dynamicHeight = webView.scrollView.contentSize.height
////        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIView(context: Context) -> WKWebView  {
//        webview.scrollView.bounces = false
//        webview.scrollView.contentInset = .zero
//        webview.scrollView.contentInsetAdjustmentBehavior = .never
//        webview.scrollView.isScrollEnabled = false
//        webview.isUserInteractionEnabled = true
//        webview.navigationDelegate = context.coordinator
//        let htmlStart = "<HTML><HEAD><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, shrink-to-fit=no\"></HEAD><BODY>"
//        let htmlEnd = "</BODY></HTML>"
//        let dummy_html = getDataTest2()
//        let htmlString = "\(htmlStart)\(dummy_html)\(htmlEnd)"
//        webview.loadHTMLString(htmlString, baseURL:  nil)
//        return webview
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//    }
//}

//struct TestWebViewInScrollView: View {
//    @State private var webViewHeight: CGFloat = .zero
//
//    @State private var htmlString: String = contentHeaderHtml()
//
//    var body: some View {
//        ScrollView {
//            VStack {
//
////                Webview(dynamicHeight: $webViewHeight)
////                    .padding(.horizontal)
////                    .frame(height: webViewHeight)
//
//                DynamicWebview(dynamicHeight: $webViewHeight, htmlString: $htmlString)
//                    .frame(height: webViewHeight, alignment: .center)
//
//
//                Rectangle().fill(Color.black)
//                    .frame(width: WV, height: 1)
//
//                Image(systemName: "doc")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 300)
//            }
//        }
//    }
//}
//
//struct TestWebViewInScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestWebViewInScrollView()
//    }
//}

//struct TempView_Previews: PreviewProvider {
//    static var previews: some View {
//        TempView()
//    }
//}
