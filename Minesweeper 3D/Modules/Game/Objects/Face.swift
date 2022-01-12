//
//  Face.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import Foundation

class Face: Identifiable {
    
    var id: UUID = UUID()
    var number: Int
    var references: References
    var cells: Board = Board([[Cell]]())
    var rotated: Face {
        let newFace = self
        newFace.cells = self.rotate(cells: self.cells, degrees: self.rotatedFromLastPosition)
        return newFace
    }
    var generated: Bool = false
    private var lastReferences = References()
    private var rotatedFromLastPosition: Degrees {
        switch self.references.top {
        case self.lastReferences.left: return .positiveQuart
        case self.lastReferences.right: return .negativeQuart
        case self.lastReferences.bottom: return .half
        default: return .none
        }
    }
    
    init(number: Int, references: References) {
        self.number = number
        self.references = references
        self.generateBoard()
    }
    
    init(faceCD: FaceCD) {
        self.number = faceCD.number
        self.references = faceCD.references
        self.cells = Board(faceCD.cells)
        self.generated = faceCD.generated
        self.lastReferences = faceCD.lastReferences
    }
    
    // MARK: Face rotation methods
    // ===========================
    func updateNewReferences(from face: Face, to direction: Direction) {
        self.lastReferences = self.references
        
        switch direction {
        case .up:
            self.references.top = (7 - face.number)
            self.references.bottom = face.number
            self.references.left = face.references.left
            self.references.right = face.references.right
        case .down:
            self.references.top = face.number
            self.references.bottom = (7 - face.number)
            self.references.left = face.references.left
            self.references.right = face.references.right
        case .left:
            self.references.top = face.references.top
            self.references.bottom = face.references.bottom
            self.references.left = (7 - face.number)
            self.references.right = face.number
        case .right:
            self.references.top = face.references.top
            self.references.bottom = face.references.bottom
            self.references.left = face.number
            self.references.right = (7 - face.number)
        }
    }
    
    func updateVisibleSides(with sides: BoardT_4) {
        let b = sides.t, top = b.0, bottom = b.1, left = b.2, right = b.3, last = Constants.numberOfItems - 1
        
        (0..<top.count).forEach { self.updateCell(at: (0, $0), from: top[$0]) }
        (0..<bottom.count).forEach { self.updateCell(at: (last, $0), from: bottom[$0]) }
        (0..<left.count).forEach { self.updateCell(at: ($0, 0), from: left[$0]) }
        (0..<right.count).forEach { self.updateCell(at: ($0, last), from: right[$0]) }
        
        self.executeRecurssionAfterRotation(type: .hBorder(.bottom))
        self.executeRecurssionAfterRotation(type: .hBorder(.top))
        self.executeRecurssionAfterRotation(type: .vBorder(.right))
        self.executeRecurssionAfterRotation(type: .vBorder(.left))
    }
    
    private func updateCell(at position: (x: Int, y: Int), from cell: Cell) {
        let aux = self.cells.b[position.x][position.y]
        aux.mined = cell.mined
        aux.flagged = cell.flagged
        
        if !aux.shown { aux.setTappability(cell.shown) }
    }
    
    private func rotate(cells: Board, degrees: Degrees) -> Board {
        switch degrees {
        case .positiveQuart: return Board(cells.b.transposed.reversedRows)
        case .negativeQuart: return Board(cells.b.transposed.reversedColumns)
        case .half: return Board(cells.b.reversedRows.reversedColumns)
        case .none: return cells
        }
    }

    // MARK: Board generation methods
    // ==============================
    private func generateBoard() {
        self.cells = Board(Constants.boardCells.map { self.generateRow(rowNumber: $0) })
    }
    
    private func generateRow(rowNumber: Int) -> [Cell] {
        return Constants.boardCells.map {
            let cell = Cell(face: self.number, xCor: $0, yCor: rowNumber, content: .unselected)
            return cell
        }
    }
    
    // MARK: Recurssion methods
    // ========================
    func recursiveDisplay(from cell: Cell, completion: @escaping ((Cell) -> Void)) {
        var sideCells: [Cell] = []
        
        switch cell.type {
        case .inner: sideCells = self.cells.getInnerSideCells(at: (cell.yCor, cell.xCor)).filter { !$0.shown }
        case .vBorder(let s): sideCells = self.cells.getVBorderSideCells(at: cell.yCor, side: s).filter { !$0.shown }
        case .hBorder(let s): sideCells = self.cells.getHBorderSideCells(at: cell.xCor, side: s).filter { !$0.shown }
        case .corner(let c): sideCells = self.cells.getCornerSideCells(at: c).filter { !$0.shown }
        }
        
        sideCells.forEach {
            switch $0.content {
            case .void, .number:
                $0.setTappability(true)
                completion($0)
                
                if $0.content == .void { self.recursiveDisplay(from: $0, completion: completion) }
            default: completion(cell)
            }
        }
    }
    
    private func executeRecurssionAfterRotation(type: CellType) {
        var sideVisible: [Cell] = []
        let last = Constants.numberOfItems - 1
        
        switch type {
        case .vBorder(let s): sideVisible = self.cells.b.vertical(at: s == .left ? 0 : last) ?? []
        case .hBorder(let s): sideVisible = self.cells.b.horizontal(at: s == .top ? 0 : last) ?? []
        default: break
        }

        sideVisible
            .filter { $0.shown && $0.content == .void }
            .forEach { self.recursiveDisplay(from: $0) { _ in } }
    }
    
    // MARK: CoreData Saving
    // =====================
    func getDaceCD() -> FaceCD {
        return FaceCD(
            number: self.number,
            references: self.references,
            cells: self.cells,
            generated: self.generated,
            lastReferences: self.lastReferences
        )
    }
}
