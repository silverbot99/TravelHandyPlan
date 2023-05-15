//
//  StickyHeader.swift
//  DSBC
//
//  Created by Admin on 10/11/2022.
//  Copyright © 2022 BIN iMac 02. All rights reserved.
//

import SwiftUI

struct StickyHeader<Content: View, TrailingContent: View, AboveContent: View>: View {
    
    @State var isShow: Bool = false
    
    @State var scrollViewSize: CGSize = .zero

    @State var wholeSize: CGSize = .zero

    @State var spaceName = "scroll"

    let content: () -> Content

    let trailingViewOnBar: (() -> TrailingContent)?

    let contentAboveScrollView: (() -> AboveContent)?

    let title: String
    
    @Binding var reachEnd: Bool
    
    let onClickBack: () -> Void
    
    let backTitle: String
    
    init(@ViewBuilder content: @escaping () -> Content,
         trailingViewOnBar: (() -> TrailingContent)?,
         contentAboveScrollView: (() -> AboveContent)?,
         title: String,
         backTitle: String = "Back",
         reachEnd: Binding<Bool>,
         onClickBack: @escaping () -> Void) {
        self.content = content
        self.trailingViewOnBar = trailingViewOnBar
        self.contentAboveScrollView = contentAboveScrollView
        self.title = title
        self.backTitle = backTitle
        self._reachEnd = reachEnd
        self.onClickBack = onClickBack
    }
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .frame(width: WV, height: 100, alignment: .center)
                    .foregroundColor(Color.white)
                    .animation(.linear)
                
                if isShow {
                    Text(title)
                        .foregroundColor(Color(hex: 0x231f20))
                        .font(.custom(FontType.Medium.rawValue, size: 18))
                        .padding(.bottom, 16)
                        .animation(.linear)
                }
                //back button and confirm button
                HStack(alignment: .center, spacing: 0){
                    
                    Button{
                        onClickBack()
                    }label: {
                        HStack(alignment: .center, spacing: 0){
                            Image("vector-2")
                            
                            Text(" \(backTitle)")
                                .foregroundColor(Color(hex: 0x231f20))
                                .font(.custom(FontType.Light.rawValue, size: 15))
                        }
                    }

                    Spacer()
                    
                    //trailingButton custom by user
                    if trailingViewOnBar != nil {
                        trailingViewOnBar!()
                    }
                    
                }.padding(.bottom, 16).padding(.horizontal, 16)
            }
            
            if isShow {
                
                if contentAboveScrollView != nil {
                    contentAboveScrollView!()
                        .padding(.bottom, 8)
                }
                
                Rectangle()
                    .frame(width: WV, height: 1, alignment: .center)
                    .foregroundColor(Color.gray)
            }
            else{
                InDevelopmentView()
            }
            
            // ScrollView
            ChildSizeReader(size: $wholeSize) {
                GeometryReader { _ in
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        ChildSizeReader(size: $scrollViewSize) {

                            VStack(alignment: .leading,spacing: 0, content: {
        
                                HStack(alignment: .center, spacing: 0){
                                    Text(title)
                                        .foregroundColor(Color(hex: 0x231f20))
                                        .font(.custom(FontType.Medium.rawValue, size: 30))
                                        .lineLimit(nil)
                                        .padding(.leading, 16)
        
                                    Spacer()
                                }
        
                                if contentAboveScrollView != nil {
                                    contentAboveScrollView!()
                                        .padding(.bottom, 8)
                                }
        
                                content()
                            })
                            .background(
                                GeometryReader { proxy in
                                    Color.clear.preference(
                                        key: ViewOffsetKey.self,
                                        value: -1 * proxy.frame(in: .named(spaceName)).origin.y
                                    )
                                }
                            )
                            .onPreferenceChange(
                                ViewOffsetKey.self,
                                perform: { value in
                                    
                                    if value > 84 {
                                        isShow = true
                                    }
                                    else{
                                        isShow = false
                                    }
                                    
                                    scrollViewAnimation(value)
                                }
                            )
                        }
                        
                    }
                    .coordinateSpace(name: spaceName)
                }
            }
            .onChange(
                of: scrollViewSize,
                perform: { value in
                    print(value)
                }
            )
            Spacer()
        }
    }
    
    func scrollViewAnimation(_ value: ViewOffsetKey.Value){
        print("scrollViewSize: \(scrollViewSize)/wholeSize: \(wholeSize)")
        if scrollViewSize.height < HV {
            reachEnd = false
        }
        else {
            if value + 750 >= scrollViewSize.height - wholeSize.height{
                reachEnd = true
            } else {
                reachEnd = false
            }
        }
        
    }
}
