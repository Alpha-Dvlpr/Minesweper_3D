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
        for line in self.b { for cell in line { cell.shown = false } }
    }
    
    func disableEditing() {
        for line in self.b { for cell in line { cell.canBeEdited = false } }
    }
    
    func vertical(at index: Int, reversed: Bool = false) -> [Cell]? {
        let cells = self.b.map { $0[index] }.compactMap { $0 }
        
        guard cells.count == Constants.numberOfItems else { return nil }
        
        return reversed ? cells.reversed() : cells
    }
    
    func horizontal(at index: Int, reversed: Bool = false) -> [Cell]? {
        guard index < self.b.count else { return nil }
        
        let cells = self.b[index]
        
        guard cells.count == Constants.numberOfItems else { return nil }
        
        return reversed ? cells.reversed() : cells
    }
    
    func resetCoords() {
        for line in 0..<self.b.count {
            for row in 0..<self.b[line].count {
                self.b[line][row].xCor = row
                self.b[line][row].yCor = line
            }
        }
    }
}
