//
//  ListTextClickedBottomsheet.swift
//  DSBC
//
//  Created by Admin on 16/01/2023.
//  Copyright © 2023 BIN iMac 02. All rights reserved.
//

import SwiftUI

struct ListTextClickedBottomsheet: View {
    
    @Binding var isShow: Bool
    
    @Binding var arrText: [String]
    
    let clickedText: (String) -> Void

    var body: some View {
        ZStack {
            Rectangle()
                .background(Color(hex: 0x231f20))
                .opacity(0.3)
                .onTapGesture {
                    isShow = false
                }
            VStack(alignment: .center, spacing: 0){
                
                Spacer()
                
                VStack(alignment: .center, spacing: 14){
                    
                    //button close
//                    VStack(alignment: .center, spacing: 8){
//                        Button{
//
//                            withAnimation(.easeInOut(duration: 0.5)){
//                                isShow = false
//                            }
//
//                        }label: {
//                            HStack(alignment: .center, spacing: 4){
//
//                                Image("icon_close_blue")
//
//                                Text("Close")
//                                    .foregroundColor(Color(hex: 0x231f20))
//                                    .font(.custom(FontType.Regular.rawValue, size: 15))
//
//                                Spacer()
//
//                            }
//                        }
//                        .padding(.all, 16)
//
//                        Rectangle()
//                            .foregroundColor(Color(hex: 0xe1e1e1))
//                            .frame(width: WV, height: 1, alignment: .center)
//
//                    }
                    Spacer()
                        .frame(height: 16)
                    
                    //add new beneficiary
                    ForEach(0..<arrText.count, id: \.self) { index in
                        VStack(alignment: .center, spacing: 12){
                            
                            Button{
                                isShow = false

                                clickedText(arrText[index])
                                
                            }label: {
                                Text(arrText[index])
                                    .foregroundColor(Color(hex: 0x231f20))
                                    .font(.custom(FontType.Medium.rawValue, size: 14))
                            }
                            
                            Rectangle()
                                .foregroundColor(Color(hex: 0xe1e1e1))
                                .frame(width: WV, height: 1, alignment: .center)
                        }
                    }
                   
                    Spacer()
                        .frame(width: WV, height: 48, alignment: .center)
                    
                }.background(Color.white)
                    .cornerRadius(16, corners: [.topLeft, .topRight])
            }
        }
        .ignoresSafeArea(.all, edges: .vertical)
    }
}
