//
//  GameBoardVM.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import SwiftUI

class GameBoardVM: ObservableObject {
    
    @Published var visibleFace: Face!
    @Published var actionBarButton: Image = Images.system(.pause).image
    @Published var stringTime: String = Utils.getStringTime(seconds: 0)
    
    var gameStatus: GameStatus = .paused
    var sideFaces: BoardT_4 {
        let firstIndex = 1
        let lastIndex = Constants.numberOfItems - 2
        
        guard let topRow = self.faces.first(where: { $0.number == self.visibleFace.references.top }),
              let topCells = topRow.cells.horizontal(at: lastIndex),
              let bottomRow = self.faces.first(where: { $0.number == self.visibleFace.references.bottom }),
              let bottomCells = bottomRow.cells.horizontal(at: firstIndex),
              let leftColumn = self.faces.first(where: { $0.number == self.visibleFace.references.left }),
              let leftCells = leftColumn.cells.vertical(at: lastIndex),
              let rightColumn = self.faces.first(where: { $0.number == self.visibleFace.references.right }),
              let rightCells = rightColumn.cells.vertical(at: firstIndex)
        else { return BoardT_4.empty }
        
        let tuple = BoardT_4(topCells, bottomCells, leftCells, rightCells)
        
        return tuple.ok ? tuple : BoardT_4.empty
    }
    
    private var gameTime: Int = 0
    private var faces = [Face]()
    
    init(calculate: Bool) {
        if calculate { self.newGame() }
    }
    
    // MARK: Game functions
    // ====================
    func rotate(_ direction: Direction) {
        guard self.gameStatus == .running else { return }
        
        if let linkedFace = self.faces.first(where: { $0.number == self.getReference(for: direction) }) {
            let aux = linkedFace
            aux.updateLastReferences()
            aux.updateNewReferences(from: self.visibleFace, to: direction)
            let rotated = aux.rotated
            rotated.cells.resetCoords()
            
            self.visibleFace = rotated
        }
    }
    
    func updateCellVisibility(cell: Cell) {
        guard self.gameStatus == .running,
              let aux = self.visibleFace
        else { return }
        
        let cellAtPosition = aux.cells.b[cell.yCor][cell.xCor]
        
        if cellAtPosition.shown { return }
        else {
            if cellAtPosition.content == .void {
                // TODO: Create recursion
            }
            
            aux.cells.b[cell.yCor][cell.xCor].shown = true
            self.visibleFace = aux
        }
    }
    
    func getReference(for direction: Direction) -> Int {
        switch direction {
        case .up: return self.visibleFace.references.top
        case .down: return self.visibleFace.references.bottom
        case .left: return self.visibleFace.references.left
        case .right: return self.visibleFace.references.right
        }
    }
    
    func updateTime() {
        if self.gameStatus == .running {
            self.gameTime += 1
            self.stringTime = Utils.getStringTime(seconds: self.gameTime)
        }
    }
    
    // MARK: TabBar Items Actions
    // ==========================
    func pauseResumeButtonTapped() {
        switch self.gameStatus {
        case .running: self.gameStatus = .paused
        case .paused: self.gameStatus = .running
        default: break
        }
        
        self.updateImage()
    }
    
    func restartGame() {
        self.gameTime = 0
        self.faces.forEach { $0.cells.hideAllCells() }
        self.gameStatus = .running
        self.updateImage()
    }
    
    func newGame() {
        // TODO: Create and show loader for new games
        self.generateFaceNumbers()
    }
    
    // MARK: Board Functions
    // =====================
    private func generateFaceNumbers() {
        let face1 = Face(number: 1, references: References(top: 5, bottom: 2, left: 3, right: 4))
        let face2 = Face(number: 2, references: References(top: 1, bottom: 6, left: 3, right: 4))
        let face3 = Face(number: 3, references: References(top: 5, bottom: 2, left: 6, right: 1))
        let face4 = Face(number: 4, references: References(top: 5, bottom: 2, left: 1, right: 6))
        let face5 = Face(number: 5, references: References(top: 6, bottom: 1, left: 3, right: 4))
        let face6 = Face(number: 6, references: References(top: 2, bottom: 5, left: 3, right: 4))
        
        #if DEBUG
        face1.cells = Updater().debug_face1MineGeneration()
        face1.generated = true
        #endif
       
        Updater().updateFaces(
            faces: FaceT_6(face1, face2, face3, face4, face5, face6)
        ) { minedFaces in
            Hinter().calculateHints(faces: minedFaces) { hintedFaces in
                hintedFaces.i.forEach { $0.cells.disableEditing() }
                
                self.faces = hintedFaces.i
                self.visibleFace = self.faces.first(where: { $0.number == 1 })!
                self.gameStatus = .running
                self.updateImage()
            }
        }
    }
    
    private func updateImage() {
        switch self.gameStatus {
        case .running: self.actionBarButton = Images.system(.pause).image
        case .paused: self.actionBarButton = Images.system(.play).image
        case .won, .lost: self.actionBarButton = Images.system(.restart).image
        }
    }
}
