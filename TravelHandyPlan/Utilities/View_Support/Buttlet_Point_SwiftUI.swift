//
//  Buttlet_Point_SwiftUI.swift
//  TestSwift
//
//  Created by Quang Tran on 07/04/2022.
//

import SwiftUI

struct Buttlet_Point_SwiftUI: View {
    
    @State var longString = "This is very long text designed to create enough wrapping to force a More button to appear. Just a little more should push it over the edge and get us to one more line."
    
    
    var body: some View {
        
        HStack(alignment: .center, spacing: 8){
            
            //DOT
            VStack(alignment: .center, spacing: 0){
                
                Circle()
                    .frame(width: 8, height: 8, alignment: .center)
                    .foregroundColor(Color.black)
                
                Spacer()
            }.offset(x: 0, y: 16 / 2)
            
            //TEXT
            VStack(alignment: .center, spacing: 0){
                
                Text(longString)
                    .font(.custom(FontType.Regular.rawValue, size: 16))
                
                Spacer()
            }
            
            Spacer()
        }.padding(.all, 16)
    }
}
