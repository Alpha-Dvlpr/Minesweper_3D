//
//  Hinter.swift
//  Minesweeper 3D
//
//  Created by Aaron on 13/7/21.
//

import Foundation

class Hinter {
    
    private let referencer = Referencer()
    
    func calculateHints(faces: FaceT_6, completion: @escaping ((FaceT_6) -> Void)) {
        let dispatchGroup = DispatchGroup()
        
        faces.i.forEach { face in
            dispatchGroup.enter()
            
            self.calculateInnerHints(for: face.cells) { hintedFace in
                face.cells = hintedFace
                dispatchGroup.leave()
            }
            
            if let vSides = self.referencer.getVerticalFaces(for: face.number, on: faces) {
                dispatchGroup.enter()
                self.calculateVerticalHints(for: face.cells, sides: vSides) { hintedFace in
                    face.cells = hintedFace
                    dispatchGroup.leave()
                }
            }

            if let hSides = self.referencer.getHorizontalFaces(for: face.number, on: faces) {
                dispatchGroup.enter()
                self.calculateHorizontalHints(for: face.cells, sides: hSides) { hintedFace in
                    face.cells = hintedFace
                    dispatchGroup.leave()
                }
            }
            
            if let corners = self.referencer.getCornerReferences(for: face.number, on: faces) {
                dispatchGroup.enter()
                self.calculateCornerHints(for: face.cells, sides: corners) { hintedFace in
                    face.cells = hintedFace
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { completion(faces) }
    }

    private func calculateInnerHints(for cells: Board, completion: @escaping ((Board) -> Void)) {
        cells.b
            .map { $0.filter { $0.type == .inner }.map { $0 } }
            .flatMap { $0 }
            .filter { $0.content != .mine }
            .forEach { cell in
                let surrounding = [
                    cells.b[cell.yCor - 1][cell.xCor],     // N  Cell
                    cells.b[cell.yCor - 1][cell.xCor + 1], // NE Cell
                    cells.b[cell.yCor][cell.xCor + 1],     // E  Cell
                    cells.b[cell.yCor + 1][cell.xCor + 1], // SE Cell
                    cells.b[cell.yCor + 1][cell.xCor],     // S  Cell
                    cells.b[cell.yCor + 1][cell.xCor - 1], // SW Cell
                    cells.b[cell.yCor][cell.xCor - 1],     // W  Cell
                    cells.b[cell.yCor - 1][cell.xCor - 1]  // NW Cell
                ]
                
                cell.updateContent(to: self.switchToMine(cell: cell, inside: surrounding).content)
            }
        
        completion(cells)
    }
    
    private func calculateVerticalHints(for cells: Board, sides: BoardT_2, completion: @escaping ((Board) -> Void)) {
        cells.b
            .map { $0.filter { $0.type == .vBorder }.map { $0 } }
            .flatMap { $0 }
            .filter { $0.content != .mine }
            .forEach { cell in
                var surrounding = [Cell]()
                
                if cell.xCor == 0 {
                    surrounding = [
                        cells.b[cell.yCor - 1][cell.xCor],     // N  Cell
                        cells.b[cell.yCor - 1][cell.xCor + 1], // NE Cell
                        cells.b[cell.yCor][cell.xCor + 1],     // E  Cell
                        cells.b[cell.yCor + 1][cell.xCor + 1], // SE Cell
                        cells.b[cell.yCor + 1][cell.xCor],     // S  Cell
                        sides.t.0[cell.yCor - 1],              // SW Cell
                        sides.t.0[cell.yCor],                  // W  Cell
                        sides.t.0[cell.yCor + 1]               // NW Cell
                    ]
                }
                
                if cell.xCor == Constants.numberOfItems - 1 {
                    surrounding = [
                        cells.b[cell.yCor + 1][cell.xCor],     // S  Cell
                        cells.b[cell.yCor + 1][cell.xCor - 1], // SW Cell
                        cells.b[cell.yCor][cell.xCor - 1],     // W  Cell
                        cells.b[cell.yCor - 1][cell.xCor - 1], // NW Cell
                        cells.b[cell.yCor - 1][cell.xCor],     // N  Cell
                        sides.t.1[cell.yCor - 1],              // NE Cell
                        sides.t.1[cell.yCor],                  // E  Cell
                        sides.t.1[cell.yCor + 1]               // SE Cell
                    ]
                }
                
                cell.updateContent(to: self.switchToMine(cell: cell, inside: surrounding).content)
            }
        
        completion(cells)
    }
    
    private func calculateHorizontalHints(for cells: Board, sides: BoardT_2, completion: @escaping ((Board) -> Void) ) {
        cells.b
            .map { $0.filter { $0.type == .hBorder }.map { $0 } }
            .flatMap { $0 }
            .filter { $0.content != .mine }
            .forEach { cell in
                var surrounding = [Cell]()
                
                if cell.yCor == 0 {
                    surrounding = [
                        cells.b[cell.yCor][cell.xCor + 1],     // E  Cell
                        cells.b[cell.yCor + 1][cell.xCor + 1], // SE Cell
                        cells.b[cell.yCor + 1][cell.xCor],     // S  Cell
                        cells.b[cell.yCor + 1][cell.xCor - 1], // SW Cell
                        cells.b[cell.yCor][cell.xCor - 1],     // W  Cell
                        sides.t.0[cell.xCor - 1],              // NW Cell
                        sides.t.0[cell.xCor],                  // N  Cell
                        sides.t.0[cell.xCor + 1]               // NE Cell
                    ]
                }
                
                if cell.yCor == Constants.numberOfItems - 1 {
                    surrounding = [
                        cells.b[cell.yCor][cell.xCor - 1],     // W  Cell
                        cells.b[cell.yCor - 1][cell.xCor - 1], // NW Cell
                        cells.b[cell.yCor - 1][cell.xCor],     // N  Cell
                        cells.b[cell.yCor - 1][cell.xCor + 1], // NE Cell
                        cells.b[cell.yCor][cell.xCor + 1],     // E  Cell
                        sides.t.1[cell.xCor + 1],              // SE Cell
                        sides.t.1[cell.xCor],                  // S  Cell
                        sides.t.1[cell.xCor - 1]               // SW Cell
                    ]
                }
                
                cell.updateContent(to: self.switchToMine(cell: cell, inside: surrounding).content)
            }
        
        completion(cells)
    }
    
    private func calculateCornerHints(for cells: Board, sides: BoardT_4, completion: @escaping ((Board) -> Void) ) {
        let lastIndex = Constants.numberOfItems - 1
        
        cells.b
            .map { $0.filter { $0.type == .corner }.map { $0 } }
            .flatMap { $0 }
            .filter { $0.content != .mine }
            .forEach { cell in
                var surrounding = [Cell]()
                
                if cell.xCor == 0 && cell.yCor == 0 {
                    surrounding = [
                        cells.b[cell.yCor][cell.xCor + 1],       // E  Cell
                        cells.b[cell.yCor + 1][cell.xCor + 1],   // SE Cell
                        cells.b[cell.yCor + 1][cell.xCor],       // S  Cell
                        sides.t.2[1], sides.t.2[0], sides.t.0[1] // SW - W - NW Cells
                    ]
                }
                
                if cell.xCor == lastIndex && cell.yCor == 0 {
                    surrounding = [
                        cells.b[cell.yCor + 1][cell.xCor],     // S  Cell
                        cells.b[cell.yCor + 1][cell.xCor - 1], // SW Cell
                        cells.b[cell.yCor][cell.xCor - 1],     // W  Cell
                        sides.t.0[lastIndex - 1],              // NW Cell
                        sides.t.0[lastIndex], sides.t.3[1]     // N - NE Cells
                    ]
                }
                
                if cell.xCor == 0 && cell.yCor == lastIndex {
                    surrounding = [
                        cells.b[cell.yCor - 1][cell.xCor],     // N  Cell
                        cells.b[cell.yCor - 1][cell.xCor + 1], // NE Cell
                        cells.b[cell.yCor][cell.xCor + 1],     // E  Cell
                        sides.t.1[1], sides.t.1[0],            // SE - S Cells
                        sides.t.2[lastIndex - 1]               // NW Cell
                    ]
                }
                
                if cell.xCor == lastIndex && cell.yCor == lastIndex {
                    surrounding = [
                        cells.b[cell.yCor][cell.xCor - 1],     // W  Cell
                        cells.b[cell.yCor - 1][cell.xCor - 1], // NW Cell
                        cells.b[cell.yCor - 1][cell.xCor],     // N  Cell
                        sides.t.3[lastIndex - 1],              // NE Cell
                        sides.t.3[lastIndex],                  // N  Cell
                        sides.t.1[lastIndex - 1]               // E  Cell
                    ]
                }
                
                cell.updateContent(to: self.switchToMine(cell: cell, inside: surrounding).content)
            }
        
        completion(cells)
    }
    
    private func switchToMine(cell: Cell, inside cells: [Cell]) -> Cell {
        var counter = 0
        
        cells.forEach { counter += $0.content == .mine ? 1 : 0 }
        
        cell.updateContent(to: counter == 0 ? .void : .number(counter))
        
        return cell
    }
}
