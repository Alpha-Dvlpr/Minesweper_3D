//
//  Face.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import Foundation

enum Degrees {
    case positiveQuart
    case negativeQuart
    case half
    case none
}

class Face: Identifiable {
    var id: UUID = UUID()
    var number: Int
    
    var topReference: Int = 0
    var bottomReference: Int = 0
    var leftReference: Int = 0
    var rightReference: Int = 0
    
    private var lastTop: Int = 0
    private var lastBottom: Int = 0
    private var lastLeft: Int = 0
    private var lastRight: Int = 0
    
    private var rotatedFromLastPosition: Degrees {
        switch self.topReference {
        case self.lastLeft: return .positiveQuart
        case self.lastRight: return .negativeQuart
        case self.lastBottom: return .half
        default: return .none
        }
    }
    
    var cells: [[Cell]] = [[]]
    
    init(number: Int) {
        self.number = number
        self.cells = self.generateBoard()
    }
    
    func rotated() -> Face {
        let newFace = self
        newFace.cells = self.rotate(cells: newFace.cells, degrees: self.rotatedFromLastPosition)
        return newFace
    }
    
    func updateLastPosition(
        top: Int,
        bottom: Int,
        left: Int,
        right: Int
    ) {
        self.lastTop = top
        self.lastBottom = bottom
        self.lastLeft = left
        self.lastRight = right
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
