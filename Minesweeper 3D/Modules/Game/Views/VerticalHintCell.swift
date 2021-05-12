//
//  VerticalHintCell.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct VerticalHintCell: View {
    
    var sideScreen: Int
    
    var body: some View {
        VStack(
            alignment: .center,
            spacing: Constants.cellSpacing,
            content: {
                ForEach(Constants.boardCells, id: \.self) { _ in
                    Text("\(self.sideScreen)")
                        .bold()
                        .multilineTextAlignment(.center)
                        .frame(width: Constants.cellSide, height: Constants.cellSide)
                        .background(Color.green)
                        .border(Color.gray, width: 1)
                }
            }
        )
    }
}

struct VerticalHintCell_Previews: PreviewProvider {
    static var previews: some View {
        VerticalHintCell(sideScreen: 4)
    }
}
