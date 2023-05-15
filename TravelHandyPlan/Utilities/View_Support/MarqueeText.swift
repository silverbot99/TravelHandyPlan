//
//  MarqueeText.swift
//  DraftProject_ProblemSloving_SwiftUI
//
//  Created by Admin on 28/02/2023.
//

import SwiftUI

struct MarqueeText: ViewModifier {
    let duration: TimeInterval
    let direction: Direction
    let autoreverse: Bool

    @State private var offset = CGFloat.zero
    @State private var parentSize = CGSize.zero
    @State private var contentSize = CGSize.zero

    func body(content: Content) -> some View {
      // measures parent view width
      Color.clear
        .frame(height: 0)
        // measureSize from https://swiftuirecipes.com/blog/getting-size-of-a-view-in-swiftui
        .measureSize { size in
          parentSize = size
          updateAnimation(sizeChanged: true)
        }

      content
        .measureSize { size in
          contentSize = size
          updateAnimation(sizeChanged: true)
        }
        .offset(x: offset)
        // animationObserver from https://swiftuirecipes.com/blog/swiftui-animation-observer
        .animationObserver(for: offset, onComplete: {
          updateAnimation(sizeChanged: false)
        })
    }

    private func updateAnimation(sizeChanged: Bool) {
      if sizeChanged || !autoreverse {
        offset = max(parentSize.width, contentSize.width) * ((direction == .leftToRight) ? -1 : 1)
      }
      withAnimation(.linear(duration: duration)) {
        offset = -offset
      }
    }

    enum Direction {
      case leftToRight, rightToLeft
    }
  }

  extension View {
    func marquee(duration: TimeInterval,
                 direction: MarqueeText.Direction = .rightToLeft,
                 autoreverse: Bool = false) -> some View {
      self.modifier(MarqueeText(duration: duration,
                            direction: direction,
                            autoreverse: autoreverse))
    }
  }
