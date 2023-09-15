//
//  GameBoardVM.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import SwiftUI

//class GameBoardVM: ObservableObject {
//    
//    @Published var visibleFace: Face!
//    @Published var actionBarButton: Image = MSImages.system(.pause).image
//    @Published var stringTime: String = Utils.getStringTime(seconds: 0)
//    @Published var gameStatus: GameStatus = .generating
//    var sideFaces: BoardT_4? { return self.faces >> (self.visibleFace.references, false) }
//    var settings: MSSettings!
//    private var gameTime: Int = 0
//    private var faces = [Face]()
//    
//    init(calculate: Bool) {
//        self.settings = CoreDataController.shared.getSettingModel(iteration: 1)
//        if calculate { self.newGame() }
//    }
//    
//    init(with game: Game?) {
//        guard let game = game else { return }
//        
//        self.visibleFace = Face(faceCD: game.visibleFace)
//        self.gameStatus = game.status
//        self.faces = game.faces.map { return Face(faceCD: $0) }
//        self.gameTime = game.time
//        self.settings = CoreDataController.shared.getSettingModel(iteration: 1)
//        
//        self.updateTime()
//    }
//    
//    // MARK: Game functions
//    // ====================
//    func rotate(_ direction: Direction) {
//        guard self.gameStatus == .running || self.gameStatus == .lost || self.gameStatus == .won else { return }
//        
//        if let linkedFace = self.faces.first(where: { $0.number == self.getReference(for: direction) }) {
//            let aux = linkedFace
//            aux.updateNewReferences(from: self.visibleFace, to: direction)
//            let rotated = aux.rotated
//            rotated.cells.resetCoords()
//            
//            self.visibleFace = rotated
//            
//            if let visibleSides = self.faces >> (self.visibleFace.references, true) {
//                self.visibleFace.updateVisibleSides(with: visibleSides)
//            }
//            
//            self.checkWon()
//        }
//    }
//    
//    func update(cell: Cell, with action: Action, loseCallback: @escaping (() -> Void)) {
//        guard self.gameStatus == .running, let aux = self.visibleFace, cell.tappable else { return }
//        
//        let x = cell.xCor, y = cell.yCor
//        
//        aux.cells.b[y][x].update(with: action) { (updatedCell, status) in
//            switch status {
//            case .running: aux.cells.b[y][x] = updatedCell
//            case .recurssive: aux.recursiveDisplay(from: aux.cells.b[y][x]) { aux.cells.b[$0.yCor][$0.xCor] = $0 }
//            case .lost:
//                self.gameStatus = .lost
//                loseCallback()
//            default: break
//            }
//            
//            self.checkWon()
//        }
//    }
//    
//    func getReference(for direction: Direction) -> Int {
//        switch direction {
//        case .up: return self.visibleFace.references.top
//        case .down: return self.visibleFace.references.bottom
//        case .left: return self.visibleFace.references.left
//        case .right: return self.visibleFace.references.right
//        }
//    }
//    
//    func updateTime() {
//        if self.gameStatus == .running {
//            self.gameTime += 1
//            self.stringTime = Utils.getStringTime(seconds: self.gameTime)
//        }
//    }
//    
//    // MARK: TabBar Items Actions
//    // ==========================
//    func pauseResumeButtonTapped() {
//        switch self.gameStatus {
//        case .running: self.gameStatus = .paused
//        case .paused: self.gameStatus = .running
//        default: break
//        }
//        
//        self.updateImage()
//    }
//    
//    func restartGame() {
//        self.gameTime = 0
//        self.faces.forEach { $0.cells.hideAllCells() }
//        self.gameStatus = .running
//        self.updateImage()
//    }
//    
//    func newGame() {
//        self.generateFaceNumbers()
//    }
//    
//    func saveGame(completion: @escaping ((Error?) -> Void)) {
//        let coreDataGame = Game(
//            faces: self.faces, visibleFace: self.visibleFace, time: self.gameTime, status: self.gameStatus
//        )
//        CoreDataController.shared.save(game: coreDataGame, completion: completion)
//    }
//    
//    func saveRank(with userName: String, completion: @escaping ((Error?) -> Void)) {
//        guard !userName.isEmpty else { return }
//        
//        let rank = Rank(name: userName, date: Date(), score: self.calculateGameScore())
//        CoreDataController.shared.save(rank: rank, completion: completion)
//    }
//    
//    // MARK: Board Functions
//    // =====================
//    private func generateFaceNumbers() {
//        let face1 = Face(number: 1, references: References(1, top: 5, bottom: 2, left: 3, right: 4))
//        let face2 = Face(number: 2, references: References(2, top: 1, bottom: 6, left: 3, right: 4))
//        let face3 = Face(number: 3, references: References(3, top: 5, bottom: 2, left: 6, right: 1))
//        let face4 = Face(number: 4, references: References(4, top: 5, bottom: 2, left: 1, right: 6))
//        let face5 = Face(number: 5, references: References(5, top: 6, bottom: 1, left: 3, right: 4))
//        let face6 = Face(number: 6, references: References(6, top: 2, bottom: 5, left: 3, right: 4))
//        
//        Updater().updateFaces(
//            faces: FaceT_6(face1, face2, face3, face4, face5, face6)
//        ) { minedFaces in
//            Hinter().calculateHints(faces: minedFaces) { hintedFaces in
//                hintedFaces.i.forEach { $0.cells.disableEditing() }
//                
//                self.faces = hintedFaces.i
//                self.visibleFace = self.faces.first(where: { $0.number == 1 })!
//                self.gameStatus = .running
//                self.updateImage()
//            }
//        }
//    }
//    
//    private func updateImage() {
//        switch self.gameStatus {
//        case .running: self.actionBarButton = Images.system(.pause).image
//        case .paused: self.actionBarButton = Images.system(.play).image
//        case .won, .lost: self.actionBarButton = Images.system(.restart).image
//        case .generating: self.actionBarButton = Images.system(.timer).image
//        case .recurssive: self.actionBarButton = Images.system(.clock).image
//        }
//    }
//    
//    private func checkWon() {
//        let totalCells = (Constants.numberOfItems ^ 2) * self.faces.count
//        let visibleCells = self.faces
//            .map {
//                $0.cells.b
//                    .map { $0.filter { $0.shown || $0.mined } }
//                    .flatMap { return $0 }
//                    .count
//            }
//            .reduce(0, +)
//        
//        if totalCells == visibleCells { self.gameStatus = .won }
//    }
//    
//    private func calculateGameScore() -> Int {
//        var score: Double = 0
//        
//        self.faces.forEach { face in
//            let visibleCells = face.cells.b
//                .map { $0.filter { $0.shown || $0.flagged || $0.mined } }
//                .flatMap { return $0 }
//            let items = Double(Constants.numberOfItems ^ 2)
//            let count = Double(visibleCells.count)
//            let fraction = count / items
//            let multiplyer: Double = 1 + (count == items ? 1 : fraction)
//            var faceScore: Double = 0
//            
//            visibleCells.forEach { cell in
//                switch cell.content {
//                case .mine: if cell.isMine { faceScore += 10 }
//                case .number(let number): faceScore += Double(number)
//                case .flagged: if cell.isMine { faceScore += 5 }
//                case .unselected: break
//                case .void: faceScore += 1
//                }
//            }
//            
//            faceScore *= multiplyer
//            score += faceScore
//        }
//        
//        if self.gameStatus == .won { score += 1500 }
//        
//        return Int(score)
//    }
//    
//    // MARK: DEBUG functions
//    // =====================
//    func printCurrentFace() {
//        guard let face = self.visibleFace else { return }
//        let cells = face.cells.b
//        
//        print("-----------[FACE \(face.number)]-----------")
//        cells.forEach { row in
//            var rowString = ""
//            row.forEach { cell in rowString.append("[\(cell.content.settingKey)]") }
//            rowString.append("\n")
//            print(rowString)
//        }
//        print("------------------------------")
//    }
//}
