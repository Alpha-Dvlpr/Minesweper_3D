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
        
        func finishUpdate(on face: Face, with cells: [[Cell]]) {
            face.cells = cells
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        self.placeMines(on: face1.cells) { finishUpdate(on: face1, with: $0) }
        
        dispatchGroup.enter()
        self.updateFace2(face1: face1, face2: face2) { finishUpdate(on: face2, with: $0) }
        
        dispatchGroup.enter()
        self.updateFace3(input: (face1, face2), face3: face3) { finishUpdate(on: face3, with: $0) }
        
        dispatchGroup.enter()
        self.updateFace4(input: (face1, face2), face4: face4) { finishUpdate(on: face4, with: $0) }
        
        dispatchGroup.enter()
        self.updateFace5(input: (face1, face3, face4), face5: face5) { finishUpdate(on: face5, with: $0) }
                   
        dispatchGroup.enter()
        self.updateFace6(input: (face2, face3, face4, face5), face6: face6) { finishUpdate(on: face6, with: $0) }
        
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
            
            cell.canBeEdited = false
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
    private func updateFace2(face1: Face, face2: Face, completion: @escaping (([[Cell]]) -> Void)) {
        guard let face1LasLine = face1.cells.last,
              face1LasLine.count == Constants.numberOfItems
        else { completion(face2.cells); return }
        
        face2.cells[0] = face1LasLine.map { return $0 >> 2 }
        
        self.placeMines(on: face2.cells) { completion($0) }
    }
    
    private func updateFace3(input: (Face, Face), face3: Face, completion: @escaping (([[Cell]]) -> Void)) {
        let face1FirstColumn = input.0.cells.map { $0.first }.compactMap { $0 }
        let face2FirstColumn = input.1.cells.map { $0.first }.compactMap { $0 }
        let lastIndex = Constants.numberOfItems - 1
        
        guard face1FirstColumn.count == Constants.numberOfItems,
              face2FirstColumn.count == Constants.numberOfItems
        else { completion(face3.cells); return }
        
        let face1Converted = face1FirstColumn.map { return $0 >> 3 }
        (0..<lastIndex).forEach { face3.cells[$0][lastIndex] = face1Converted[$0] }
        
        face3.cells[lastIndex] = face2FirstColumn.map { return $0 >> 3 }.reversed()
        
        self.placeMines(on: face3.cells) { completion($0) }
    }
    
    private func updateFace4(input: (Face, Face), face4: Face, completion: @escaping (([[Cell]]) -> Void)) {
        let face1LastColumn = input.0.cells.map { $0.last }.compactMap { $0 }
        let face2LastColumn = input.1.cells.map { $0.last }.compactMap { $0 }
        let lastIndex = Constants.numberOfItems - 1
        
        guard face1LastColumn.count == Constants.numberOfItems,
              face2LastColumn.count == Constants.numberOfItems
        else { completion(face4.cells); return }
        
        let face1Converted = face1LastColumn.map { return $0 >> 4 }
        (0..<lastIndex).forEach { face4.cells[$0][0] = face1Converted[$0] }
        
        let face2Converted = face2LastColumn.map { return $0 >> 4 }
        face4.cells[lastIndex] = face2Converted
        
        self.placeMines(on: face4.cells) { completion($0) }
    }
    
    private func updateFace5(input: (Face, Face, Face), face5: Face, completion: @escaping (([[Cell]]) -> Void)) {
        guard let face1FirstLine = input.0.cells.first,
              let face3FirstLine = input.1.cells.first,
              let face4FirstLine = input.2.cells.first,
              face1FirstLine.count == Constants.numberOfItems,
              face3FirstLine.count == Constants.numberOfItems,
              face4FirstLine.count == Constants.numberOfItems
        else { completion(face5.cells); return }
        let lastIndex = Constants.numberOfItems - 1
        
        face5.cells[lastIndex] = face1FirstLine.map { return $0 >> 5 }
        
        let face3Converted = face3FirstLine.map { return $0 >> 5 }
        (0..<lastIndex).forEach { face5.cells[$0][0] = face3Converted[$0] }
        
        let face4Converted = face4FirstLine.map { return $0 >> 5 }
        (0..<lastIndex).forEach { face5.cells[$0][lastIndex] = face4Converted.reversed()[$0] }
        
        self.placeMines(on: face5.cells) { completion($0) }
    }
    
    private func updateFace6(input: (Face, Face, Face, Face), face6: Face, completion: @escaping (([[Cell]]) -> Void)) {
        let face3FirstColumn = input.1.cells.map { $0.first }.compactMap { $0 }
        let face4LastColumn = input.2.cells.map { $0.last }.compactMap { $0 }
        let lastIndex = Constants.numberOfItems - 1
        
        guard let face2LastLine = input.0.cells.last,
              let face5FirstLine = input.3.cells.first,
              face2LastLine.count == Constants.numberOfItems,
              face3FirstColumn.count == Constants.numberOfItems,
              face4LastColumn.count == Constants.numberOfItems,
              face5FirstLine.count == Constants.numberOfItems
        else { completion(face6.cells); return }
        
        face6.cells[0] = face2LastLine.map { return $0 >> 6 }
        
        let face3Converted = face3FirstColumn.map { return $0 >> 6 }
        (0..<lastIndex).forEach { face6.cells[$0][0] = face3Converted.reversed()[$0] }
        
        let face4Converted = face4LastColumn.map { return $0 >> 6 }
        (0..<lastIndex).forEach { face6.cells[$0][lastIndex] = face4Converted.reversed()[$0] }
        
        face6.cells[lastIndex] = face5FirstLine.map { return $0 >> 6 }
        
        self.placeMines(on: face6.cells) { completion($0) }
    }
    
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
            }
        }
        
        completion(aux)
    }
    
    // swiftlint:disable line_length
    #if DEBUG
    private func debug_face1MineGeneration() -> [[Cell]] {
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
        
        return cells
    }
    #endif
}
