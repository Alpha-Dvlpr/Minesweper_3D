//
//  FaceUpdater.swift
//  Minesweeper 3D
//
//  Created by Aaron on 12/7/21.
//

import Foundation

class Updater {

    private let miner: Miner
    private let hinter: Hinter
    
    init() {
        self.miner = Miner()
        self.hinter = Hinter(referencer: Referencer())
    }
    
    // MARK: Board updation functions
    // ==============================
    func updateFaces(faces: FaceT_6, completion: @escaping ((FaceT_6) -> Void)) {
        self.updateFace1(face1: faces.t.0) { f1c in
            faces.t.0.cells = f1c
            self.updateFace2(face1: faces.t.0, face2: faces.t.1) { f2c in
                faces.t.1.cells = f2c
                self.updateFace3(
                    input: FaceT_2(faces.t.0, faces.t.1),
                    face3: faces.t.2
                ) { f3c in
                    faces.t.2.cells = f3c
                    self.updateFace4(
                        input: FaceT_2(faces.t.0, faces.t.1),
                        face4: faces.t.3
                    ) { f4c in
                        faces.t.3.cells = f4c
                        self.updateFace5(
                            input: FaceT_3(faces.t.0, faces.t.2, faces.t.3),
                            face5: faces.t.4
                        ) { f5c in
                            faces.t.4.cells = f5c
                            self.updateFace6(
                                input: FaceT_4(faces.t.1, faces.t.2, faces.t.3, faces.t.4),
                                face6: faces.t.5
                            ) { f6c in
                                faces.t.5.cells = f6c
                                
                                self.hinter.calculateHints(faces: faces) { completion($0) }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func updateFace1(face1: Face, completion: @escaping ((Board) -> Void)) {
        self.miner.placeMines(on: (face1.cells)) { completion($0) }
    }
    
    private func updateFace2(face1: Face, face2: Face, completion: @escaping ((Board) -> Void)) {
        guard let face1LasLine = face1.cells.b.last,
              face1LasLine.count == Constants.numberOfItems
        else { completion(face2.cells); return }
        
        face2.cells.b[0] = face1LasLine.map { return ($0 << ($0.xCor, 0)) << 2 }
        
        self.miner.placeMines(on: face2.cells) { completion($0) }
    }
    
    private func updateFace3(input: FaceT_2, face3: Face, completion: @escaping ((Board) -> Void)) {
        let face1FirstColumn = input.t.0.cells.b.map { $0.first }.compactMap { $0 }
        let face2FirstColumn = input.t.1.cells.b.map { $0.first }.compactMap { $0 }
        let lastIndex = Constants.numberOfItems - 1
        
        guard face1FirstColumn.count == Constants.numberOfItems,
              face2FirstColumn.count == Constants.numberOfItems
        else { completion(face3.cells); return }
        
        let face1Converted = face1FirstColumn.map { return ($0 << (9, $0.yCor)) << 3 }
        (0...lastIndex).forEach { face3.cells.b[$0][lastIndex] = face1Converted[$0] }
        
        let face2Converted = (0...lastIndex).map { index -> Cell in
            let opposite = Int.opposite(of: index, max: lastIndex)
            return (face2FirstColumn[index] << (opposite, 9)) << 3
        }
        
        face3.cells.b[lastIndex] = face2Converted.reversed()
        
        self.miner.placeMines(on: face3.cells) { completion($0) }
    }
    
    private func updateFace4(input: FaceT_2, face4: Face, completion: @escaping ((Board) -> Void)) {
        let face1LastColumn = input.t.0.cells.b.map { $0.last }.compactMap { $0 }
        let face2LastColumn = input.t.1.cells.b.map { $0.last }.compactMap { $0 }
        let lastIndex = Constants.numberOfItems - 1
        
        guard face1LastColumn.count == Constants.numberOfItems,
              face2LastColumn.count == Constants.numberOfItems
        else { completion(face4.cells); return }
        
        let face1Converted = face1LastColumn.map { return ($0 << (0, $0.yCor)) << 4 }
        (0...lastIndex).forEach { face4.cells.b[$0][0] = face1Converted[$0] }
        
        let face2Converted = face2LastColumn.map { return ($0 << ($0.yCor, $0.xCor)) << 4 }
        face4.cells.b[lastIndex] = face2Converted
        
        self.miner.placeMines(on: face4.cells) { completion($0) }
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
        
        face5.cells.b[lastIndex] = face1FirstLine.map { return ($0 << ($0.xCor, 9)) << 5 }
        
        (0...lastIndex).forEach { face5.cells.b[$0][0] = (face3FirstLine[$0] << (0, $0)) << 5 }
        
        let face4Converted = (0...lastIndex).map { index -> Cell in
            let opposite = Int.opposite(of: index, max: lastIndex)
            return (face4FirstLine[index] << (9, opposite)) << 5
        }
        
        (0...lastIndex).forEach { face5.cells.b[$0][lastIndex] = face4Converted.reversed()[$0] }
        
        self.miner.placeMines(on: face5.cells) { completion($0) }
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
        
        face6.cells.b[0] = face2LastLine.map { return ($0 << ($0.xCor, 0)) << 6 }
        
        let face3Converted = (0...lastIndex).map { index -> Cell in
            let opposite = Int.opposite(of: index, max: lastIndex)
            let cell = face3FirstColumn[index]
            return (cell << (cell.xCor, opposite)) << 6
        }
        
        (0...lastIndex).forEach { face6.cells.b[$0][0] = face3Converted.reversed()[$0] }
        
        let face4Converted = (0...lastIndex).map { index -> Cell in
            let opposite = Int.opposite(of: index, max: lastIndex)
            let cell = face4LastColumn[index]
            return (cell << (cell.xCor, opposite)) << 6
        }
        
        (0...lastIndex).forEach { face6.cells.b[$0][lastIndex] = face4Converted.reversed()[$0] }
        
        face6.cells.b[lastIndex] = face5FirstLine.map { return ($0 << ($0.xCor, 9)) << 6 }
        
        self.miner.placeMines(on: face6.cells) { completion($0) }
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
