//
//  Board.swift
//  Minesweeper 3D
//
//  Created by Aaron on 12/7/21.
//

import Foundation

struct Board {
    
    var b: [[Cell]]
    
    init(_ b: [[Cell]]) {
        self.b = b
    }
    
    func hideAllCells() {
        for line in self.b { for cell in line { cell.shown = false; cell.tappable = true } }
    }
    
    func showAllCells() {
        for line in self.b { for cell in line { cell.shown = true; cell.tappable = false } }
    }
    
    func disableEditing() {
        for line in self.b { for cell in line { cell.canBeEdited = false } }
    }
    
    func resetCoords() {
        for line in 0..<self.b.count {
            for row in 0..<self.b[line].count {
                self.b[line][row].xCor = row
                self.b[line][row].yCor = line
            }
        }
    }
    
    func recursiveDisplay(from cell: Cell, completion: @escaping ((Bool) -> Void)) {
        var surrounding = [Cell]()
        let lastIndex = Constants.numberOfItems - 1
        
//        switch cell.type {
//        case .corner:
//            if cell.xCor == 0 && cell.yCor == 0 {
//                surrounding = [
//                    self.b[cell.yCor][cell.xCor + 1],       // E  Cell
//                    self.b[cell.yCor + 1][cell.xCor + 1],   // SE Cell
//                    self.b[cell.yCor + 1][cell.xCor]        // S  Cell
//                ]
//            }
//            
//            if cell.xCor == lastIndex && cell.yCor == 0 {
//                surrounding = [
//                    self.b[cell.yCor + 1][cell.xCor],     // S  Cell
//                    self.b[cell.yCor + 1][cell.xCor - 1], // SW Cell
//                    self.b[cell.yCor][cell.xCor - 1]     // W  Cell
//                ]
//            }
//            
//            if cell.xCor == 0 && cell.yCor == lastIndex {
//                surrounding = [
//                    self.b[cell.yCor - 1][cell.xCor],     // N  Cell
//                    self.b[cell.yCor - 1][cell.xCor + 1], // NE Cell
//                    self.b[cell.yCor][cell.xCor + 1]      // E  Cell
//                ]
//            }
//            
//            if cell.xCor == lastIndex && cell.yCor == lastIndex {
//                surrounding = [
//                    self.b[cell.yCor][cell.xCor - 1],     // W  Cell
//                    self.b[cell.yCor - 1][cell.xCor - 1], // NW Cell
//                    self.b[cell.yCor - 1][cell.xCor]      // N  Cell
//                ]
//            }
//        default: break
//        }
        
        let dispatchGroup = DispatchGroup()
        
//        surrounding.filter { !$0.shown }.forEach {
//            dispatchGroup.enter()
//            self.recursiveDisplay(from: $0) { _ in dispatchGroup.leave() }
//        }
        
        dispatchGroup.notify(queue: .main) {
            completion(true)
        }
    }
}
