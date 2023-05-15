//
//  BlockVietnameseTXT.swift
//  DSBC
//
//  Created by Admin on 01/12/2022.
//  Copyright © 2022 BIN iMac 02. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

struct dataTXT {
    var placeHolder: String = ""
    var content: String = ""
    var isTrue: Bool = true
    var errorMSG: String = "This field is required!"
}

struct BlockVietnameseTextField : UIViewRepresentable {
    typealias UIViewType = UIView

    @State var font: String = FontType.Regular.rawValue
    @State var fontSize: CGFloat = 18
    @State var fontColor = UIColor.black
    
    @Binding var textTXT: dataTXT
    @Binding var height: CGFloat

    var textView : UITextView = {
        let tf = UITextView()
        tf.isScrollEnabled = true
        tf.isEditable = true
        tf.backgroundColor = UIColor.yellow
        return tf
    }()
    
    func makeUIView(context: Context) -> UIView {
        let textView = UITextView(frame: .zero)

        textView.text = textTXT.placeHolder
        textView.textColor = UIColor(hex: "#3395ff", alpha: 0.6)
        textView.font = UIFont(name: font, size: fontSize)
        textView.spellCheckingType = .no
        textView.autocorrectionType = .no
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isScrollEnabled = false

        textView.delegate = context.coordinator
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        textView.text = textTXT.content
    }
    
    func makeCoordinator() -> BlockVietnameseTextField.Coordinator {
        Coordinator(textfield: self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        private let parent : BlockVietnameseTextField

       init(textfield : BlockVietnameseTextField) {
            self.parent = textfield
       }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor(hex: "#3395ff", alpha: 0.6) {
                textView.text = nil
                textView.textColor = parent.fontColor
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = parent.textTXT.placeHolder
                textView.textColor = UIColor(hex: "#3395ff", alpha: 0.6)
            }
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            //set size
            let size = textView.sizeThatFits(textView.frame.size)
            if size.width >= WV - 32 {
                let subString = textView.text.suffix(1)
                textView.text.removeLast(1)
                textView.text.append(contentsOf: "\n" +  subString)
                parent.height = textView.frame.height
            }
            return handleBlockVietnameseText(textView, shouldChangeTextIn: range, replacementString: text)
        }

        
        private func handleBlockVietnameseText(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementString string: String) -> Bool {
            var cursorPosition = 0
            if let selectedRange = textView.selectedTextRange {
                cursorPosition = textView.offset(from: textView.beginningOfDocument, to: selectedRange.start) + 1
            }
            
            let maximumCharacter = 10000
            if string.count > 1 {
                var removeCharacterSpace = string.replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
                let removeDiaratics = removeCharacterSpace.folding(options: .diacriticInsensitive, locale: .current)
                let component = removeDiaratics.components(separatedBy: getCharacterSet().inverted)
                removeCharacterSpace = component.joined(separator: "")
                removeCharacterSpace = removeDiaratics.replacingOccurrences(of: "đ", with: "d")
                removeCharacterSpace = removeDiaratics.replacingOccurrences(of: "Đ", with: "D")
                
                // Don't need to check type of textfield blockLoginUserName, it can extend to use for another type via maxLength field
                if removeCharacterSpace.count > maximumCharacter {
                    removeCharacterSpace = removeCharacterSpace.substring(from: 0, length: maximumCharacter) ?? ""
                }
                textView.text = removeCharacterSpace
                return false
            } else if string.isEmpty {
                guard let rangeString : Range<String.Index> = Range(range,in: textView.text ?? "") else { return false }
                textView.text = textView.text?.replacingCharacters(in: rangeString, with: "")
                textView.text = textView.text ?? ""
                if cursorPosition < textView.text?.count ?? 0 && textView.text?.count ?? 0 > 1 {
                    // Khi mà cursor position nhỏ hơn text hiện tại thì có nghĩa là đang xoá ở giữa
                    // Vì vậy cần phải chỉnh lại cursor cho đúng vị trí
                    var customSpaceForDelete = 0
                    if textView.text?.count ?? 0 >= 2 {
                        customSpaceForDelete = 2
                    } else if textView.text?.count ?? 0 == 1 {
                        customSpaceForDelete = 1
                    }
                    self.keepTheCurrentCursor(textView,cursorPosition: (textView.text?.count ?? 0) - cursorPosition + customSpaceForDelete)
                }
                return false
            } else if handleLimitLength(textView, shouldChangeTextIn: range, replacementText: string) {
                let components = string.components(separatedBy: getCharacterSet().inverted)
                let filtered = components.joined(separator: "")
                if string != filtered {
                    return false
                }
                
                var newContent = textView.text ?? ""
                var removeDiaratics = string.folding(options: .diacriticInsensitive, locale: .current)
                if removeDiaratics.first! == "đ" {
                    removeDiaratics = "d"
                }
                if removeDiaratics.first! == "Đ"{
                    removeDiaratics = "D"
                }
                let index = newContent.index(newContent.startIndex, offsetBy: range.location)
                guard let replaceCharacter = removeDiaratics.first else { return true }
                newContent.insert(replaceCharacter, at: index)
                textView.text = newContent
                if cursorPosition < textView.text?.count ?? 0 && textView.text?.count ?? 0 > 1 { // vì dòng này sau khi set text rồi
                    // Khi mà cursor position nhỏ hơn text hiện tại thì có nghĩa là đang xoá ở giữa
                    // Vì vậy cần phải chỉnh lại cursor cho đúng vị trí
                    self.keepTheCurrentCursor(textView,cursorPosition: (textView.text?.count ?? 0) - cursorPosition)
                }
                return false
            }
            return false
        }
        
        private func handleLimitLength(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return (textView.text?.count ?? 0) + (text.count - range.length) <= 10000
        }
        
        private func keepTheCurrentCursor(_ textView: UITextView, cursorPosition: Int) {
            if let selectedRange = textView.selectedTextRange {
                // and only if the new position is valid
                if let newPosition = textView.position(from: selectedRange.start, offset: -cursorPosition) {
                    // set the new position
                    textView.selectedTextRange = textView.textRange(from: newPosition, to: newPosition)
                }
            }
        }
        
        private func getCharacterSet() -> CharacterSet {
            var characterSet = CharacterSet()
            characterSet.formUnion(.lowercaseLetters) // e.g. a,b,c..
            characterSet.formUnion(.uppercaseLetters) // e.g. A,B,C..
            characterSet.formUnion(.decimalDigits) // e.g. 1,2,3
            characterSet.formUnion(.whitespaces) // " "
            characterSet.insert(charactersIn: "_.-") // Specific Characters
            
            return characterSet
        }

    }
}

