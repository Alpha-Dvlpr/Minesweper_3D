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
        let aux = cells.b
        let innerCells: [Cell] = aux
            .map { $0.filter { $0.type == .inner }.map { $0 } }
            .flatMap { $0 }
            .filter { $0.content != .mine }
        
        innerCells.forEach { cell in
            let surrounding = [
                aux[cell.yCor - 1][cell.xCor],     // N  Cell
                aux[cell.yCor - 1][cell.xCor + 1], // NE Cell
                aux[cell.yCor][cell.xCor + 1],     // E  Cell
                aux[cell.yCor + 1][cell.xCor + 1], // SE Cell
                aux[cell.yCor + 1][cell.xCor],     // S  Cell
                aux[cell.yCor + 1][cell.xCor - 1], // SW Cell
                aux[cell.yCor][cell.xCor - 1],     // W  Cell
                aux[cell.yCor - 1][cell.xCor - 1]  // NW Cell
            ]
            
            cell.updateContent(to: self.switchToMine(cell: cell, inside: surrounding).content)
        }
        
        completion(Board(aux))
    }
    
    private func calculateVerticalHints(for cells: Board, sides: BoardT_2, completion: @escaping ((Board) -> Void)) {
        let aux = cells.b
        let vBorderCells = aux
            .map { $0.filter { $0.type == .vBorder }.map { $0 } }
            .flatMap { $0 }
            .filter { $0.content != .mine }
        
        vBorderCells.forEach { cell in
            var surrounding = [Cell]()
            
            if cell.xCor == 0 {
                let lfc = sides.t.0
                
                surrounding = [
                    aux[cell.yCor - 1][cell.xCor],     // N  Cell
                    aux[cell.yCor - 1][cell.xCor + 1], // NE Cell
                    aux[cell.yCor][cell.xCor + 1],     // E  Cell
                    aux[cell.yCor + 1][cell.xCor + 1], // SE Cell
                    aux[cell.yCor + 1][cell.xCor],     // S  Cell
                    lfc[cell.yCor - 1],                // SW Cell
                    lfc[cell.yCor],                    // W  Cell
                    lfc[cell.yCor + 1]                 // NW Cell
                ]
            }
            
            if cell.xCor == Constants.numberOfItems - 1 {
                let rfc = sides.t.1
                
                surrounding = [
                    aux[cell.yCor + 1][cell.xCor],     // S  Cell
                    aux[cell.yCor + 1][cell.xCor - 1], // SW Cell
                    aux[cell.yCor][cell.xCor - 1],     // W  Cell
                    aux[cell.yCor - 1][cell.xCor - 1], // NW Cell
                    aux[cell.yCor - 1][cell.xCor],     // N  Cell
                    rfc[cell.yCor - 1],                // NE Cell
                    rfc[cell.yCor],                    // E  Cell
                    rfc[cell.yCor + 1]                 // SE Cell
                ]
            }
            
            cell.updateContent(to: self.switchToMine(cell: cell, inside: surrounding).content)
        }
        
        completion(Board(aux))
    }
    
    private func calculateHorizontalHints(for cells: Board, sides: BoardT_2, completion: @escaping ((Board) -> Void) ) {
        let aux = cells.b
        let hBorderCells = aux
            . map { $0.filter { $0.type == .hBorder }.map { $0 } }
            .flatMap { $0 }
            .filter { $0.content != .mine }
        
        hBorderCells.forEach { cell in
            var surrounding = [Cell]()
            
            if cell.yCor == 0 {
                let tfc = sides.t.0
                
                surrounding = [
                    aux[cell.yCor][cell.xCor + 1],     // E  Cell
                    aux[cell.yCor + 1][cell.xCor + 1], // SE Cell
                    aux[cell.yCor + 1][cell.xCor],     // S  Cell
                    aux[cell.yCor + 1][cell.xCor - 1], // SW Cell
                    aux[cell.yCor][cell.xCor - 1],     // W  Cell
                    tfc[cell.xCor - 1],                // NW Cell
                    tfc[cell.xCor],                    // N  Cell
                    tfc[cell.xCor + 1]                 // NE Cell
                ]
            }
            
            if cell.yCor == Constants.numberOfItems - 1 {
                let bfc = sides.t.1
                
                surrounding = [
                    aux[cell.yCor][cell.xCor - 1],     // W  Cell
                    aux[cell.yCor - 1][cell.xCor - 1], // NW Cell
                    aux[cell.yCor - 1][cell.xCor],     // N  Cell
                    aux[cell.yCor - 1][cell.xCor + 1], // NE Cell
                    aux[cell.yCor][cell.xCor + 1],     // E  Cell
                    bfc[cell.xCor + 1],                // SE Cell
                    bfc[cell.xCor],                    // S  Cell
                    bfc[cell.xCor - 1]                 // SW Cell
                ]
            }
            
            cell.updateContent(to: self.switchToMine(cell: cell, inside: surrounding).content)
        }
        
        completion(Board(aux))
    }
    
    private func calculateCornerHints( for cells: Board, sides: BoardT_4, completion: @escaping ((Board) -> Void) ) {
        let aux = cells.b
        let corners = aux
            .map { $0.filter { $0.type == .corner }.map { $0 } }
            .flatMap { $0 }
            .filter { $0.content != .mine }
        let tfc = sides.t.0
        let bfc = sides.t.1
        let lfc = sides.t.2
        let rfc = sides.t.3
        
        corners.forEach { cell in
            var surrounding = [Cell]()
            
            if cell.xCor == 0 && cell.yCor == 0 {
                surrounding = [
                    aux[cell.yCor][cell.xCor + 1],     // E  Cell
                    aux[cell.yCor + 1][cell.xCor + 1], // SE Cell
                    aux[cell.yCor + 1][cell.xCor],     // S  Cell
                    lfc[1], lfc[0], tfc[1]             // SW - W - NW Cells
                ]
            }
            
            if cell.xCor == 9 && cell.yCor == 0 {
                surrounding = [
                    aux[cell.yCor + 1][cell.xCor],     // S  Cell
                    aux[cell.yCor + 1][cell.xCor - 1], // SW Cell
                    aux[cell.yCor][cell.xCor - 1],     // W  Cell
                    tfc[8], tfc[9], rfc[1]             // NW - N - NE Cells
                ]
            }
            
            if cell.xCor == 0 && cell.yCor == 9 {
                surrounding = [
                    aux[cell.yCor - 1][cell.xCor],     // N  Cell
                    aux[cell.yCor - 1][cell.xCor + 1], // NE Cell
                    aux[cell.yCor][cell.xCor + 1],     // E  Cell
                    bfc[1], bfc[0], lfc[8]             // SE - S - NW Cells
                ]
            }
            
            if cell.xCor == 9 && cell.yCor == 9 {
                surrounding = [
                    aux[cell.yCor][cell.xCor - 1],     // W  Cell
                    aux[cell.yCor - 1][cell.xCor - 1], // NW Cell
                    aux[cell.yCor - 1][cell.xCor],     // N  Cell
                    rfc[8], rfc[9], bfc[8]             // NE - N - E Cells
                ]
            }
            
            cell.updateContent(to: self.switchToMine(cell: cell, inside: surrounding).content)
        }
        
        completion(Board(aux))
    }
    
    private func switchToMine(cell: Cell, inside cells: [Cell]) -> Cell {
        var counter = 0
        
        cells.forEach { counter += $0.content == .mine ? 1 : 0 }
        
        cell.updateContent(to: counter == 0 ? .void : .number(counter))
        
        return cell
    }
}
