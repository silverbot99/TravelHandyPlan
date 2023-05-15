//
//  DragAbleButton.swift
//  OneIBC
//
//  Created by Quang Tran on 03/10/2021.
//

import SwiftUI

struct DragAbleButton: View {
    
    @Binding var dragAmount: CGPoint?
    
    //bubble button - animate record ripple
    @State private var logoSize: CGFloat = 50
    
    @State private var shadowOpacity1 = 0.2
    @State private var shadowOpacity2 = 0.7
    @State private var shadowOpacity12 = 0.0
    @State private var shadowOpacity22 = 0.0
    //---------------------------------------------//
    
    @State var liveChatData =
        """
                            <html>
                            <head><meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"></head>
                            <body style="padding:0; margin:0; background-color:#63C37E;fill: white">

                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 800" height="48px" width="48px" role="img" alt="Chat icon" class="tawk-min-chat-icon"><path fill-rule="evenodd" clip-rule="evenodd" d="M400 26.2c-193.3 0-350 156.7-350 350 0 136.2 77.9 254.3 191.5 312.1 15.4 8.1 31.4 15.1 48.1 20.8l-16.5 63.5c-2 7.8 5.4 14.7 13 12.1l229.8-77.6c14.6-5.3 28.8-11.6 42.4-18.7C672 630.6 750 512.5 750 376.2c0-193.3-156.7-350-350-350zm211.1 510.7c-10.8 26.5-41.9 77.2-121.5 77.2-79.9 0-110.9-51-121.6-77.4-2.8-6.8 5-13.4 13.8-11.8 76.2 13.7 147.7 13 215.3.3 8.9-1.8 16.8 4.8 14 11.7z"></path></svg>

                            </body>
                            </html>
                        """
    
    @State var isChat: Bool = false
    var body: some View {
        
        GeometryReader { gp in // just to center initial position
                   ZStack {
                       
                       Button{
                           
                           let impactMed = UIImpactFeedbackGenerator(style: .medium)
                               impactMed.impactOccurred()
                           
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.65) {
                               print("TabTab")
                               isChat = true
                           }
                           
                           
                           withAnimation(Animation.easeIn(duration: 0.15)) {
                               self.shadowOpacity1 = 0.0
                               self.shadowOpacity2 = 0.0
                               self.logoSize = 45
                           }
                           withAnimation(Animation.easeOut(duration: 0.15)) {
                               self.shadowOpacity12 = 0.2
                               self.shadowOpacity22 = 0.7
                               self.logoSize = 40
                           }
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                               withAnimation(Animation.easeIn(duration: 0.15)) {
                                   self.shadowOpacity12 = 0.0
                                   self.shadowOpacity22 = 0.0
                                   self.logoSize = 45
                               }
                               withAnimation(Animation.easeOut(duration: 0.15)) {
                                   self.shadowOpacity1 = 0.2
                                   self.shadowOpacity2 = 0.7
                                   self.logoSize = 50
                               }
                           }
                           
                       }label: {
                           ZStack{
                              
                               // Circle unpressed
                               Circle()
                                   .fill(Color(hex: 0xe1e1eb))
                                   .frame(width: 60, height: 60)
                                   .shadow(color: Color.black.opacity(self.shadowOpacity1), radius: 10, x: 10, y: 10)
                                   .shadow(color: Color(hex: 0x63C37E).opacity(self.shadowOpacity2), radius: 10, x: -5, y: -5)
                               
                               ZStack{
                                   // Circle pressed
                                   Circle()
                                       .stroke(Color(hex: 0xe1e1eb), lineWidth: 1)
                                       .shadow(color: Color.black.opacity(self.shadowOpacity12), radius: 3, x: 5, y: 5)
                                       .clipShape(
                                           Circle()
                                       )
                                       .shadow(color: Color(hex: 0x63C37E).opacity(self.shadowOpacity22), radius: 2, x: -2, y: -2)
                                       .clipShape(
                                           Circle()
                                       )
                                       .frame(width: 60, height: 60)
                               }
                               .mask(Circle().frame(width: 60, height: 60))
                               
                               Circle().foregroundColor(Color(hex: 0x63C37E))
                                   .frame(width: 60, height: 60)
                                   .shadow(color: Color.black.opacity(self.shadowOpacity1), radius: 10, x: 10, y: 10)
                                   .shadow(color: Color.white.opacity(self.shadowOpacity2), radius: 10, x: -5, y: -5)
                               
                               NormalWebView(htmlString: $liveChatData)
                                   .frame(width: 48, height: 48)
                                   .cornerRadius(24)
                                   
                           }
                       }.animation(.default)
                       .position(self.dragAmount ?? CGPoint(x: gp.size.width / 2, y: gp.size.height / 2))
                       .highPriorityGesture(  // << to do no action on drag !!
                           DragGesture()
                               .onChanged { self.dragAmount = $0.location}
                            .onEnded({
                                print($0.location)
                                
                                if $0.location.y < -HV*0.3{
                                    self.dragAmount = CGPoint(x: $0.location.x, y: -HV*0.3)
                                }
                                else if $0.location.y > HV*0.4{
                                    self.dragAmount = CGPoint(x: $0.location.x, y: HV*0.4)
                                }
                            }))
                   }.frame(maxWidth: .infinity, maxHeight: .infinity) // full space
//                .fullScreenCover(isPresented: $isChat) {
//                    Choose_Communicate()
//                        .background(BackgroundView())   //set this for remove white default background
//                                   
//                }
               }
       
    }
}
