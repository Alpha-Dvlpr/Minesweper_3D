//
//  HorizontalHintCell.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct HorizontalHintCell: View {
    
    var sideScreen: Int
    
    var body: some View {
        HStack(
            alignment: .center,
            spacing: Constants.cellSpacing,
            content: {
                ForEach(Constants.boardCells, id: \.self) { _ in
                    Images.numbers(self.sideScreen).image
                        .resizable()
                        .frame(width: Constants.cellSide, height: Constants.cellSide)
//                        .foregroundColor(nil)
                }
            }
        )
    }
}

struct HorizontalHintCell_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalHintCell(sideScreen: 4)
    }
}
