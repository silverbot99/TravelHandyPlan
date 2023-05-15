import SwiftUI
import WebKit

struct NormalWebView : UIViewRepresentable {
    
    @Binding var htmlString: String
       
      func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
      }
       
      func updateUIView(_ uiView: WKWebView, context: Context) {
          if htmlString != "" {
              uiView.load(URLRequest(url: URL(string: htmlString)!))
          }
        
      }
}
