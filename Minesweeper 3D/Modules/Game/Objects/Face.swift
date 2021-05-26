//
//  Face.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import Foundation

class Face: Identifiable {
    var id: UUID = UUID()
    var number: Int
    var references = References()
    var cells: [[Cell]] = [[]]
    var rotated: Face {
        let newFace = self
        newFace.cells = self.rotate(cells: self.cells, degrees: self.rotatedFromLastPosition)
        return newFace
    }
    
    private var lastReferences = References()
    private var rotatedFromLastPosition: Degrees {
        switch self.references.top {
        case self.lastReferences.left: return .positiveQuart
        case self.lastReferences.right: return .negativeQuart
        case self.lastReferences.bottom: return .half
        default: return .none
        }
    }
    
    init(number: Int) {
        self.number = number
        self.cells = self.generateBoard()
    }
    
    func updateLastReferences() {
        self.lastReferences = self.references
    }
    
    func updateNewReferences(from face: Face, to direction: Direction) {
        switch direction {
        case .up:
            self.references.top = (7 - face.number)
            self.references.bottom = face.number
            self.references.left = face.references.left
            self.references.right = face.references.right
        case .down:
            self.references.top = face.number
            self.references.bottom = (7 - face.number)
            self.references.left = face.references.left
            self.references.right = face.references.right
        case .left:
            self.references.top = face.references.top
            self.references.bottom = face.references.bottom
            self.references.left = (7 - face.number)
            self.references.right = face.number
        case .right:
            self.references.top = face.references.top
            self.references.bottom = face.references.bottom
            self.references.left = face.number
            self.references.right = (7 - face.number)
        }
    }
    
    private func rotate(cells: [[Cell]], degrees: Degrees) -> [[Cell]] {
        switch degrees {
        case .positiveQuart: return cells.transposed.reversedRows
        case .negativeQuart: return cells.transposed.reversedColumns
        case .half: return cells.reversedRows.reversedColumns
        case .none: return cells
        }
    }

    private func generateBoard() -> [[Cell]] {
        return Constants.boardCells.map { self.generateRow(rowNumber: $0) }
    }
    
    private func generateRow(rowNumber: Int) -> [Cell] {
        return Constants.boardCells.map { return Cell($0, rowNumber) }
    }
}
