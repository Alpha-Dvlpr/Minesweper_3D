//
//  FaceUpdater.swift
//  Minesweeper 3D
//
//  Created by Aaron on 12/7/21.
//

import Foundation

class FaceUpdater {

    // MARK: Board updation functions
    // ==============================
    func updateFaces(faces: FaceT_6, completion: @escaping ((FaceT_6) -> Void)) {
        self.updateFace1(face1: faces.t.0) { f1c in
            faces.t.0.cells = f1c
            self.updateFace2(face1: faces.t.0, face2: faces.t.1) { f2c in
                faces.t.1.cells = f2c
                self.updateFace3(
                    input: FaceT_2((faces.t.0, faces.t.1)),
                    face3: faces.t.2
                ) { f3c in
                    faces.t.2.cells = f3c
                    self.updateFace4(
                        input: FaceT_2((faces.t.0, faces.t.1)),
                        face4: faces.t.3
                    ) { f4c in
                        faces.t.3.cells = f4c
                        self.updateFace5(
                            input: FaceT_3((faces.t.0, faces.t.2, faces.t.3)),
                            face5: faces.t.4
                        ) { f5c in
                            faces.t.4.cells = f5c
                            self.updateFace6(
                                input: FaceT_4((faces.t.1, faces.t.2, faces.t.3, faces.t.4)),
                                face6: faces.t.5
                            ) { f6c in
                                faces.t.5.cells = f6c
                                
                                self.calculateHints(faces: faces) { completion($0) }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func updateFace1(face1: Face, completion: @escaping ((Board) -> Void)) {
        self.placeMines(on: (face1.cells)) { completion($0) }
    }
    
    private func updateFace2(face1: Face, face2: Face, completion: @escaping ((Board) -> Void)) {
        guard let face1LasLine = face1.cells.b.last,
              face1LasLine.count == Constants.numberOfItems
        else { completion(face2.cells); return }
        
        face2.cells.b[0] = face1LasLine.map { return $0 >> 2 }
        
        self.placeMines(on: face2.cells) { completion($0) }
    }
    
    private func updateFace3(input: FaceT_2, face3: Face, completion: @escaping ((Board) -> Void)) {
        let face1FirstColumn = input.t.0.cells.b.map { $0.first }.compactMap { $0 }
        let face2FirstColumn = input.t.1.cells.b.map { $0.first }.compactMap { $0 }
        let lastIndex = Constants.numberOfItems - 1
        
        guard face1FirstColumn.count == Constants.numberOfItems,
              face2FirstColumn.count == Constants.numberOfItems
        else { completion(face3.cells); return }
        
        let face1Converted = face1FirstColumn.map { return $0 >> 3 }
        (0..<lastIndex).forEach { face3.cells.b[$0][lastIndex] = face1Converted[$0] }
        
        face3.cells.b[lastIndex] = face2FirstColumn.map { return $0 >> 3 }.reversed()
        
        self.placeMines(on: face3.cells) { completion($0) }
    }
    
    private func updateFace4(input: FaceT_2, face4: Face, completion: @escaping ((Board) -> Void)) {
        let face1LastColumn = input.t.0.cells.b.map { $0.last }.compactMap { $0 }
        let face2LastColumn = input.t.1.cells.b.map { $0.last }.compactMap { $0 }
        let lastIndex = Constants.numberOfItems - 1
        
        guard face1LastColumn.count == Constants.numberOfItems,
              face2LastColumn.count == Constants.numberOfItems
        else { completion(face4.cells); return }
        
        let face1Converted = face1LastColumn.map { return $0 >> 4 }
        (0..<lastIndex).forEach { face4.cells.b[$0][0] = face1Converted[$0] }
        
        let face2Converted = face2LastColumn.map { return $0 >> 4 }
        face4.cells.b[lastIndex] = face2Converted
        
        self.placeMines(on: face4.cells) { completion($0) }
    }
    
    private func updateFace5(input: FaceT_3, face5: Face, completion: @escaping ((Board) -> Void)) {
        guard let face1FirstLine = input.t.0.cells.b.first,
              let face3FirstLine = input.t.1.cells.b.first,
              let face4FirstLine = input.t.2.cells.b.first,
              face1FirstLine.count == Constants.numberOfItems,
              face3FirstLine.count == Constants.numberOfItems,
              face4FirstLine.count == Constants.numberOfItems
        else { completion(face5.cells); return }
        let lastIndex = Constants.numberOfItems - 1
        
        face5.cells.b[lastIndex] = face1FirstLine.map { return $0 >> 5 }
        
        let face3Converted = face3FirstLine.map { return $0 >> 5 }
        (0..<lastIndex).forEach { face5.cells.b[$0][0] = face3Converted[$0] }
        
        let face4Converted = face4FirstLine.map { return $0 >> 5 }
        (0..<lastIndex).forEach { face5.cells.b[$0][lastIndex] = face4Converted.reversed()[$0] }
        
        self.placeMines(on: face5.cells) { completion($0) }
    }
    
    private func updateFace6(input: FaceT_4, face6: Face, completion: @escaping ((Board) -> Void)) {
        let face3FirstColumn = input.t.1.cells.b.map { $0.first }.compactMap { $0 }
        let face4LastColumn = input.t.2.cells.b.map { $0.last }.compactMap { $0 }
        let lastIndex = Constants.numberOfItems - 1
        
        guard let face2LastLine = input.t.0.cells.b.last,
              let face5FirstLine = input.t.3.cells.b.first,
              face2LastLine.count == Constants.numberOfItems,
              face3FirstColumn.count == Constants.numberOfItems,
              face4LastColumn.count == Constants.numberOfItems,
              face5FirstLine.count == Constants.numberOfItems
        else { completion(face6.cells); return }
        
        face6.cells.b[0] = face2LastLine.map { return $0 >> 6 }
        
        let face3Converted = face3FirstColumn.map { return $0 >> 6 }
        (0..<lastIndex).forEach { face6.cells.b[$0][0] = face3Converted.reversed()[$0] }
        
        let face4Converted = face4LastColumn.map { return $0 >> 6 }
        (0..<lastIndex).forEach { face6.cells.b[$0][lastIndex] = face4Converted.reversed()[$0] }
        
        face6.cells.b[lastIndex] = face5FirstLine.map { return $0 >> 6 }
        
        self.placeMines(on: face6.cells) { completion($0) }
    }
    
    // MARK: Mine generation functions
    // ===============================
    private func placeMines(on board: Board, completion: @escaping ((Board) -> Void)) {
        var generatedMines = board.b.map { $0.filter { $0.content == .mine }.count }.reduce(0, +)
        
        while generatedMines < Constants.numberOfMinesPerFace {
            let coords = self.generateRandomCoords()
            let cell = board.b[coords.0][coords.1]

            if cell.content == .mine || !cell.canBeEdited { continue }
            else {
                board.b[coords.0][coords.1].updateContent(to: .mine)
                generatedMines += 1
            }
            
            cell.canBeEdited = false
        }

        completion(board)
    }

    private func generateRandomCoords() -> (Int, Int) {
        let number1 = Int(arc4random_uniform(UInt32(Constants.numberOfItems)))
        let number2 = Int(arc4random_uniform(UInt32(Constants.numberOfItems)))
        
        return (number1, number2)
    }
    
    // MARK: Mine hint generation functions
    // ====================================
    func calculateHints(faces: FaceT_6, completion: @escaping ((FaceT_6) -> Void)) {
        let dispatchGroup = DispatchGroup()
        
        faces.i.forEach { face in
            
        }
        
        dispatchGroup.enter()
        self.calculateInnerHints(for: faces.t.0.cells) { hf1 in
            faces.t.0.cells = hf1
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        self.calculateVerticalHints(
            for: faces.t.0.cells,
            sides: (faces.t.2.cells, faces.t.3.cells)
        ) { hf1 in
            faces.t.0.cells = hf1
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        self.calculateHorizontalHints(
            for: faces.t.0.cells,
            sides: (faces.t.4.cells, faces.t.1.cells)
        ) { hf1 in
            faces.t.0.cells = hf1
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) { completion(faces) }
    }

    private func calculateInnerHints(for cells: Board, completion: @escaping ((Board) -> Void)) {
        let aux = cells.b
        
        for line in aux {
            for cell in line {
                if cell.content == .mine || cell.type != .inner { continue }
                
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
                
                let tempCell = self.switchToMine(cell: cell, inside: surrounding)
                
                cell.updateContent(to: tempCell.content)
            }
        }
        
        completion(Board(aux))
    }
    
    private func calculateVerticalHints(
        for cells: Board,
        sides: (Board, Board),
        completion: @escaping ((Board) -> Void)
    ) {
        let aux = cells.b
        
        for line in aux {
            for cell in line {
                if cell.content == .mine || cell.type != .vBorder { continue }
                
                var surrounding = [Cell]()
                
                if cell.xCor == 0 {
                    surrounding = [
                        aux[cell.yCor - 1][cell.xCor],     // N  Cell
                        aux[cell.yCor - 1][cell.xCor + 1], // NE Cell
                        aux[cell.yCor][cell.xCor + 1],     // E  Cell
                        aux[cell.yCor + 1][cell.xCor + 1], // SE Cell
                        aux[cell.yCor + 1][cell.xCor]      // S  Cell
                    ]
                } else if cell.xCor == Constants.numberOfItems - 1 {
                    surrounding = [
                        aux[cell.yCor + 1][cell.xCor],     // S  Cell
                        aux[cell.yCor + 1][cell.xCor - 1], // SW Cell
                        aux[cell.yCor][cell.xCor - 1],     // W  Cell
                        aux[cell.yCor - 1][cell.xCor - 1], // NW Cell
                        aux[cell.yCor - 1][cell.xCor]      // N  Cell
                    ]
                }
                
                let tempCell = self.switchToMine(cell: cell, inside: surrounding)
                
                cell.updateContent(to: tempCell.content)
            }
        }
        
        completion(Board(aux))
    }
    
    private func calculateHorizontalHints(
        for cells: Board,
        sides: (Board, Board),
        completion: @escaping ((Board) -> Void)
    ) {
        let aux = cells.b
        
        for line in aux {
            for cell in line {
                if cell.content == .mine || cell.type != .hBorder { continue }
                
                var surrounding = [Cell]()
                
                if cell.yCor == 0 {
                    surrounding = [
                        aux[cell.yCor][cell.xCor + 1],     // E  Cell
                        aux[cell.yCor + 1][cell.xCor + 1], // SE Cell
                        aux[cell.yCor + 1][cell.xCor],     // S  Cell
                        aux[cell.yCor + 1][cell.xCor - 1], // SW Cell
                        aux[cell.yCor][cell.xCor - 1]      // W Cell
                    ]
                } else if cell.yCor == Constants.numberOfItems - 1 {
                    surrounding = [
                        aux[cell.yCor][cell.xCor - 1],     // W  Cell
                        aux[cell.yCor - 1][cell.xCor - 1], // NW Cell
                        aux[cell.yCor - 1][cell.xCor],     // N  Cell
                        aux[cell.yCor - 1][cell.xCor + 1], // NE Cell
                        aux[cell.yCor][cell.xCor + 1]      // E  Cell
                    ]
                }
                
                let tempCell = self.switchToMine(cell: cell, inside: surrounding)
                
                cell.updateContent(to: tempCell.content)
            }
        }
        
        completion(Board(aux))
    }
    
    private func switchToMine(cell: Cell, inside cells: [Cell]) -> Cell {
        var counter = 0
        
        cells.forEach { counter += $0.content == .mine ? 1 : 0 }
        
        cell.updateContent(to: counter == 0 ? .void : .number(counter))
        
        return cell
    }
    
    // MARK: DEBUG functions
    // =====================
    // swiftlint:disable line_length
    func debug_face1MineGeneration() -> Board {
        let cells = [
            [Cell(face: 1, xCor: 0, yCor: 0, content: .unselected), Cell(face: 1, xCor: 1, yCor: 0, content: .unselected), Cell(face: 1, xCor: 2, yCor: 0, content: .unselected), Cell(face: 1, xCor: 3, yCor: 0, content: .mine), Cell(face: 1, xCor: 4, yCor: 0, content: .unselected), Cell(face: 1, xCor: 5, yCor: 0, content: .unselected), Cell(face: 1, xCor: 6, yCor: 0, content: .unselected), Cell(face: 1, xCor: 7, yCor: 0, content: .mine), Cell(face: 1, xCor: 8, yCor: 0, content: .unselected), Cell(face: 1, xCor: 9, yCor: 0, content: .unselected)],
            [Cell(face: 1, xCor: 0, yCor: 1, content: .unselected), Cell(face: 1, xCor: 1, yCor: 1, content: .mine), Cell(face: 1, xCor: 2, yCor: 1, content: .unselected), Cell(face: 1, xCor: 3, yCor: 1, content: .mine), Cell(face: 1, xCor: 4, yCor: 1, content: .unselected), Cell(face: 1, xCor: 5, yCor: 1, content: .unselected), Cell(face: 1, xCor: 6, yCor: 1, content: .unselected), Cell(face: 1, xCor: 7, yCor: 1, content: .unselected), Cell(face: 1, xCor: 8, yCor: 1, content: .unselected), Cell(face: 1, xCor: 9, yCor: 1, content: .mine)],
            [Cell(face: 1, xCor: 0, yCor: 2, content: .unselected), Cell(face: 1, xCor: 1, yCor: 2, content: .unselected), Cell(face: 1, xCor: 2, yCor: 2, content: .unselected), Cell(face: 1, xCor: 3, yCor: 2, content: .mine), Cell(face: 1, xCor: 4, yCor: 2, content: .mine), Cell(face: 1, xCor: 5, yCor: 2, content: .unselected), Cell(face: 1, xCor: 6, yCor: 2, content: .unselected), Cell(face: 1, xCor: 7, yCor: 2, content: .unselected), Cell(face: 1, xCor: 8, yCor: 2, content: .unselected), Cell(face: 1, xCor: 9, yCor: 2, content: .unselected)],
            [Cell(face: 1, xCor: 0, yCor: 3, content: .mine), Cell(face: 1, xCor: 1, yCor: 3, content: .unselected), Cell(face: 1, xCor: 2, yCor: 3, content: .mine), Cell(face: 1, xCor: 3, yCor: 3, content: .unselected), Cell(face: 1, xCor: 4, yCor: 3, content: .unselected), Cell(face: 1, xCor: 5, yCor: 3, content: .unselected), Cell(face: 1, xCor: 6, yCor: 3, content: .unselected), Cell(face: 1, xCor: 7, yCor: 3, content: .unselected), Cell(face: 1, xCor: 8, yCor: 3, content: .unselected), Cell(face: 1, xCor: 9, yCor: 3, content: .mine)],
            [Cell(face: 1, xCor: 0, yCor: 4, content: .unselected), Cell(face: 1, xCor: 1, yCor: 4, content: .mine), Cell(face: 1, xCor: 2, yCor: 4, content: .unselected), Cell(face: 1, xCor: 3, yCor: 4, content: .unselected), Cell(face: 1, xCor: 4, yCor: 4, content: .unselected), Cell(face: 1, xCor: 5, yCor: 4, content: .unselected), Cell(face: 1, xCor: 6, yCor: 4, content: .mine), Cell(face: 1, xCor: 7, yCor: 4, content: .unselected), Cell(face: 1, xCor: 8, yCor: 4, content: .unselected), Cell(face: 1, xCor: 9, yCor: 4, content: .unselected)],
            [Cell(face: 1, xCor: 0, yCor: 5, content: .unselected), Cell(face: 1, xCor: 1, yCor: 5, content: .unselected), Cell(face: 1, xCor: 2, yCor: 5, content: .unselected), Cell(face: 1, xCor: 3, yCor: 5, content: .unselected), Cell(face: 1, xCor: 4, yCor: 5, content: .mine), Cell(face: 1, xCor: 5, yCor: 5, content: .unselected), Cell(face: 1, xCor: 6, yCor: 5, content: .unselected), Cell(face: 1, xCor: 7, yCor: 5, content: .unselected), Cell(face: 1, xCor: 8, yCor: 5, content: .mine), Cell(face: 1, xCor: 9, yCor: 5, content: .unselected)],
            [Cell(face: 1, xCor: 0, yCor: 6, content: .unselected), Cell(face: 1, xCor: 1, yCor: 6, content: .unselected), Cell(face: 1, xCor: 2, yCor: 6, content: .unselected), Cell(face: 1, xCor: 3, yCor: 6, content: .unselected), Cell(face: 1, xCor: 4, yCor: 6, content: .unselected), Cell(face: 1, xCor: 5, yCor: 6, content: .mine), Cell(face: 1, xCor: 6, yCor: 6, content: .unselected), Cell(face: 1, xCor: 7, yCor: 6, content: .unselected), Cell(face: 1, xCor: 8, yCor: 6, content: .unselected), Cell(face: 1, xCor: 9, yCor: 6, content: .unselected)],
            [Cell(face: 1, xCor: 0, yCor: 7, content: .unselected), Cell(face: 1, xCor: 1, yCor: 7, content: .unselected), Cell(face: 1, xCor: 2, yCor: 7, content: .unselected), Cell(face: 1, xCor: 3, yCor: 7, content: .unselected), Cell(face: 1, xCor: 4, yCor: 7, content: .unselected), Cell(face: 1, xCor: 5, yCor: 7, content: .mine), Cell(face: 1, xCor: 6, yCor: 7, content: .unselected), Cell(face: 1, xCor: 7, yCor: 7, content: .unselected), Cell(face: 1, xCor: 8, yCor: 7, content: .unselected), Cell(face: 1, xCor: 9, yCor: 7, content: .unselected)],
            [Cell(face: 1, xCor: 0, yCor: 8, content: .unselected), Cell(face: 1, xCor: 1, yCor: 8, content: .unselected), Cell(face: 1, xCor: 2, yCor: 8, content: .unselected), Cell(face: 1, xCor: 3, yCor: 8, content: .mine), Cell(face: 1, xCor: 4, yCor: 8, content: .unselected), Cell(face: 1, xCor: 5, yCor: 8, content: .unselected), Cell(face: 1, xCor: 6, yCor: 8, content: .unselected), Cell(face: 1, xCor: 7, yCor: 8, content: .unselected), Cell(face: 1, xCor: 8, yCor: 8, content: .unselected), Cell(face: 1, xCor: 9, yCor: 8, content: .unselected)],
            [Cell(face: 1, xCor: 0, yCor: 9, content: .unselected), Cell(face: 1, xCor: 1, yCor: 9, content: .unselected), Cell(face: 1, xCor: 2, yCor: 9, content: .unselected), Cell(face: 1, xCor: 3, yCor: 9, content: .mine), Cell(face: 1, xCor: 4, yCor: 9, content: .unselected), Cell(face: 1, xCor: 5, yCor: 9, content: .unselected), Cell(face: 1, xCor: 6, yCor: 9, content: .unselected), Cell(face: 1, xCor: 7, yCor: 9, content: .mine), Cell(face: 1, xCor: 8, yCor: 9, content: .mine), Cell(face: 1, xCor: 9, yCor: 9, content: .unselected)]
        ]
        
        for line in cells { for cell in line { cell.canBeEdited = false } }
        
        return Board(cells)
    }
}
