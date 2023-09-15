//
//  Board.swift
//  Minesweeper 3D
//
//  Created by Aaron on 12/7/21.
//

import Foundation

//struct Board {
//    
//    var b: [[Cell]]
//    
//    init(_ b: [[Cell]]) {
//        self.b = b
//    }
//    
//    init(_ b: [[CellCD]]) {
//        self.b = b.map { return $0.map { return Cell(cellCD: $0) } }
//    }
//    
//    func hideAllCells() {
//        for line in self.b {
//            for cell in line {
//                cell.setTappability(false)
//                cell.mined = false
//                cell.flagged = false
//            }
//        }
//    }
//    
//    func showAllCells() {
//        for line in self.b { for cell in line { cell.setTappability(true) } }
//    }
//    
//    func disableEditing() {
//        for line in self.b { for cell in line { cell.canBeEdited = false } }
//    }
//    
//    func resetCoords() {
//        for line in 0..<self.b.count {
//            for row in 0..<self.b[line].count {
//                self.b[line][row].xCor = row
//                self.b[line][row].yCor = line
//            }
//        }
//    }
//    
//    // MARK: Side cells getters
//    // ========================
//    func getHBorderSideCells(at column: Int, side: HSide) -> [Cell] {
//        switch side {
//        case .top:
//            return [
//                self.b[0][column - 1], // `W`  Cell
//                self.b[0][column + 1], // `E`  Cell
//                self.b[1][column - 1], // `SW` Cell
//                self.b[1][column],     // `S`  Cell
//                self.b[1][column + 1]  // `SE` Cell
//            ]
//        case .bottom:
//            let end = Constants.numberOfItems - 1
//            return [
//                self.b[end - 1][column - 1], // `NW` Cell
//                self.b[end - 1][column],     // `N`  Cell
//                self.b[end - 1][column + 1], // `NE` Cell
//                self.b[end][column - 1],     // `W`  Cell
//                self.b[end][column + 1]      // `E`  Cell
//            ]
//        }
//    }
//    
//    func getVBorderSideCells(at row: Int, side: VSide) -> [Cell] {
//        switch side {
//        case .left:
//            return [
//                self.b[row - 1][0], // `N`Cell
//                self.b[row - 1][1], // `NE`Cell
//                self.b[row][1],     // `E`Cell
//                self.b[row + 1][0], // `S`Cell
//                self.b[row + 1][1]  // `SE`Cell
//            ]
//        case .right:
//            let end = Constants.numberOfItems - 1
//            return [
//                self.b[row - 1][end - 1], // `NW`Cell
//                self.b[row - 1][end],     // `N`Cell
//                self.b[row][end - 1],     // `W`Cell
//                self.b[row + 1][end - 1], // `SW`Cell
//                self.b[row + 1][end]      // `S`Cell
//            ]
//        }
//    }
//    
//    func getCornerSideCells(at corner: Corner) -> [Cell] {
//        let end = Constants.numberOfItems - 1
//        
//        switch corner {
//        case .tL: return [self.b[0][1], self.b[1][0], self.b[1][1]] // `E`, `S`, `SE` Cells
//        case .tR: return [self.b[0][end - 1], self.b[1][end - 1], self.b[1][end]] // `W`, `SW`, `S`  Cells
//        case .bL: return [self.b[end - 1][0], self.b[end - 1][1], self.b[end][1]] // `N`, `NE`, `E` Cells
//        case .bR: return [self.b[end - 1][end - 1], self.b[end - 1][end], self.b[end][end - 1]] // `NW`, `N`, `W` Cells
//        }
//    }
//    
//    func getInnerSideCells(at coords: (row: Int, column: Int)) -> [Cell] {
//        return [
//            self.b[coords.row - 1][coords.column - 1], // `NW`Cell
//            self.b[coords.row - 1][coords.column],     // `N`Cell
//            self.b[coords.row - 1][coords.column + 1], // `NE`Cell
//            self.b[coords.row][coords.column - 1],     // `W`Cell
//            self.b[coords.row][coords.column + 1],     // `E`Cell
//            self.b[coords.row + 1][coords.column - 1], // `SW`Cell
//            self.b[coords.row + 1][coords.column],     // `S`Cell
//            self.b[coords.row + 1][coords.column + 1]  // `SE`Cell
//        ]
//    }
//}
