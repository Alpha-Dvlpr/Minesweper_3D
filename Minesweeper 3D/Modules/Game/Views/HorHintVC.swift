//
//  HorHintVC.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import SwiftUI

struct HorHintVC: View {
    
    var sideCells: [Cell]?
    var callback: (() -> Void)
    
    var body: some View {
        HStack(
            alignment: .center,
            spacing: Constants.cellSpacing,
            content: {
                if let cells = self.sideCells {
                    ForEach((0..<cells.count), id: \.self) { index in
                        let cell = cells[index]
                        CellVC(cell: cell) { _ in self.callback() }
                    }
                }
            }
        )
    }
}

struct HorHintVC_Previews: PreviewProvider {
    static var previews: some View {
        HorHintVC(sideCells: [], callback: { })
    }
}
