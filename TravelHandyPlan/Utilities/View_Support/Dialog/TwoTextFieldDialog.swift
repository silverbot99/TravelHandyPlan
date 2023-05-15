//
//  TwoTextFieldDialog.swift
//  DraftProject_ProblemSloving_SwiftUI
//
//  Created by Admin on 17/01/2023.
//

import SwiftUI

struct TwoTextFieldDialog: View {
    @Binding var isShow : Bool

    @State var title = "Thêm mới"
    @State var nameTXT = dataTXT(placeHolder: "Tên")
    @State var valueTXT = dataTXT(placeHolder: "Số tiền")
    @State var noteTXT = dataTXT(placeHolder: "Note")

    let onClickedYes: () -> Void
    
    var body: some View {
        
        VStack {
            Text(title)
            
            //name
            TextField(nameTXT.placeHolder, text: $nameTXT.content)
            Divider()
            
            //amount
            TextField(valueTXT.placeHolder, text: $valueTXT.content)
                .onChange(of: valueTXT.content) { newValue in
                    valueTXT.content = newValue.removeCharacterFromNumber().formatMoneyValue()
                }
                .keyboardType(.numberPad)
            
            Divider()
            
            //note
            TextField(noteTXT.placeHolder, text: $noteTXT.content)
            
            Divider()
            
            //Button
            HStack {
                Button(action: {
                    withAnimation {
                        self.isShow.toggle()
                        self.endTextEditing()
                    }
                }) {
                    VStack(alignment: .center, spacing: 0) {
                        Text("Huỷ").foregroundColor(Color.white)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                    }.background(RoundedRectangle(cornerRadius: 10).fill(Color.gray))
                        .padding(.top, 4)
                }
                Spacer()
                Button(action: {
                    withAnimation {
                        self.isShow.toggle()
                        self.endTextEditing()
                        onClickedYes()
                    }
                }) {
                    VStack(alignment: .center, spacing: 0) {
                        Text("Thêm")
                            .foregroundColor(Color.white)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 8)
                    }.background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                        .padding(.top, 4)
                }
            }
        }
        .onTapGesture {
            self.endTextEditing()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .frame(
            width: WV*0.7,
            height: HV*0.7
        )
    }
}
