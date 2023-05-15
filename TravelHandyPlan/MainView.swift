//
//  ContentView.swift
//  TravelHandyPlan
//
//  Created by Ngan Huynh on 14/05/2023.
//

import SwiftUI

struct MainView: View {
    
    @State var isGotoTravelPlan = false

    
    @StateObject var tabbarRouter = TabBarRouter()

    @ViewBuilder var contentView: some View {
        
        switch tabbarRouter.currentPage {
            
        case .Dashboard:
            DashboardView()
            
        case .Profile:
            InDevelopmentView(title: tabbarRouter.currentPage.getTitle())
            
        case .Plan:
            EmptyView()
        }
    }

    
    
    
    var body: some View {

        ZStack {
            NavigationLink(
                destination: TravelPlanView(),
                isActive: $isGotoTravelPlan)
            { EmptyView() }.isDetailLink(false)

            
            GeometryReader { geometry in
                
                VStack {
                    Spacer()
                    
                    // Contents
                    contentView
                    
                    Spacer()
                    
                    // Tabbar
                    HStack {
                        FxTabItem(tabbarRouter: tabbarRouter, assignedPage: .Dashboard, width: geometry.size.width/5, height: geometry.size.height/28)

                        FxPlusTabBarButton(width: geometry.size.width/7, height: geometry.size.width/7, systemIconName: "plus.circle.fill", tabName: "plush", action: {
                            isGotoTravelPlan = true
                        })
                              .offset(y: -geometry.size.height/8/2)

                        FxTabItem(tabbarRouter: tabbarRouter, assignedPage: .Profile, width: geometry.size.width/5, height: geometry.size.height/28)

                    }
                    .frame(width: geometry.size.width, height: geometry.size.height/8)
                    .background(Color.gray.opacity(0.3).shadow(radius: 2))
                }
                .edgesIgnoringSafeArea(.bottom)
            }
            
            
        }
        
    }

}
