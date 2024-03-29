//
//  FaceUpdater.swift
//  Minesweeper 3D
//
//  Created by Aaron on 12/7/21.
//

import Foundation

class Updater {

    private let miner = Miner()
    private let lastIndex = Constants.numberOfItems - 1
    
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
                                completion(faces)
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
        guard let face1LastLine = face1.cells.b.horizontal(at: self.lastIndex) else { completion(face2.cells); return }
        
        face2.cells.b[0] = face1LastLine.map { return ($0 << ($0.xCor, 0)) << 2 }
        
        self.miner.placeMines(on: face2.cells) { completion($0) }
    }
    
    private func updateFace3(input: FaceT_2, face3: Face, completion: @escaping ((Board) -> Void)) {
        guard let face1FirstColumn = input.t.0.cells.b.vertical(at: 0),
              let face2FirstColumn = input.t.1.cells.b.vertical(at: 0)
        else { completion(face3.cells); return }
        
        let face1Converted = face1FirstColumn.map { return ($0 << (self.lastIndex, $0.yCor)) << 3 }
        (0...self.lastIndex).forEach { face3.cells.b[$0][lastIndex] = face1Converted[$0] }
        
        let face2Converted = (0...self.lastIndex).map { index -> Cell in
            let opposite = Int.opposite(of: index, max: self.lastIndex)
            return (face2FirstColumn[index] << (opposite, self.lastIndex)) << 3
        }
        
        face3.cells.b[self.lastIndex] = face2Converted.reversed()
        
        self.miner.placeMines(on: face3.cells) { completion($0) }
    }
    
    private func updateFace4(input: FaceT_2, face4: Face, completion: @escaping ((Board) -> Void)) {
        guard let face1LastColumn = input.t.0.cells.b.vertical(at: self.lastIndex),
              let face2LastColumn = input.t.1.cells.b.vertical(at: self.lastIndex)
        else { completion(face4.cells); return }
        
        let face1Converted = face1LastColumn.map { return ($0 << (0, $0.yCor)) << 4 }
        (0...self.lastIndex).forEach { face4.cells.b[$0][0] = face1Converted[$0] }
        
        face4.cells.b[self.lastIndex] = face2LastColumn.map { return ($0 << ($0.yCor, $0.xCor)) << 4 }
        
        self.miner.placeMines(on: face4.cells) { completion($0) }
    }
    
    private func updateFace5(input: FaceT_3, face5: Face, completion: @escaping ((Board) -> Void)) {
        guard let face1FirstLine = input.t.0.cells.b.horizontal(at: 0),
              let face3FirstLine = input.t.1.cells.b.horizontal(at: 0),
              let face4FirstLine = input.t.2.cells.b.horizontal(at: 0)
        else { completion(face5.cells); return }
        
        face5.cells.b[self.lastIndex] = face1FirstLine.map { return ($0 << ($0.xCor, self.lastIndex)) << 5 }
        
        (0...self.lastIndex).forEach { face5.cells.b[$0][0] = (face3FirstLine[$0] << (0, $0)) << 5 }
        
        let face4Converted = (0...self.lastIndex).map { index -> Cell in
            return (face4FirstLine[index] << (self.lastIndex, Int.opposite(of: index, max: self.lastIndex))) << 5
        }
        
        (0...self.lastIndex).forEach { face5.cells.b[$0][self.lastIndex] = face4Converted.reversed()[$0] }
        
        self.miner.placeMines(on: face5.cells) { completion($0) }
    }
    
    private func updateFace6(input: FaceT_4, face6: Face, completion: @escaping ((Board) -> Void)) {
        guard let face2LastLine = input.t.0.cells.b.horizontal(at: self.lastIndex),
              let face3FirstColumn = input.t.1.cells.b.vertical(at: 0),
              let face4LastColumn = input.t.2.cells.b.vertical(at: self.lastIndex),
              let face5FirstLine = input.t.3.cells.b.horizontal(at: 0)
        else { completion(face6.cells); return }
        
        face6.cells.b[0] = face2LastLine.map { return ($0 << ($0.xCor, 0)) << 6 }
        
        let face3Converted = (0...self.lastIndex).map { index -> Cell in
            let cell = face3FirstColumn[index]
            return (cell << (cell.xCor, Int.opposite(of: index, max: self.lastIndex))) << 6
        }
        
        (0...self.lastIndex).forEach { face6.cells.b[$0][0] = face3Converted.reversed()[$0] }
        
        let face4Converted = (0...self.lastIndex).map { index -> Cell in
            let cell = face4LastColumn[index]
            return (cell << (cell.xCor, Int.opposite(of: index, max: self.lastIndex))) << 6
        }
        
        (0...self.lastIndex).forEach { face6.cells.b[$0][self.lastIndex] = face4Converted.reversed()[$0] }
        
        face6.cells.b[self.lastIndex] = face5FirstLine.map { return ($0 << ($0.xCor, self.lastIndex)) << 6 }
        
        self.miner.placeMines(on: face6.cells) { completion($0) }
    }
}
