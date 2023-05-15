//
//  CustomShape.swift
//  DSBC
//
//  Created by Quang Tran on 18/08/2022.
//  Copyright © 2022 BIN iMac 02. All rights reserved.
//

import Foundation
import SwiftUI

struct ViewWithTopCurve: Shape {
    
    var deep: CGFloat
    
    init(deep: CGFloat){
        self.deep = deep
    }
    
    func path(in rect: CGRect) -> Path {

        Path { path in
            //top left
            path.move(to: .zero)
            
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.minY),
                control: CGPoint(x: rect.midX, y: deep))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            
            path.closeSubpath()
        }
      
    }
}
