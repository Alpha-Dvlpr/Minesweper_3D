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
                let surrounding = cells.getInnerSideCells(at: (cell.yCor, cell.xCor))
                cell.updateContent(to: self.switchToMine(cell: cell, inside: surrounding).content)
            }
        
        completion(cells)
    }
    
    private func calculateVerticalHints(for cells: Board, sides: BoardT_2, completion: @escaping ((Board) -> Void)) {
        cells.b
            .map { $0.filter { $0.type.isVSide }.map { $0 } }
            .flatMap { $0 }
            .filter { $0.content != .mine }
            .forEach { cell in
                switch cell.type {
                case .vBorder(let side):
                    var surrounding = cells.getVBorderSideCells(at: cell.yCor, side: side)
                    
                    switch side {
                    case .left:
                        let appending = [sides.t.0[cell.yCor - 1], sides.t.0[cell.yCor], sides.t.0[cell.yCor + 1]]
                        surrounding.append(contentsOf: appending)
                    case .right:
                        let appending = [sides.t.1[cell.yCor - 1], sides.t.1[cell.yCor], sides.t.1[cell.yCor + 1]]
                        surrounding.append(contentsOf: appending)
                    }
                    
                    cell.updateContent(to: self.switchToMine(cell: cell, inside: surrounding).content)
                default: break
                }
            }
        
        completion(cells)
    }
    
    private func calculateHorizontalHints(for cells: Board, sides: BoardT_2, completion: @escaping ((Board) -> Void) ) {
        cells.b
            .map { $0.filter { $0.type.isHSide }.map { $0 } }
            .flatMap { $0 }
            .filter { $0.content != .mine }
            .forEach { cell in
                switch cell.type {
                case .hBorder(let side):
                    var surrounding = cells.getHBorderSideCells(at: cell.xCor, side: side)
                    
                    switch side {
                    case .top:
                        let appending = [sides.t.0[cell.xCor - 1], sides.t.0[cell.xCor], sides.t.0[cell.xCor + 1]]
                        surrounding.append(contentsOf: appending)
                    case .bottom:
                        let appending = [sides.t.1[cell.xCor + 1], sides.t.1[cell.xCor], sides.t.1[cell.xCor - 1]]
                        surrounding.append(contentsOf: appending)
                    }
                    
                    cell.updateContent(to: self.switchToMine(cell: cell, inside: surrounding).content)
                default: break
                }
            }
        
        completion(cells)
    }
    
    private func calculateCornerHints(for cells: Board, sides: BoardT_4, completion: @escaping ((Board) -> Void) ) {
        let lastIndex = Constants.numberOfItems - 1
        
        cells.b
            .map { $0.filter { $0.type.isCorner }.map { $0 } }
            .flatMap { $0 }
            .filter { $0.content != .mine }
            .forEach { cell in
                switch cell.type {
                case .corner(let corner):
                    var surrounding = cells.getCornerSideCells(at: corner)
                    
                    switch corner {
                    case .tL:
                        let appending = [sides.t.2[1], sides.t.2[0], sides.t.0[1]]
                        surrounding.append(contentsOf: appending)
                    case .tR:
                        let appending = [sides.t.0[lastIndex - 1], sides.t.0[lastIndex], sides.t.3[1]]
                        surrounding.append(contentsOf: appending)
                    case .bL:
                        let appending = [sides.t.1[1], sides.t.1[0], sides.t.2[lastIndex - 1]]
                        surrounding.append(contentsOf: appending)
                    case .bR:
                        let appending = [sides.t.3[lastIndex - 1], sides.t.3[lastIndex], sides.t.1[lastIndex - 1]]
                        surrounding.append(contentsOf: appending)
                    }
                    
                    cell.updateContent(to: self.switchToMine(cell: cell, inside: surrounding).content)
                default: break
                }
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
