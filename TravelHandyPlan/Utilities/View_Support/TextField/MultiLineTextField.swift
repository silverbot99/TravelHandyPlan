//
//  MultiLineTextField.swift
//  DraftProject_ProblemSloving_SwiftUI
//
//  Created by Admin on 17/01/2023.
//

import Foundation
import SwiftUI

struct MultiLineTextField : UIViewRepresentable {
    typealias UIViewType = UIView

    @State var maxLenght: Int = 50000
    @State var font: String = FontType.Regular.rawValue
    @State var fontSize: CGFloat = 18
    @State var fontColor = UIColor.black
        
    @State var title: String = "Vấn đề là gì ?"
    
    @State var placeholder: String = "Viết gì đó..."
    @State var placeColor: UIColor = UIColor(hex: "#000000", alpha: 0.5)

    @State var backgroundColor = UIColor.white

    @Binding var content: String

    @Binding var width: CGFloat

    @Binding var height: CGFloat

    let onTextChange: (String) -> Void
    
    var textView : UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = true
        tf.isEditable = true
        tf.backgroundColor = UIColor.yellow
        return tf
    }()
    
    func makeUIView(context: Context) -> UIView {
        let textView = UITextView(frame: .zero)

        if (!content.isEmpty) && (content != placeholder) {
            textView.text = content
            textView.textColor = fontColor
        }
        else {
            textView.text = placeholder
            textView.textColor = placeColor
        }
        
        textView.font = UIFont(name: font, size: fontSize)
        textView.spellCheckingType = .no
        textView.autocorrectionType = .no
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = false
        textView.layer.borderColor = UIColor.clear.cgColor
        textView.layer.borderWidth = 0.0
        textView.backgroundColor = backgroundColor

        textView.delegate = context.coordinator
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        textView.text = content
    }
    
    func makeCoordinator() -> MultiLineTextField.Coordinator {
        Coordinator(textfield: self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        private let parent : MultiLineTextField

       init(textfield : MultiLineTextField) {
            self.parent = textfield
       }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == parent.placeColor {
                textView.text = nil
                textView.textColor = parent.fontColor
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.placeholder
                textView.textColor = parent.placeColor
            }
            parent.onTextChange(textView.text)
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            //set size
            let size = textView.sizeThatFits(textView.frame.size)
            if size.width >= parent.width {
                let subString = textView.text.suffix(1)
                textView.text.removeLast(1)
                textView.text.append(contentsOf: "\n" +  subString)
                parent.width = textView.frame.width
                parent.height = textView.frame.height
            }
            return textView.text.count + (text.count - range.length) <= parent.maxLenght

        }
    }
}
