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
    var gameStatus: GameStatus = .generating
    var sideFaces: BoardT_4? { return self.faces >> (self.visibleFace.references, false) }
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
            aux.updateNewReferences(from: self.visibleFace, to: direction)
            let rotated = aux.rotated
            rotated.cells.resetCoords()
            
            self.visibleFace = rotated
            
            if let visibleSides = self.faces >> (self.visibleFace.references, true) {
                self.visibleFace.updateVisibleSides(with: visibleSides)
            }
        }
    }
    
    func update(cell: Cell, with action: Action, loseCallback: @escaping (() -> Void)) {
        guard self.gameStatus == .running, let aux = self.visibleFace, cell.tappable else { return }
        
        let x = cell.xCor, y = cell.yCor
        
        aux.cells.b[y][x].update(with: action) { (updatedCell, status) in
            switch status {
            case .running:
                aux.cells.b[y][x] = updatedCell
            case .recurssive:
                aux.cells.recursiveDisplay(from: aux.cells.b[y][x]) { _ in
                    self.visibleFace = aux
                }
            case .lost:
                self.gameStatus = .lost
                loseCallback()
            default: break
            }
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
    
    func saveGame(completion: @escaping ((Bool) -> Void)) {
        completion(true)
        // TODO: Save current game stuff then dismiss
    }
    
    // MARK: Board Functions
    // =====================
    private func generateFaceNumbers() {
        let face1 = Face(number: 1, references: References(1, top: 5, bottom: 2, left: 3, right: 4))
        let face2 = Face(number: 2, references: References(2, top: 1, bottom: 6, left: 3, right: 4))
        let face3 = Face(number: 3, references: References(3, top: 5, bottom: 2, left: 6, right: 1))
        let face4 = Face(number: 4, references: References(4, top: 5, bottom: 2, left: 1, right: 6))
        let face5 = Face(number: 5, references: References(5, top: 6, bottom: 1, left: 3, right: 4))
        let face6 = Face(number: 6, references: References(6, top: 2, bottom: 5, left: 3, right: 4))
        
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
        case .generating: self.actionBarButton = Images.system(.timer).image
        case .recurssive: self.actionBarButton = Images.system(.clock).image
        }
    }
    
    // MARK: DEBUG functions
    // =====================
    func printCurrentFace() {
        guard let face = self.visibleFace else { return }
        let cells = face.cells.b
        
        print("-----------[FACE \(face.number)]-----------")
        cells.forEach { row in
            var rowString = ""
            row.forEach { cell in rowString.append("[\(cell.content.debug)]") }
            rowString.append("\n")
            print(rowString)
        }
        print("------------------------------")
    }
}
