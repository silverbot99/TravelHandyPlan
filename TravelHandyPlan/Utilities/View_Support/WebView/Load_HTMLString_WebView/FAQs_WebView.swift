//
//  FAQs_WebView.swift
//  DSBC
//
//  Created by Quang Tran on 07/04/2022.
//  Copyright © 2022 BIN iMac 02. All rights reserved.
//

import SwiftUI
import WebKit

//MARK: - FAQs
struct HTMLString_WebView : UIViewRepresentable {
    
    @Binding var htmlString: String
    @State var canScrolling: Bool = true
      func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
      }
       
      func updateUIView(_ uiView: WKWebView, context: Context) {
          uiView.scrollView.isScrollEnabled = canScrolling
          if htmlString != "" {
              uiView.loadHTMLString( htmlString , baseURL:  nil)
          }
      }
}
