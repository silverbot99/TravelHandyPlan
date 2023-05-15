//
//  Toolbar.swift
//  DraftProject_ProblemSloving_SwiftUI
//
//  Created by Admin on 08/03/2023.
//

import SwiftUI

struct Toolbar: View {
    @State var title: String = ""
    @State var iconBack: String = "ic_back"
    @State var color: Color = Color.white
    @State var textColor: Color = Color.black
    @State var onClickBack: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            
            HStack {
                
                Spacer()
                
                Text(title)
                    .font(.custom(FontType.SemiBold.rawValue, size: 20))
                    .foregroundColor(textColor)
                
                Spacer()
            }
            .background(
                Rectangle()
                    .fill(color)
                    .frame(height: 50, alignment: .center)
            )
            
            HStack {
                Image(iconBack)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32, alignment: .center)
                
                Spacer()
            }
        }
    }
}
