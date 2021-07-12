//
//  Cell.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 14/05/2021.
//

import SwiftUI

class Cell: Hashable {
    private var id: String { return "\(self.face)-\(self.xCor).\(self.yCor)-\(self.content)" }
    private var face: Int
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
    var canBeEdited: Bool = true
    
    init(
        face: Int,
        xCor: Int,
        yCor: Int,
        content: CellContent
    ) {
        self.xCor = xCor
        self.yCor = yCor
        self.originalContent = content
        self.face = face
    }
    
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.xCor == rhs.xCor
            && lhs.yCor == rhs.yCor
            && lhs.type == rhs.type
            && lhs.id == rhs.id
            && lhs.face == rhs.face
            && lhs.canBeEdited == rhs.canBeEdited
    }
    
    static func >> (cell: Cell, face: Int) -> Cell {
        let cell = Cell(face: face, xCor: cell.xCor, yCor: cell.yCor, content: cell.originalContent)
        cell.canBeEdited = false
        
        return cell
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.xCor)
        hasher.combine(self.yCor)
        hasher.combine(self.type)
        hasher.combine(self.id)
        hasher.combine(self.face)
        hasher.combine(self.canBeEdited)
    }
    
    func updateContent(to content: CellContent) {
        self.originalContent = content
    }
}
