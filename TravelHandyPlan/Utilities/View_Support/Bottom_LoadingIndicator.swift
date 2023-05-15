//
//  Notification_LoadingIndicator.swift
//  OneIBC
//
//  Created by Quang Tran on 28/09/2021.
//

import SwiftUI

struct Bottom_LoadingIndicator: View {
    var body: some View {
      
        HStack(alignment: .center, spacing: 0){
            Spacer()
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(1)
            
            Spacer()
        }
        .frame(height: 150, alignment: .center)
        
       
    }
}


struct Bottom_Loading_End: View {
    var body: some View {
        
        Spacer()
            .frame(height: 100, alignment: .center)
            .buttonStyle(PlainButtonStyle())
        
    }
}

struct IMG_Indicator: View {
    
    @State var serialQueue = DispatchQueue(label: "serialQueue")
    
    @State var leftOffset_1: CGFloat = -20
    @State var leftOffset_2: CGFloat = -20
    @State var leftOffset_3: CGFloat = -20
    
        var body: some View {
            ZStack {
                Circle()
                    .fill(Color(hex: 0x6FC3FD))
                    .frame(width: 10, height: 10)
                    .offset(x: leftOffset_1)
                    .opacity(0.7)

                Circle()
                    .fill(Color(hex: 0x6FC3FD))
                    .frame(width: 10, height: 10)
                    .offset(x: leftOffset_2)
                    .opacity(0.7)
                
                Circle()
                    .fill(Color(hex: 0x6FC3FD))
                    .frame(width: 10, height: 10)
                    .offset(x: leftOffset_3)
                    .opacity(0.7)
            }
            .onAppear(perform: {
                self.serialQueue.sync {
                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)){
                        leftOffset_1 = 20
                    }
                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(0.3)){
                        leftOffset_2 = 20
                    }
                    withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(0.5)){
                        leftOffset_3 = 20
                    }
                }
            })
        }
}
