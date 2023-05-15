//
//  DashboardView.swift
//  TravelHandyPlan
//
//  Created by Ngan Huynh on 14/05/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct DashboardView: View {
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Text("\(Unities.getGreetingByTime()), Silva Hoang")
                    .foregroundColor(Color(hex: 0x8E8E93))
                    .padding(.leading, 16)
                    .padding(.top, 20)
                
                Spacer()
            }
            
            HStack {
                Text("Home")
                    .font(.custom(FontType.SemiBold.rawValue, size: 34))
                    .padding(.leading, 16)
                    .padding(.top, 20)
                
                Spacer()
                
                WebImage(url: URL(string: "https://pic-bstarstatic.akamaized.net/ugc/77c1f22f6b8e7b2c02ea6fabf9216a5f.jpeg") ??
                         URL(string: "https://d19ocbwhar60hv.cloudfront.net/app/banner/Mauritius.jpg")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 36, height: 36, alignment: .center)
                .cornerRadius(20)
                .padding(.all, 4)
                .background(
                    Circle()
                        .foregroundColor(Color(hex: 0xffffff, alpha: 0.2))
                )
                .padding(.trailing, 16)
            }
            
            Text("Travel Plan bạn đã lên")
                .font(.custom(FontType.SemiBold.rawValue,size: 20))

                
            Spacer()


        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
