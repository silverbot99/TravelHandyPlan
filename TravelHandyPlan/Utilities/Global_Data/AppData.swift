//
//  AppData.swift
//  DraftProject_ProblemSloving_SwiftUI
//
//  Created by Admin on 24/02/2023.
//

import Foundation
import SwiftUI

public var WV = UIScreen.main.bounds.width
public var HV = UIScreen.main.bounds.height

enum FeatureTab {
    case Dashboard
    case Plan
    case Profile
    
    func getIcon() -> String {
        switch self {
        case .Dashboard:
            return "house"
        case .Plan:
            return "plus"
        case .Profile:
            return "person.fill"
        }
    }
    func getTitle() -> String {
        switch self {
        case .Dashboard:
            return "Home"
        case .Plan:
            return ""
        case .Profile:
            return "Setting"
        }
    }
}
