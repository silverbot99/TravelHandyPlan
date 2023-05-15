//
//  Button_Wave_Animation.swift
//  OneIBC
//
//  Created by Quang Tran on 04/11/2021.
//

import SwiftUI

struct Choose_Communicate: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack{

            Button{
                self.presentationMode.wrappedValue.dismiss()
            }label: {
                Color(hex: 0x000000, alpha: 0.25)
                    .ignoresSafeArea(.all)
            }
            
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .padding(.all, 16)
                .background(Color.white)
                .padding(.all, 16)
        }
        
        
    }
}
