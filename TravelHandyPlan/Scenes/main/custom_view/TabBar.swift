//
//  TabBar.swift
//  TravelHandyPlan
//
//  Created by Ngan Huynh on 14/05/2023.
//

import SwiftUI

class TabBarRouter: ObservableObject {
    
    @Published var currentPage: FeatureTab = .Dashboard
}

struct FxTabItem: View {
    @ObservedObject var tabbarRouter: TabBarRouter
    let assignedPage: FeatureTab
    
    let width, height: CGFloat     
     
     var body: some View {
         VStack {
             Image(systemName: assignedPage.getIcon())
                 .resizable()
                 .aspectRatio(contentMode: .fit)
                 .frame(width: width, height: height)
                 .padding(.top, 10)
             Text(assignedPage.getTitle())
                 .font(.footnote)
             Spacer()
         }
         .padding(.horizontal, -4)
         .foregroundColor(tabbarRouter.currentPage == assignedPage ? Color.white : .gray)
         .onTapGesture {
             tabbarRouter.currentPage = assignedPage
         }
     }
 }

struct FxPlusTabBarButton: View {
    let width, height: CGFloat
    let systemIconName, tabName: String
    
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .frame(width: width, height: height)
                .shadow(radius: 4)
            Image(systemName: systemIconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width-6 , height: height-6)
                .foregroundColor(Color.blue.opacity(0.7))
        }
        .padding(.horizontal, -4)
        .onTapGesture {
            action()
        }
    }
}
