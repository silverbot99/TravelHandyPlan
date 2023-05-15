//
//  String+Extension.swift
//  MoneyLeftCoreData
//
//  Created by Ngan Huynh on 18/05/2022.
//

import Foundation
import UIKit

extension String {
    
    func hiddenPhoneNumber() -> String {
        let firstTwoLetter: String = self.substring(toIndex: 2)
        let lastTwoLetter: String = self.substring(from: self.length - 2, length: self.length) ?? ""
        
        return "\(firstTwoLetter)******\(lastTwoLetter)"
    }
    
    func removeCharacterFromNumber() -> String {
        let okayChars: Set<Character> =
            Set("+-×÷1234567890")
        return String(self.filter { okayChars.contains($0) })
    }
    
    func formatMoneyValue() -> String {
        if self.isEmpty {
            return ""
        }
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        return numberFormatter.string(from: NSNumber(value: Double(self)?.rounded() ?? 0)) ?? ""
    }
    
    /// Converts the given String to a String.
    public var string: String {
        return self
    }
    
    func substring(from: Int?, length: Int) -> String? {
        guard length > 0 else { return nil }
        let start = from ?? 0
        let end = min(count, max(0, start) + length)
        guard start < end else { return nil }
        return self[start..<end].string
    }
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    func frameSize(maxWidth: CGFloat? = nil, maxHeight: CGFloat? = nil) -> CGSize {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .body)
        ]
        let attributedText = NSAttributedString(string: self, attributes: attributes)
        let width = maxWidth != nil ? min(maxWidth!, CGFloat.greatestFiniteMagnitude) : CGFloat.greatestFiniteMagnitude
        let height = maxHeight != nil ? min(maxHeight!, CGFloat.greatestFiniteMagnitude) : CGFloat.greatestFiniteMagnitude
        let constraintBox = CGSize(width: width, height: height)
        let rect = attributedText.boundingRect(with: constraintBox, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).integral
        return rect.size
    }
}

extension String: Error {}
