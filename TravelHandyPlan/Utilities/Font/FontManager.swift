//
//  FontManager.swift
//  MoneyLeftCoreData
//
//  Created by Ngan Huynh on 22/05/2022.
//

import Foundation
import UIKit
import SwiftUI

var scaleRatio: CGFloat = 1

enum FontType: String {
    case Black = "RobotoSlab-Black"
    case ExtraBold = "RobotoSlab-ExtraBold"
    case Bold = "RobotoSlab-Bold"
    case SemiBold = "RobotoSlab-SemiBold"
    case Light = "RobotoSlab-Light"
    case ExtraLight = "RobotoSlab-ExtraLight"
    case Medium = "RobotoSlab-Medium"
    case Regular = "RobotoSlab-Regular"
    case Thin = "RobotoSlab-Thin"
}

struct FontManager {
//    var Black: String {
//        return "RobotoSlab-Black"
//    }
//
//    var ExtraBold: String {
//        return "RobotoSlab-ExtraBold"
//    }
//
//    var Bold: String {
//        return "RobotoSlab-Bold"
//    }
//
//    var SemiBold: String {
//        return "RobotoSlab-SemiBold"
//    }
//
//    var Light: String{
//        return "RobotoSlab-Light"
//    }
//    var ExtraLight: String{
//        return "RobotoSlab-ExtraLight"
//    }
//    var Medium: String{
//        return "RobotoSlab-Medium"
//    }
//    var Regular: String{
//        return "RobotoSlab-Regular"
//    }
//    var Thin: String{
//        return "RobotoSlab-Thin"
//    }
    
    var themeFont : Font = {
        return .custom(FontType.Regular.rawValue, size: 14)
    }()
    
    var textFont : Font = {
        return .custom(FontType.Regular.rawValue, size: 13)
    }()
    
    var noteFont : Font = {
        return .custom(FontType.Light.rawValue, size: 12)
    }()
}
