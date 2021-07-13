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
            
            self.visibleFace = aux.rotated
        }
    }
    
    func updateCellVisibility(x: Int, y: Int) {
        guard self.gameStatus == .running,
              let aux = self.visibleFace
        else { return }
    
        if aux.cells.b[y][x].shown { return }
        else {
            if aux.cells.b[y][x].content == .void {
                // TODO: Create recursion
            }
            
            aux.cells.b[y][x].shown = true
            
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
        self.faces.forEach { $0.hideAllCells() }
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
        let updater = Updater()
        let face1 = Face(number: 1, references: References(top: 5, bottom: 2, left: 3, right: 4))
        let face2 = Face(number: 2, references: References(top: 1, bottom: 6, left: 3, right: 4))
        let face3 = Face(number: 3, references: References(top: 5, bottom: 2, left: 6, right: 1))
        let face4 = Face(number: 4, references: References(top: 5, bottom: 2, left: 1, right: 6))
        let face5 = Face(number: 5, references: References(top: 6, bottom: 1, left: 3, right: 4))
        let face6 = Face(number: 6, references: References(top: 2, bottom: 5, left: 3, right: 4))
        
        #if DEBUG
        face1.cells = updater.debug_face1MineGeneration()
        face1.generated = true
        #endif
       
        updater.updateFaces(
            faces: FaceT_6(face1, face2, face3, face4, face5, face6)
        ) { newFaces in
            face1.cells = newFaces.t.0.cells
            face2.cells = newFaces.t.1.cells
            face3.cells = newFaces.t.2.cells
            face4.cells = newFaces.t.3.cells
            face5.cells = newFaces.t.4.cells
            face6.cells = newFaces.t.5.cells
         
            self.faces = [face1, face2, face3, face4, face5, face6]
            self.visibleFace = face1
            self.gameStatus = .running
            self.updateImage()
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
