//
//  Cell.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 14/05/2021.
//

import SwiftUI

class Cell: Hashable {
    private var id: String
    var xCor: Int
    var yCor: Int
    var type: CellType { return CellType.init(x: self.xCor, y: self.yCor) }
    private var originalContent: CellContent
    var content: CellContent {
        if self.flagged { return .flagged }
        else { return self.originalContent }
    }
    var shown: Bool = false
    var flagged: Bool = false
    
    init(
        face: Int,
        xCor: Int,
        yCor: Int,
        content: CellContent
    ) {
        self.xCor = xCor
        self.yCor = yCor
        self.originalContent = content
        self.id = "\(face)-\(xCor).\(yCor)-\(content)"
    }
    
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.xCor == rhs.xCor
            && lhs.yCor == rhs.yCor
            && lhs.type == rhs.type
            && lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.xCor)
        hasher.combine(self.yCor)
        hasher.combine(self.type)
        hasher.combine(self.id)
    }
    
    func updateContent(to content: CellContent) {
        self.originalContent = content
    }
}
