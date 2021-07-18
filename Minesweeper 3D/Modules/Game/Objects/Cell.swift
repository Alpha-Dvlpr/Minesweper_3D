//
//  Cell.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 14/05/2021.
//

import SwiftUI

class Cell {
    
    var id: String { return "\(self.face)-\(self.xCor).\(self.yCor)-\(self.content)" }
    var xCor: Int
    var yCor: Int
    var type: CellType { return CellType.init(x: xCor, y: yCor) }
    var content: CellContent {
        if self.flagged { return .flagged }
        else { return self.originalContent }
    }
    var shown: Bool = false
    var flagged: Bool = false
    var canBeEdited: Bool = true
    var isVoid: Bool {
        return self.face == -1
            && self.xCor == -1
            && self.yCor == -1
            && self.content == .unselected
        
    }
    private var face: Int
    private var originalContent: CellContent
    
    static var void: Cell { return Cell(face: -1, xCor: -1, yCor: -1, content: .unselected) }
    
    init(face: Int, xCor: Int, yCor: Int, content: CellContent) {
        self.xCor = xCor
        self.yCor = yCor
        self.originalContent = content
        self.face = face
    }
    
    static func << (cell: Cell, coords: (Int, Int)) -> Cell {
        let cell = Cell(face: cell.face, xCor: coords.0, yCor: coords.1, content: cell.content)
        return cell
    }
    
    static func << (cell: Cell, face: Int) -> Cell {
        let cell = Cell(face: face, xCor: cell.xCor, yCor: cell.yCor, content: cell.originalContent)
        cell.canBeEdited = false
        
        return cell
    }
    
    func updateContent(to content: CellContent) {
        self.originalContent = content
    }
}
