//
//  GameBoardCell.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct GameBoardCell: View {
    
    var face: Face
    var boardCallback: (() -> Void)
    
    var body: some View {
        VStack(
            alignment: .center,
            spacing: Constants.cellSpacing,
            content: {
                ForEach(self.face.cells, id: \.self) { line in
                    HStack(
                        alignment: .center,
                        spacing: Constants.cellSpacing,
                        content: {
                            ForEach(line, id: \.self) { cell in
                                Text("\(cell.xCor),\(cell.yCor)")
                                    .multilineTextAlignment(.center)
                                    .frame(width: Constants.cellSide, height: Constants.cellSide)
                                    .background(cell.type.color)
                                    .border(Color.gray, width: 1)
                                    .font(.caption)
                            }
                        }
                    )
                }
            }
        )
        .onTapGesture { self.boardCallback() }
    }
}

struct GameBoardCell_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardCell(face: Face(number: 4), boardCallback: { })
    }
}
