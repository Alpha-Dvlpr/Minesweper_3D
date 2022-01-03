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
    var references: References
    var cells: Board = Board([[]])
    var rotated: Face {
        let newFace = self
        newFace.cells = self.rotate(cells: self.cells, degrees: self.rotatedFromLastPosition)
        return newFace
    }
    var generated: Bool = false
    private var lastReferences = References()
    private var rotatedFromLastPosition: Degrees {
        switch self.references.top {
        case self.lastReferences.left: return .positiveQuart
        case self.lastReferences.right: return .negativeQuart
        case self.lastReferences.bottom: return .half
        default: return .none
        }
    }
    
    init(number: Int, references: References) {
        self.number = number
        self.references = references
        self.generateBoard()
    }
    
    // MARK: Face rotation methods
    // ===========================
    func updateNewReferences(from face: Face, to direction: Direction) {
        self.lastReferences = self.references
        
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
    
    func updateVisibleSides(with sides: BoardT_4) {
        let b = sides.t, top = b.0, bottom = b.1, left = b.2, right = b.3, last = Constants.numberOfItems - 1
        
        for index in 0..<top.count { self.cells.b[0][index].setTappability(top[index].shown) }
        for index in 0..<bottom.count { self.cells.b[last][index].setTappability(bottom[index].shown) }
        for index in 0..<left.count { self.cells.b[index][0].setTappability(left[index].shown) }
        for index in 0..<right.count { self.cells.b[index][last].setTappability(right[index].shown) }
    }
    
    private func rotate(cells: Board, degrees: Degrees) -> Board {
        switch degrees {
        case .positiveQuart: return Board(cells.b.transposed.reversedRows)
        case .negativeQuart: return Board(cells.b.transposed.reversedColumns)
        case .half: return Board(cells.b.reversedRows.reversedColumns)
        case .none: return cells
        }
    }

    // MARK: Board generation methods
    // ==============================
    private func generateBoard() {
        self.cells = Board(Constants.boardCells.map { self.generateRow(rowNumber: $0) })
    }
    
    private func generateRow(rowNumber: Int) -> [Cell] {
        return Constants.boardCells.map {
            let cell = Cell(face: self.number, xCor: $0, yCor: rowNumber, content: .unselected)
            return cell
        }
    }
}
