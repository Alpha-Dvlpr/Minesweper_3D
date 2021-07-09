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
        var generatedMines = 0
        let board = Constants.boardCells.map { self.generateRow(rowNumber: $0) }
        
        repeat {
            let selectedCoordinates = self.generateRandomCoords()
            let cell = board[selectedCoordinates.0][selectedCoordinates.1]
            
            if cell.content == .mine { continue }
            else {
                board[selectedCoordinates.0][selectedCoordinates.1].updateContent(to: .mine)
                generatedMines += 1
            }
        } while (generatedMines < Constants.numberOfMinesPerFace)
        
        return self.generateMineHints(for: board)
    }
    
    private func generateRow(rowNumber: Int) -> [Cell] {
        return Constants.boardCells.map {
            return Cell(face: self.number, xCor: $0, yCor: rowNumber, content: .unselected)
        }
    }
    
    private func generateRandomCoords() -> (Int, Int) {
        let number = Int(arc4random_uniform(UInt32(Constants.numberOfItems)))
        
        return (number, number)
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
