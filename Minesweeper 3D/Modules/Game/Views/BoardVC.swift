//
//  BoardVC.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct BoardVC: View {
    
    var face: Face
    var boardCallback: ((Cell) -> Void)
    
    var body: some View {
        VStack(
            alignment: .center,
            spacing: Constants.cellSpacing,
            content: {
                ForEach(Constants.boardCells, id: \.self) { line in
                    HStack(
                        alignment: .center,
                        spacing: Constants.cellSpacing,
                        content: {
                            ForEach(Constants.boardCells, id: \.self) { columnn in
                                let cell = self.face.cells.b[line][columnn]
                                CellVC(cell: cell) { self.boardCallback($0) }
                            }
                        }
                    )
                }
            }
        )
    }
}

struct BoardVC_Previews: PreviewProvider {
    static var previews: some View {
        BoardVC(
            face: Face(
                number: 4,
                references: References(4, top: 5, bottom: 2, left: 1, right: 6)
            ),
            boardCallback: { _ in }
        )
    }
}
