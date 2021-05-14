//
//  Cell.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 14/05/2021.
//

import Foundation

class Cell: Hashable {
    var xCor: Int
    var yCor: Int
    var type: CellType { return CellType.init(x: self.xCor, y: self.yCor) }
    
    init(
        _ xCor: Int,
        _ yCor: Int
    ) {
        self.xCor = xCor
        self.yCor = yCor
    }
    
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.xCor == rhs.xCor
            && lhs.yCor == rhs.yCor
            && lhs.type == rhs.type
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.xCor)
        hasher.combine(self.yCor)
        hasher.combine(self.type)
    }
}
