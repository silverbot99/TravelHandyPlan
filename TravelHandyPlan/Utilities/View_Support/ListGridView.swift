//
//  ListGridView.swift
//  DSBC
//
//  Created by Admin on 15/11/2022.
//  Copyright © 2022 BIN iMac 02. All rights reserved.
//

import SwiftUI

struct ListGridView<Content: View>: View { //2 item in 1 line
    @State var numsInRow: Int = 2
    
    @State var totalCount: Int = 0
    
    @State var spacing: CGFloat = 0
    
    let content: (Int) -> Content // Conent in index
    
    var body: some View {
        VStack(spacing: 0) {
            
            if totalCount % numsInRow != 0 {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    ForEach(0..<((totalCount % numsInRow) + (totalCount / numsInRow)), id: \.self) { row in
                        
                        if row < (totalCount % numsInRow) + (totalCount / numsInRow) - 1 {
                            HStack(alignment: .center, spacing: 8) {
                                ForEach(0..<numsInRow) { index in
                                    content(index)                                    
                                }
                            }
                        }
                        else {
                            HStack(alignment: .center, spacing: 8) {
                                content(totalCount - 1)
                                
                                //Repeat view and hide it to
                                content(totalCount - 1).opacity(0)
                            }
                        }
                    }
                }
                
            }
            else {
                VStack(alignment: .leading, spacing: 16) {
                    
                    ForEach(0..<(totalCount / numsInRow), id: \.self) { row in
                        
                        HStack(alignment: .center, spacing: spacing) {
                            ForEach(0..<numsInRow) { index in
                                content(index)
                            }
                        }
                    }
                }
                
            }
        }
    }
}

struct ListGridForItemView<T: Any, Content: View>: View {
    @State var numsInRow: Int = 2

    @State var listData: [T] = []
    

    let content: (Int) -> Content // Conent in index

    var body: some View {
        ListGridView(numsInRow: numsInRow, totalCount: listData.count, spacing: 16) { index in
            ForEach( 0 ..< (listData.count), id: \.self) { pos in
                Group {
                    if pos == index {
                        content(index)
                    }
                }
            }
        }
    }
}


