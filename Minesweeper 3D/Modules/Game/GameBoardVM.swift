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
    
        if aux.cells[y][x].shown { return }
        else {
            if aux.cells[y][x].content == .void {
                // TODO: Create recursion
            }
            
            aux.cells[y][x].shown = true
            
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
        let dispatchGroup = DispatchGroup()
        
        let face1 = Face(number: 1, references: References(top: 5, bottom: 2, left: 3, right: 4))
        let face2 = Face(number: 2, references: References(top: 1, bottom: 6, left: 3, right: 4))
        let face3 = Face(number: 3, references: References(top: 5, bottom: 2, left: 6, right: 1))
        let face4 = Face(number: 4, references: References(top: 5, bottom: 2, left: 1, right: 6))
        let face5 = Face(number: 5, references: References(top: 6, bottom: 1, left: 3, right: 4))
        let face6 = Face(number: 6, references: References(top: 2, bottom: 5, left: 3, right: 4))
        
        #if DEBUG
        face1.cells = self.debug_face1MineGeneration()
        face1.generated = true
        #endif
        
        // Face1: no other face generated, place randomly
        dispatchGroup.enter()
        self.placeMines(on: face1.cells) {
            face1.cells = $0
            dispatchGroup.leave()
        }
        
        // Face2: face1 generated.
        // Update face2's top line with face1's bottom line (update id).
        // Place mines.
        dispatchGroup.enter()
        
        // Face3: face1 & face2 generated.
        // Update face3's bottom line with face2's left column (update id).
        // Update face3's right column with face1's left column (update id).
        // Place mines.
        
        // Face4: face1 & face2 geenrated.
        // Update face4's bottom line with face2's right column (update id).
        // Update face4's left column with face1's right column (update id).
        // Place mines.
        
        // Face5: face1, face3 & face4 generated.
        // Update face5's bottom line with face1's top line (update id).
        // Update face5's left column with face3's top line (update id).
        // Update face5's right column with face4's top line (update id).
        // Place mines.
                        
        // Face6: face2, face3, face4 & face5 generated.
        // Update face6's top line with face2's bottom line (update id).
        // Update face6's bottom line with face5's top line (update id).
        // Update face6's left column with face3's left column (update id).
        // Update face6's right column with face4's right column (update id).
        // Place mines.
               
        dispatchGroup.notify(queue: .main) {
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
    
    // MARK: Mine generation functions
    // ===============================
    private func placeMines(on board: [[Cell]], completion: @escaping (([[Cell]]) -> Void)) {
        var generatedMines = board.map { $0.filter { $0.content == .mine }.count }.reduce(0, +)
        
        while generatedMines < Constants.numberOfMinesPerFace {
            let coords = self.generateRandomCoords()
            let cell = board[coords.0][coords.1]

            if cell.content == .mine || !cell.canBeEdited { continue }
            else {
                board[coords.0][coords.1].updateContent(to: .mine)
                generatedMines += 1
            }
        }

        completion(board)
    }

    private func generateRandomCoords() -> (Int, Int) {
        let number1 = Int(arc4random_uniform(UInt32(Constants.numberOfItems)))
        let number2 = Int(arc4random_uniform(UInt32(Constants.numberOfItems)))
        
        return (number1, number2)
    }
    
    // MARK: Board updation functions
    // ==============================
    
//    private func updateLines(
//        on board: [[Cell]],
//        from face: Face,
//        completion: @escaping (([[Cell]]) -> Void)
//    ) {
//        var auxBoard = board
//        let lastIndex = Constants.numberOfItems - 1
//        let lastReferenceLine = face.cells.last?.compactMap { $0 }.map { return $0 >> self.number } ?? []
//        let firstReferenceLine = face.cells.first?.compactMap { $0 }.map { return $0 >> self.number } ?? []
//        let lastReferenceColumn = face.cells.map { $0.last }.compactMap { $0 }.map { return $0 >> self.number }
//        let firstReferenceColumn = face.cells.map { $0.first }.compactMap { $0 }.map { return $0 >> self.number }
//
//        guard lastReferenceLine.count == Constants.numberOfItems,
//              firstReferenceLine.count == Constants.numberOfItems,
//              lastReferenceColumn.count == Constants.numberOfItems,
//              firstReferenceColumn.count == Constants.numberOfItems
//        else { completion(auxBoard); return }
//
//        func updateHorizontal(at index: Int, with cells: [Cell]) {
//            auxBoard[index] = cells
//        }
//
//        func updateVertical(at index: Int, with cells: [Cell]) {
//            (0..<lastIndex).forEach { auxBoard[$0][index] = cells[$0] }
//        }
//
//        func checkReferences(for number: Int, to index: Int) {
//            switch number {
//            default: break
//            }
//        }
//
//        switch face.number {
//        case self.references.top:
//            updateHorizontal(at: 0, with: lastReferenceLine)
//        case self.references.bottom:
//            updateHorizontal(at: lastIndex, with: firstReferenceLine)
//        case self.references.left:
//            updateVertical(at: 0, with: lastReferenceColumn)
//        case self.references.right:
//            updateVertical(at: lastIndex, with: firstReferenceColumn)
//        default: break
//        }
//
//        completion(auxBoard)
//    }

    // MARK: Mine hint calculation functions
    // =====================================
    private func generateMineHints(for cells: [[Cell]], completion: @escaping (([[Cell]]) -> Void)) {
        let aux = cells
        
        for row in aux {
            for cell in row {
                if cell.content == .mine { continue }
                
                var counter = 0
                
                switch cell.type {
                case .corner: break
                case .vBorder: break
                case .hBorder: break
                case .inner:
                    [
                        aux[cell.yCor][cell.xCor - 1],     // Nort Cell
                        aux[cell.yCor + 1][cell.xCor - 1], // North East Cell
                        aux[cell.yCor + 1][cell.xCor],     // East Cell
                        aux[cell.yCor + 1][cell.xCor + 1], // South East Cell
                        aux[cell.yCor][cell.xCor + 1],     // South Cell
                        aux[cell.yCor - 1][cell.xCor + 1], // South West Cell
                        aux[cell.yCor - 1][cell.xCor],     // West Cell
                        aux[cell.yCor - 1][cell.xCor - 1]  // North West Cell
                    ].forEach { if $0.content == .mine { counter += 1 } }
                }
                
                cell.updateContent(to: counter == 0 ? .void : .number(counter))
                cell.canBeEdited = false
            }
        }
        
        completion(aux)
    }
    
    // swiftlint:disable line_length
    #if DEBUG
    private func debug_face1MineGeneration() -> [[Cell]] {
        return [
            [Cell(face: 1, xCor: 0, yCor: 0, content: .unselected), Cell(face: 1, xCor: 1, yCor: 0, content: .unselected), Cell(face: 1, xCor: 2, yCor: 0, content: .unselected), Cell(face: 1, xCor: 3, yCor: 0, content: .mine), Cell(face: 1, xCor: 4, yCor: 0, content: .unselected), Cell(face: 1, xCor: 5, yCor: 0, content: .unselected), Cell(face: 1, xCor: 6, yCor: 0, content: .unselected), Cell(face: 1, xCor: 7, yCor: 0, content: .mine), Cell(face: 1, xCor: 8, yCor: 0, content: .unselected), Cell(face: 1, xCor: 9, yCor: 0, content: .unselected)],
            [Cell(face: 1, xCor: 0, yCor: 1, content: .unselected), Cell(face: 1, xCor: 1, yCor: 1, content: .mine), Cell(face: 1, xCor: 2, yCor: 1, content: .unselected), Cell(face: 1, xCor: 3, yCor: 1, content: .mine), Cell(face: 1, xCor: 4, yCor: 1, content: .unselected), Cell(face: 1, xCor: 5, yCor: 1, content: .unselected), Cell(face: 1, xCor: 6, yCor: 1, content: .unselected), Cell(face: 1, xCor: 7, yCor: 1, content: .mine), Cell(face: 1, xCor: 8, yCor: 1, content: .unselected), Cell(face: 1, xCor: 9, yCor: 1, content: .mine)],
            [Cell(face: 1, xCor: 0, yCor: 2, content: .unselected), Cell(face: 1, xCor: 1, yCor: 2, content: .unselected), Cell(face: 1, xCor: 2, yCor: 2, content: .unselected), Cell(face: 1, xCor: 3, yCor: 2, content: .mine), Cell(face: 1, xCor: 4, yCor: 2, content: .mine), Cell(face: 1, xCor: 5, yCor: 2, content: .unselected), Cell(face: 1, xCor: 6, yCor: 2, content: .unselected), Cell(face: 1, xCor: 7, yCor: 2, content: .unselected), Cell(face: 1, xCor: 8, yCor: 2, content: .unselected), Cell(face: 1, xCor: 9, yCor: 2, content: .unselected)],
            [Cell(face: 1, xCor: 0, yCor: 3, content: .unselected), Cell(face: 1, xCor: 1, yCor: 3, content: .unselected), Cell(face: 1, xCor: 2, yCor: 3, content: .mine), Cell(face: 1, xCor: 3, yCor: 3, content: .unselected), Cell(face: 1, xCor: 4, yCor: 3, content: .unselected), Cell(face: 1, xCor: 5, yCor: 3, content: .unselected), Cell(face: 1, xCor: 6, yCor: 3, content: .unselected), Cell(face: 1, xCor: 7, yCor: 3, content: .unselected), Cell(face: 1, xCor: 8, yCor: 3, content: .unselected), Cell(face: 1, xCor: 9, yCor: 3, content: .mine)],
            [Cell(face: 1, xCor: 0, yCor: 4, content: .unselected), Cell(face: 1, xCor: 1, yCor: 4, content: .mine), Cell(face: 1, xCor: 2, yCor: 4, content: .unselected), Cell(face: 1, xCor: 3, yCor: 4, content: .unselected), Cell(face: 1, xCor: 4, yCor: 4, content: .unselected), Cell(face: 1, xCor: 5, yCor: 4, content: .unselected), Cell(face: 1, xCor: 6, yCor: 4, content: .mine), Cell(face: 1, xCor: 7, yCor: 4, content: .unselected), Cell(face: 1, xCor: 8, yCor: 4, content: .unselected), Cell(face: 1, xCor: 9, yCor: 4, content: .unselected)],
            [Cell(face: 1, xCor: 0, yCor: 5, content: .unselected), Cell(face: 1, xCor: 1, yCor: 5, content: .unselected), Cell(face: 1, xCor: 2, yCor: 5, content: .unselected), Cell(face: 1, xCor: 3, yCor: 5, content: .unselected), Cell(face: 1, xCor: 4, yCor: 5, content: .mine), Cell(face: 1, xCor: 5, yCor: 5, content: .unselected), Cell(face: 1, xCor: 6, yCor: 5, content: .unselected), Cell(face: 1, xCor: 7, yCor: 5, content: .unselected), Cell(face: 1, xCor: 8, yCor: 5, content: .mine), Cell(face: 1, xCor: 9, yCor: 5, content: .unselected)],
            [Cell(face: 1, xCor: 0, yCor: 6, content: .unselected), Cell(face: 1, xCor: 1, yCor: 6, content: .unselected), Cell(face: 1, xCor: 2, yCor: 6, content: .unselected), Cell(face: 1, xCor: 3, yCor: 6, content: .mine), Cell(face: 1, xCor: 4, yCor: 6, content: .unselected), Cell(face: 1, xCor: 5, yCor: 6, content: .mine), Cell(face: 1, xCor: 6, yCor: 6, content: .unselected), Cell(face: 1, xCor: 7, yCor: 6, content: .unselected), Cell(face: 1, xCor: 8, yCor: 6, content: .unselected), Cell(face: 1, xCor: 9, yCor: 6, content: .unselected)],
            [Cell(face: 1, xCor: 0, yCor: 7, content: .unselected), Cell(face: 1, xCor: 1, yCor: 7, content: .unselected), Cell(face: 1, xCor: 2, yCor: 7, content: .unselected), Cell(face: 1, xCor: 3, yCor: 7, content: .unselected), Cell(face: 1, xCor: 4, yCor: 7, content: .unselected), Cell(face: 1, xCor: 5, yCor: 7, content: .mine), Cell(face: 1, xCor: 6, yCor: 7, content: .unselected), Cell(face: 1, xCor: 7, yCor: 7, content: .unselected), Cell(face: 1, xCor: 8, yCor: 7, content: .unselected), Cell(face: 1, xCor: 9, yCor: 7, content: .unselected)],
            [Cell(face: 1, xCor: 0, yCor: 8, content: .unselected), Cell(face: 1, xCor: 1, yCor: 8, content: .unselected), Cell(face: 1, xCor: 2, yCor: 8, content: .unselected), Cell(face: 1, xCor: 3, yCor: 8, content: .mine), Cell(face: 1, xCor: 4, yCor: 8, content: .unselected), Cell(face: 1, xCor: 5, yCor: 8, content: .unselected), Cell(face: 1, xCor: 6, yCor: 8, content: .unselected), Cell(face: 1, xCor: 7, yCor: 8, content: .unselected), Cell(face: 1, xCor: 8, yCor: 8, content: .unselected), Cell(face: 1, xCor: 9, yCor: 8, content: .unselected)],
            [Cell(face: 1, xCor: 0, yCor: 9, content: .unselected), Cell(face: 1, xCor: 1, yCor: 9, content: .unselected), Cell(face: 1, xCor: 2, yCor: 9, content: .unselected), Cell(face: 1, xCor: 3, yCor: 9, content: .mine), Cell(face: 1, xCor: 4, yCor: 9, content: .unselected), Cell(face: 1, xCor: 5, yCor: 9, content: .unselected), Cell(face: 1, xCor: 6, yCor: 9, content: .unselected), Cell(face: 1, xCor: 7, yCor: 9, content: .mine), Cell(face: 1, xCor: 8, yCor: 9, content: .unselected), Cell(face: 1, xCor: 9, yCor: 9, content: .unselected)]
        ]
    }
    #endif
}
