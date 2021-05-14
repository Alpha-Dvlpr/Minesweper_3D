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
}

class Face: Identifiable {
    var id: UUID = UUID()
    var number: Int
    var topReference: Int = 0
    var bottomReference: Int = 0
    var leftReference: Int = 0
    var rightReference: Int = 0
    
    var cells: [[Cell]] = [[]]
    
    init(number: Int) {
        self.number = number
        self.cells = self.generateBoard()
    }
    
    func rotated(degrees: Degrees) -> Face {
        let newFace = self
        newFace.cells = self.rotate(cells: newFace.cells, degrees: degrees)
        return newFace
    }
    
    private func rotate(cells: [[Cell]], degrees: Degrees) -> [[Cell]] {
        switch degrees {
        case .positiveQuart: return cells.transposed.reversedRows
        case .negativeQuart: return cells.transposed.reversedColumns
        case .half: return cells.reversedRows.reversedColumns
        }
    }

    private func generateBoard() -> [[Cell]] {
        return Constants.boardCells.map { self.generateRow(rowNumber: $0) }
    }
    
    private func generateRow(rowNumber: Int) -> [Cell] {
        return Constants.boardCells.map { return Cell($0, rowNumber) }
    }
}
