//
//  Range+Extension.swift
//  DraftProject_ProblemSloving_SwiftUI
//
//  Created by Admin on 16/01/2023.
//

import Foundation
import SwiftUI

extension ForEach where Data == Range<Int>, ID == Int, Content : View {

    /// Creates an instance that computes views on demand over a *constant*
    /// range.
    ///
    /// This instance only reads the initial value of `data` and so it does not
    /// need to identify views across updates.
    ///
    /// To compute views on demand over a dynamic range use
    /// `ForEach(_:id:content:)`.
    init(_ data: Range<Int>, @ViewBuilder content: @escaping (Int) -> Content) {
        self.init(data, id: \.self, content: content)
    }
}
