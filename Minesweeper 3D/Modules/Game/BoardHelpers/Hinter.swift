//
//  Hinter.swift
//  Minesweeper 3D
//
//  Created by Aaron on 13/7/21.
//

import Foundation

class Hinter {
    
    private let referencer: Referencer
    
    init(referencer: Referencer) {
        self.referencer = referencer
    }
    
    func calculateHints(faces: FaceT_6, completion: @escaping ((FaceT_6) -> Void)) {
        let dispatchGroup = DispatchGroup()
        
        faces.i.forEach { face in
//            dispatchGroup.enter()
//            self.calculateInnerHints(for: face.cells) { hintedFace in
//                face.cells = hintedFace
//                dispatchGroup.leave()
//            }
        
//            if let vSides = self.referencer.getVerticalFaces(for: face.number, on: faces) {
//                dispatchGroup.enter()
//                self.calculateVerticalHints(for: face.cells, sides: vSides.b) { hintedFace in
//                    face.cells = hintedFace
//                    dispatchGroup.leave()
//                }
//            }
            
//            if let hSides = self.referencer.getHorizontalFaces(for: face.number, on: faces) {
//                dispatchGroup.enter()
//                self.calculateHorizontalHints(for: face.cells, sides: hSides.b) { hintedFace in
//                    face.cells = hintedFace
//                    dispatchGroup.leave()
//                }
//            }
            
//            if let corners = self.referencer.getCornerReferences(for: face.number, on: faces) {
//                dispatchGroup.enter()
//                self.calculateCornerHints(for: face.cells, sides: corners.b) { hintedFace in
//                    face.cells = hintedFace
//                    dispatchGroup.leave()
//                }
//            }
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
    
    private func calculateVerticalHints(
        for cells: Board,
        sides: (Board, Board),
        completion: @escaping ((Board) -> Void)
    ) {
        let aux = cells.b
        let vBorderCells = aux
            .map { $0.filter { $0.type == .vBorder }.map { $0 } }
            .flatMap { $0 }
            .filter { $0.content != .mine }
        let lastIndex = Constants.numberOfItems - 1
        
        vBorderCells.forEach { cell in
            var surrounding = [Cell]()
            
            if cell.xCor == 0 {
                let lfc = sides.0.b
                
                surrounding = [
                    aux[cell.yCor - 1][cell.xCor],     // N  Cell
                    aux[cell.yCor - 1][cell.xCor + 1], // NE Cell
                    aux[cell.yCor][cell.xCor + 1],     // E  Cell
                    aux[cell.yCor + 1][cell.xCor + 1], // SE Cell
                    aux[cell.yCor + 1][cell.xCor],     // S  Cell
                    lfc[cell.yCor - 1][lastIndex - 1], // SW Cell
                    lfc[cell.yCor][lastIndex - 1],     // W  Cell
                    lfc[cell.yCor + 1][lastIndex - 1]  // NW Cell
                ]
            }
            
            if cell.xCor == Constants.numberOfItems - 1 {
                let rfc = sides.1.b
                
                surrounding = [
                    aux[cell.yCor + 1][cell.xCor],     // S  Cell
                    aux[cell.yCor + 1][cell.xCor - 1], // SW Cell
                    aux[cell.yCor][cell.xCor - 1],     // W  Cell
                    aux[cell.yCor - 1][cell.xCor - 1], // NW Cell
                    aux[cell.yCor - 1][cell.xCor],     // N  Cell
                    rfc[cell.yCor - 1][1],             // NE Cell
                    rfc[cell.yCor][1],                 // E  Cell
                    rfc[cell.yCor + 1][1]              // SE Cell
                ]
            }
            
            cell.updateContent(to: self.switchToMine(cell: cell, inside: surrounding).content)
        }
        
        completion(Board(aux))
    }
    
    private func calculateHorizontalHints(
        for cells: Board,
        sides: (Board, Board),
        completion: @escaping ((Board) -> Void)
    ) {
        let aux = cells.b
        let hBorderCells = aux
            . map { $0.filter { $0.type == .hBorder }.map { $0 } }
            .flatMap { $0 }
            .filter { $0.content != .mine }
        let lastIndex = Constants.numberOfItems - 1
        
        hBorderCells.forEach { cell in
            var surrounding = [Cell]()
            
            if cell.yCor == 0 {
                let tfc = sides.0.b
                
                surrounding = [
                    aux[cell.yCor][cell.xCor + 1],     // E  Cell
                    aux[cell.yCor + 1][cell.xCor + 1], // SE Cell
                    aux[cell.yCor + 1][cell.xCor],     // S  Cell
                    aux[cell.yCor + 1][cell.xCor - 1], // SW Cell
                    aux[cell.yCor][cell.xCor - 1],     // W  Cell
                    tfc[lastIndex - 1][cell.xCor - 1], // NW Cell
                    tfc[lastIndex - 1][cell.xCor],     // N  Cell
                    tfc[lastIndex - 1][cell.xCor + 1]  // NE Cell
                ]
            }
            
            if cell.yCor == Constants.numberOfItems - 1 {
                let bfc = sides.1.b
                
                surrounding = [
                    aux[cell.yCor][cell.xCor - 1],     // W  Cell
                    aux[cell.yCor - 1][cell.xCor - 1], // NW Cell
                    aux[cell.yCor - 1][cell.xCor],     // N  Cell
                    aux[cell.yCor - 1][cell.xCor + 1], // NE Cell
                    aux[cell.yCor][cell.xCor + 1],     // E  Cell
                    bfc[1][cell.xCor + 1],             // SE Cell
                    bfc[1][cell.xCor],                 // S  Cell
                    bfc[1][cell.xCor - 1]              // SW Cell
                ]
            }
            
            cell.updateContent(to: self.switchToMine(cell: cell, inside: surrounding).content)
        }
        
        completion(Board(aux))
    }
    
    private func calculateCornerHints(
        for cells: Board,
        sides: (Board, Board, Board, Board),
        completion: @escaping ((Board) -> Void)
    ) {
        let aux = cells.b
        let corners = aux
            .map { $0.filter { $0.type == .corner }.map { $0 } }
            .flatMap { $0 }
            .filter { $0.content != .mine }
        
        corners.forEach { cell in
            var surrounding = [Cell]()
            
            if cell.xCor == 0 && cell.yCor == 0 {
                surrounding = [
                    aux[cell.yCor][cell.xCor + 1],     // E  Cell
                    aux[cell.yCor + 1][cell.xCor + 1], // SE Cell
                    aux[cell.yCor + 1][cell.xCor]      // S  Cell
                ]
            }
            
            if cell.xCor == 9 && cell.yCor == 0 {
                surrounding = [
                    aux[cell.yCor + 1][cell.xCor],     // S  Cell
                    aux[cell.yCor + 1][cell.xCor - 1], // SW Cell
                    aux[cell.yCor][cell.xCor - 1]      // W  Cell
                ]
            }
            
            if cell.xCor == 0 && cell.yCor == 9 {
                surrounding = [
                    aux[cell.yCor - 1][cell.xCor],     // N  Cell
                    aux[cell.yCor - 1][cell.xCor + 1], // NE Cell
                    aux[cell.yCor][cell.xCor + 1]      // E  Cell
                ]
            }
            
            if cell.xCor == 9 && cell.yCor == 9 {
                surrounding = [
                    aux[cell.yCor][cell.xCor - 1],     // W  Cell
                    aux[cell.yCor - 1][cell.xCor - 1], // NW Cell
                    aux[cell.yCor - 1][cell.xCor]      // N  Cell
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
