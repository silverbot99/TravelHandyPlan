//
//  TextView+Extension.swift
//  DraftProject_ProblemSloving_SwiftUI
//
//  Created by Admin on 17/01/2023.
//

import Foundation
import UIKit

extension UITextView {
    func addBottomBorderWithColor(color: UIColor, height: CGFloat) {
        guard let wrappedSuper = self.superview else {
            return
        }
        let border = UIView()
        border.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        border.frame = CGRect(x: self.frame.origin.x,y: self.frame.origin.y+self.frame.height-height, width: self.frame.width, height: height)
        border.backgroundColor = color
        wrappedSuper.insertSubview(border, aboveSubview: self)
    }
}
