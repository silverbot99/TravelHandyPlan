//
//  EmptyView.swift
//  TravelHandyPlan
//
//  Created by Ngan Huynh on 14/05/2023.
//

import SwiftUI

struct InDevelopmentView: View {
    
    @State var title: String = ""
    
    var body: some View {
        VStack {
            Toolbar(title: title)

            
            Spacer()
            
            Text("Chức năng đang trong quá trình phát triển")
                .font(.custom(FontType.Regular.rawValue, size: 20))
            
            Spacer()
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainView()
        }
    }
}
