//
//  VisualEffectView.swift
//  DraftProject_ProblemSloving_SwiftUI
//
//  Created by Admin on 16/01/2023.
//

import Foundation
import UIKit
import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

