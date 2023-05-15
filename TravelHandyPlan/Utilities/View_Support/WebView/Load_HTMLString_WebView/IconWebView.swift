//
//  IconWebView.swift
//  DSBC
//
//  Created by Quang Tran on 07/01/2022.
//  Copyright © 2022 BIN iMac 02. All rights reserved.
//

import SwiftUI
import WebKit

struct iconWebView : UIViewRepresentable {
    
    @Binding var htmlString: String
       
      func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
      }
       
      func updateUIView(_ uiView: WKWebView, context: Context) {
          uiView.isUserInteractionEnabled = false
          uiView.layer.cornerRadius = 25
          if htmlString != "" {
              uiView.loadHTMLString( htmlString , baseURL:  nil)
          }
        
      }
}
