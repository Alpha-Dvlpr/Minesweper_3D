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
    var cells: [[Cell]] = [[]]
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
    }
    
    func hideAllCells() {
        for line in self.cells { for cell in line { cell.shown = false } }
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

    /// Faces have following order: Top, Bottom, Left, Right. It is the same as the init for 'References' class.
    func generateBoard(faces: (Face, Face, Face, Face), completion: @escaping (() -> Void)) {
        var board = Constants.boardCells.map { self.generateRow(rowNumber: $0) }
        
        if faces.0.generated { board = self.updateHorizontalLines(on: board, from: faces.0) }
        if faces.1.generated { board = self.updateHorizontalLines(on: board, from: faces.1) }
        if faces.2.generated { board = self.updateVerticalLines(on: board, from: faces.2) }
        if faces.3.generated { board = self.updateVerticalLines(on: board, from: faces.3) }
        
        let minedBoard = self.placeMines(on: board)
        let hintedBoard = self.generateMineHints(for: minedBoard)
        
        self.cells = hintedBoard
        self.generated = true
        
        completion()
    }
    
    private func generateRow(rowNumber: Int) -> [Cell] {
        return Constants.boardCells.map {
            return Cell(face: self.number, xCor: $0, yCor: rowNumber, content: .unselected)
        }
    }
    
    private func updateHorizontalLines(on board: [[Cell]], from face: Face) -> [[Cell]] {
        var auxBoard = board
        
        switch face.number {
        case self.references.top:
            // Take last line and place it as the first
            guard let lastReferenceLine = face.cells.last else { break }
            auxBoard[0] = lastReferenceLine
        case self.references.bottom:
            // Take first line and place it as the last
            guard let firstReferenceLine = face.cells.first else { break }
            auxBoard[auxBoard.count - 1] = firstReferenceLine
        default: break
        }
        
        return auxBoard
    }
    
    private func updateVerticalLines(on board: [[Cell]], from face: Face) -> [[Cell]] {
        var auxBoard = board
        
        switch face.number {
        case self.references.left:
            // Take last column and place it as the first
            let lastReferenceColumn = face.cells.map { $0.last }.compactMap { $0 }
            
            guard lastReferenceColumn.count == auxBoard.count else { break }
            
            for index in 0..<auxBoard.count { auxBoard[index][0] = lastReferenceColumn[index] }
        case self.references.right:
            // Take first column and place it as the last
            let firstReferenceColumn = face.cells.map { $0.first }.compactMap { $0 }
            
            guard firstReferenceColumn.count == auxBoard.count else { break }
            
            for index in 0..<auxBoard.count { auxBoard[index][auxBoard.count - 1] = firstReferenceColumn[index] }
        default: break
        }
        
        return auxBoard
    }
    
    private func placeMines(on board: [[Cell]]) -> [[Cell]] {
        var generatedMines = board.map { $0.filter { $0.content == .mine }.count }.reduce(0, +)
        
        repeat {
            let selectedCoordinates = self.generateRandomCoords()
            let cell = board[selectedCoordinates.0][selectedCoordinates.1]
            
            if cell.content == .mine { continue }
            else {
                board[selectedCoordinates.0][selectedCoordinates.1].updateContent(to: .mine)
                generatedMines += 1
            }
        } while (generatedMines < Constants.numberOfMinesPerFace)
        
        return board
    }
    
    private func generateRandomCoords() -> (Int, Int) {
        let number1 = Int(arc4random_uniform(UInt32(Constants.numberOfItems)))
        let number2 = Int(arc4random_uniform(UInt32(Constants.numberOfItems)))
        
        return (number1, number2)
    }
    
    private func generateMineHints(for cells: [[Cell]]) -> [[Cell]] {
        let aux = cells
        
        for row in aux {
            for cell in row {
                if cell.content == .mine { continue }
                
                var counter = 0
                
                switch cell.type {
                case .corner: break
                case .vBorder: break
                case .hBorder: break
                case .inner:
                    [
                        aux[cell.yCor][cell.xCor - 1],     // Nort Cell
                        aux[cell.yCor + 1][cell.xCor - 1], // North East Cell
                        aux[cell.yCor + 1][cell.xCor],     // East Cell
                        aux[cell.yCor + 1][cell.xCor + 1], // South East Cell
                        aux[cell.yCor][cell.xCor + 1],     // South Cell
                        aux[cell.yCor - 1][cell.xCor + 1], // South West Cell
                        aux[cell.yCor - 1][cell.xCor],     // West Cell
                        aux[cell.yCor - 1][cell.xCor - 1]  // North West Cell
                    ].forEach { if $0.content == .mine { counter += 1 } }
                }
                
                cell.updateContent(to: counter == 0 ? .void : .number(counter))
            }
        }
        
        return aux
    }
}
