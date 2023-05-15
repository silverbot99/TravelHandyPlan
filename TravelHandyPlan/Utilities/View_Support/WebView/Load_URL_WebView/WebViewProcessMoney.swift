//
//  WebViewProcessMoney.swift
//  OneIBC
//
//  Created by BIN CG on 14/10/2021.
//
import Combine
import SwiftUI
import WebKit

enum typeDone {
    case none
    case done
    case block
}

//in this case, user was wrong more than 10 times, which is prohibit, must create another account or contact us for solving problem
var errorCASE: Bool = false

class WebViewModel: ObservableObject {
    @Published var link: String
    

    init (link: String) {
        self.link = link
    }
}

struct SwiftUIWebView: UIViewRepresentable {
    
    @ObservedObject var viewModel: WebViewModel

    let webView = WKWebView()

    func makeUIView(context: UIViewRepresentableContext<SwiftUIWebView>) -> WKWebView {
        self.webView.navigationDelegate = context.coordinator
        if let url = URL(string: viewModel.link) {
            self.webView.load(URLRequest(url: url))
        }
        return self.webView
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<SwiftUIWebView>) {
        return
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: WebViewModel

        init(_ viewModel: WebViewModel) {
            self.viewModel = viewModel
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("WebView: navigation finished")
            viewModel.link = "\(webView.url!)"  //catch url string
            //tutorial: https://stackoverflow.com/questions/58336457/swiftui-wkwebview-detect-url-changing
           
        }
    }

    func makeCoordinator() -> SwiftUIWebView.Coordinator {
        Coordinator(viewModel)
    }
}
