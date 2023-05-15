//
//  TextEditorView.swift
//  DraftProject_ProblemSloving_SwiftUI
//
//  Created by Ngan Huynh on 11/04/2023.
//

import SwiftUI

struct TextEditorView: View {
    
    @Binding var string: String
    @State var hint: String = ""
    @State var fontString: Font = FontManager().textFont
    @State private var textEditorHeight : CGFloat = CGFloat()

    var body: some View {
        
        ZStack(alignment: .leading) {

            Text(string)
                .lineLimit(5)
                .font(fontString)
                .foregroundColor(.clear)
                .padding(.top, 5.0)
                .padding(.bottom, 7.0)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewHeightKey.self,
                                           value: $0.frame(in: .local).size.height)
                })
            
            TextEditor(text: $string)
//                .placeholder(when: string.isEmpty, placeholder: {
//                    Text(hint)
//                        .font(FontManager().textFont)
//                        .foregroundColor(Color(hex: 0x7b7b7b))
//                })
                .frame(height: textEditorHeight)
                .onTapGesture {
                    if string == "hint" {
                        string = ""
                    }
                }
//                .environment(\.prompt, "Type something...")
               
        }
        .onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0 }
        
    }
    
}

