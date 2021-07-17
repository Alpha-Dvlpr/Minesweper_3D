//
//  VerticalHintCell.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct VerticalHintCell: View {
    
    var sideCells: [Cell]?
    var callback: (() -> Void)
    
    var body: some View {
        VStack(
            alignment: .center,
            spacing: Constants.cellSpacing,
            content: {
                if let cells = self.sideCells {
                    ForEach((0..<cells.count), id: \.self) { index in
                        let cell = cells[index]
                        GameCell(cell: cell) { _ in self.callback() }
                    }
                }
            }
        )
    }
}

struct VerticalHintCell_Previews: PreviewProvider {
    static var previews: some View {
        VerticalHintCell(sideCells: [], callback: { })
    }
}
