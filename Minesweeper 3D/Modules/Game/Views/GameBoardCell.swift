//
//  GameBoardCell.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct GameBoardCell: View {
    
    var face: Face
    var boardCallback: ((Cell) -> Void)
    
    var body: some View {
        VStack(
            alignment: .center,
            spacing: Constants.cellSpacing,
            content: {
                ForEach(self.face.cells.b, id: \.self) { line in
                    HStack(
                        alignment: .center,
                        spacing: Constants.cellSpacing,
                        content: {
                            ForEach(line, id: \.self) { cell in GameCell(cell: cell) { self.boardCallback($0) } }
                        }
                    )
                }
            }
        )
    }
}

struct GameBoardCell_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardCell(
            face: Face(
                number: 4,
                references: References(top: 5, bottom: 2, left: 1, right: 6)
            ),
            boardCallback: { _ in }
        )
    }
}
