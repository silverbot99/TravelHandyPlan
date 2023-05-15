//
//  Dash_Line.swift
//  DSBC
//
//  Created by Quang Tran on 04/05/2022.
//  Copyright © 2022 BIN iMac 02. All rights reserved.
//

import SwiftUI

struct Dash_Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
