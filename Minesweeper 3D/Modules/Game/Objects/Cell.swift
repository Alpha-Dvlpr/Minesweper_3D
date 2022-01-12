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
        else if self.mined { return .mine }
        else { return self.originalContent }
    }
    var shown: Bool = false
    var tappable: Bool = true
    var flagged: Bool = false
    var mined: Bool = false
    var canBeEdited: Bool = true
    var isVoid: Bool {
        return self.face == -1
            && self.xCor == -1
            && self.yCor == -1
            && self.content == .unselected
    }
    var isMine: Bool { return self.originalContent == .mine }
    private var face: Int
    private var originalContent: CellContent
    
    static var void: Cell { return Cell(face: -1, xCor: -1, yCor: -1, content: .unselected) }
    
    init(face: Int, xCor: Int, yCor: Int, content: CellContent) {
        self.xCor = xCor
        self.yCor = yCor
        self.originalContent = content
        self.face = face
    }
    
    init(cellCD: CellCD) {
        self.xCor = cellCD.xCor
        self.yCor = cellCD.yCor
        self.shown = cellCD.shown
        self.tappable = cellCD.tappable
        self.flagged = cellCD.flagged
        self.mined = cellCD.mined
        self.canBeEdited = cellCD.canBeEdited
        self.face = cellCD.face
        self.originalContent = cellCD.originalContent
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
    
    func update(with action: Action, completion: @escaping ((Cell, GameStatus) -> Void)) {
        func continueGame() { completion(self, .running) }
        
        switch action {
        case .number:
            if self.flagged { break }
            self.makeVisible { completion(self, $0) }
        case .flag:
            if self.mined { break }
            self.flagged.toggle()
            continueGame()
        case .mine:
            if self.flagged { break }
            self.mined.toggle()
            continueGame()
        case .hint:
            self.flagged = false
            self.mined = false
            self.shown = true
            self.tappable = false
            self.reduceHintCounter()
            continueGame()
        }
    }
    
    func setTappability(_ shown: Bool) {
        self.shown = shown
        self.tappable = !shown
    }
    
    private func makeVisible(callback: @escaping ((GameStatus) -> Void)) {
        switch self.originalContent {
        case .mine: callback(.lost)
        case .number:
            self.unmine()
            callback(.running)
        case .void:
            self.unmine()
            callback(.recurssive)
        default: break
        }
    }
    
    private func unmine() {
        if self.mined { self.mined = false }
        self.shown = true
        self.tappable = false
    }
    
    private func reduceHintCounter() {
        
    }
    
    func getCellCD() -> CellCD {
        return CellCD(
            xCor: self.xCor,
            yCor: self.yCor,
            shown: self.shown,
            tappable: self.tappable,
            flagged: self.flagged,
            mined: self.mined,
            canBeEdited: self.canBeEdited,
            face: self.face, 
            originalContent: self.originalContent
        )
    }
}
