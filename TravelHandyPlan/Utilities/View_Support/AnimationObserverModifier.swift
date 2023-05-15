//
//  AnimationObserverModifier.swift
//  DraftProject_ProblemSloving_SwiftUI
//
//  Created by Admin on 28/02/2023.
//

import Foundation
import SwiftUI

public struct AnimationObserverModifier<Value: VectorArithmetic>: AnimatableModifier {
  // this is the view property that drives the animation - offset, opacity, etc.
  private let observedValue: Value
  private let onChange: ((Value) -> Void)?
  private let onComplete: (() -> Void)?

  // SwiftUI implicity sets this value as the animation progresses
  public var animatableData: Value {
    didSet {
      notifyProgress()
    }
  }

  public init(for observedValue: Value,
              onChange: ((Value) -> Void)?,
              onComplete: (() -> Void)?) {
    self.observedValue = observedValue
    self.onChange = onChange
    self.onComplete = onComplete
    animatableData = observedValue
  }

  public func body(content: Content) -> some View {
    content
  }

  private func notifyProgress() {
    DispatchQueue.main.async {
      onChange?(animatableData)
      if animatableData == observedValue {
        onComplete?()
      }
    }
  }
}
