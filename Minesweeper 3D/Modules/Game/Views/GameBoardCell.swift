//
//  GameBoardCell.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct GameBoardCell: View {
    
    var face: Face
    var boardCallback: ((_ x: Int, _ y: Int) -> Void)
    
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
                                cell.image
                                    .resizable()
                                    .frame(width: Constants.cellSide, height: Constants.cellSide)
                                    .foregroundColor(
                                        cell.shown
                                            ? cell.type.color
                                            : nil
                                    )
                                    .onTapGesture { self.boardCallback(cell.xCor, cell.yCor) }
                            }
                        }
                    )
                }
            }
        )
    }
}

struct GameBoardCell_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardCell(face: Face(number: 4), boardCallback: { (_, _) in })
    }
}
