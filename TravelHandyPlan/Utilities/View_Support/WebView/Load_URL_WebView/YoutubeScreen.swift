import SwiftUI
import WebKit

struct youtubeScreen_WebView : UIViewRepresentable {
    
    @State var embedID: String = ""
       
    func makeUIView(context: Context) -> WKWebView {
        
        let prefs = WKWebpagePreferences()
        let configuration = WKWebViewConfiguration()
        
        prefs.allowsContentJavaScript = true
        configuration.defaultWebpagePreferences = prefs
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        return WKWebView(frame: .zero, configuration: configuration)   //frame CGRect
    }
       
      func updateUIView(_ uiView: WKWebView, context: Context) {
          if embedID != "" {
              
//              let myURL = URL(string: )
              let myURLString = "https://www.youtube.com/embed/\(embedID)"
              let myURL = URL(string: myURLString)
              let myRequest = URLRequest(url: myURL!)
              uiView.load(myRequest)
              
              print("embedID: \(embedID)/myURLString: \(myURLString)")

          }
        
      }
}
