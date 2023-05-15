//
//  BaseView.swift
//  DraftProject_ProblemSloving_SwiftUI
//
//  Created by Admin on 04/04/2023.
//

import SwiftUI

enum HeaderBarType {
    case backBtnTitleRightButton
    case backTitle
}

struct BaseView<Content: View, NavigationContent: View>: View {
    var titleHeader: String
    var headerBarType: HeaderBarType = .backBtnTitleRightButton
    var onClickBackButton: () -> Void
    var onClickRightButton: () -> Void

    var content: () -> Content
    var navigationContent: () -> NavigationContent
    
    init(baseViewType: HeaderBarType = .backBtnTitleRightButton,
         titleHeader: String = "",
         onClickBackButton: @escaping () -> Void,
         onClickRightButton: @escaping () -> Void,
         navigationContent:@escaping () -> NavigationContent,
         content: @escaping () -> Content) {
        self.headerBarType = baseViewType
        self.titleHeader = titleHeader
        self.navigationContent = navigationContent
        self.content = content
        self.onClickBackButton = onClickBackButton
        self.onClickRightButton = onClickRightButton
    }
    
    var body : some View {
        
        ZStack {
            
            navigationContent()
            
            VStack(spacing: 0) {
                headingBarView
                            
                content()
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.all, edges: .bottom)
        .onTapGesture {
            self.endTextEditing()
        }
        .background(Color(hex: 0xf2f2f2))
    }
    


    var headingBarView: some View {
        VStack {
            HStack {
                //exit button
                Button {
                    onClickBackButton()
                }label: {
                    Text("Cancel")
                        .foregroundColor(Color.white)
                        .padding(.leading, 16)
                }
                
                
                Spacer()
                
                //title
                Text(titleHeader)
                    .bold()
                    .font(.custom(FontType.Bold.rawValue, size: 16))
                    .foregroundColor(Color.white)

                Spacer()
                //
                
                if headerBarType != .backTitle {
                    Button {
                        print("Lưu")
                        onClickRightButton()
                    }label: {
                        Text("Lưu")
                            .foregroundColor(Color.white)
                            .padding(.trailing, 16)
                    }
                }
                
                
            }
            Spacer()
                .frame(height: 10)
        }
        .frame(width: WV, alignment: .center)
        .background(Color.blue)
        .padding(.bottom, 16)
    }


}

//struct BaseView_Previews: PreviewProvider {
//    static var previews: some View {
//        BaseView()
//    }
//}
