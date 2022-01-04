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
        for line in self.b { for cell in line { cell.setTappability(false) } }
    }
    
    func showAllCells() {
        for line in self.b { for cell in line { cell.setTappability(true) } }
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
}
