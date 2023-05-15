//
//  Font+Extension.swift
//  TravelHandyPlan
//
//  Created by Ngan Huynh on 15/05/2023.
//

import Foundation
import SwiftUI

extension Font {
    func custom(_ type: FontType, size: CGFloat) -> Font {
        return .custom(type.rawValue, size: size)
    }
}
