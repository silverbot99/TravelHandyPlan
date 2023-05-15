//
//  View+Extension.swift
//  MoneyLeftCoreData
//
//  Created by Ngan Huynh on 17/05/2022.
//

import Foundation
import SwiftUI

extension View {
    func endTextEditing(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func toast(message: String,
                 isShowing: Binding<Bool>,
                 config: Toast.Config) -> some View {
        self.modifier(Toast(message: message,
                            isShowing: isShowing,
                            config: config))
      }

      func toast(message: String,
                 isShowing: Binding<Bool>,
                 duration: TimeInterval) -> some View {
        self.modifier(Toast(message: message,
                            isShowing: isShowing,
                            config: .init(duration: duration)))
      }
    
        func measureSize(perform action: @escaping (CGSize) -> Void) -> some View {
        self.modifier(MeasureSizeModifier())
          .onPreferenceChange(SizePreferenceKey.self, perform: action)
      }
    
    func animationObserver<Value: VectorArithmetic>(for value: Value,
                                                        onChange: ((Value) -> Void)? = nil,
                                                        onComplete: (() -> Void)? = nil) -> some View {
        self.modifier(AnimationObserverModifier(for: value,
                                                     onChange: onChange,
                                                     onComplete: onComplete))
    }
    func hLeading() -> some View {
        self.frame(
            maxWidth: .infinity, alignment: .leading
        )
    }
    
    func hTrailing() -> some View {
        self.frame(
            maxWidth: .infinity, alignment: .leading
        )
    }
    
    func hCenter() -> some View {
        self.frame(
            maxWidth: .infinity, alignment: .center
        )
    }
    
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}

//extension View {
////    convenience func alert(isPresented: Binding<Bool>, content: () -> Alert) -> some View
//    convenience init<Alert: View>(isPresented: Binding<Bool>, ) -> some View
//}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension  UITextField {
   @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
      self.resignFirstResponder()
   }
}


struct MeasureSizeModifier: ViewModifier {
  func body(content: Content) -> some View {
    content.background(GeometryReader { geometry in
      Color.clear.preference(key: SizePreferenceKey.self,
                             value: geometry.size)
    })
  }
}
