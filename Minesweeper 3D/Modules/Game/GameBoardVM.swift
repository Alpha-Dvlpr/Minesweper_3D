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
    
    var gameStatus: GameStatus = .running
    
    private var gameTime: Int = 0
    private var faces = [Face]()
    
    init() {
        self.newGame()
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
        
        aux.cells[y][x].shown.toggle()
        
        self.visibleFace = aux
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
        
    }
    
    func newGame() {
        self.generateFaceNumbers()
    }
    
    // MARK: Private Functions
    // =======================
    private func generateFaceNumbers() {
        let face1 = Face(number: 1)
        face1.references.top = 5
        face1.references.bottom = 2
        face1.references.left = 3
        face1.references.right = 4
        
        let face2 = Face(number: 2)
        let face3 = Face(number: 3)
        let face4 = Face(number: 4)
        let face5 = Face(number: 5)
        let face6 = Face(number: 6)
        
        self.faces = [face1, face2, face3, face4, face5, face6]
        
        self.visibleFace = face1
    }
    
    private func updateImage() {
        switch self.gameStatus {
        case .running: self.actionBarButton = Images.system(.pause).image
        case .paused: self.actionBarButton = Images.system(.play).image
        case .won, .lost: self.actionBarButton = Images.system(.restart).image
        }
    }
}
