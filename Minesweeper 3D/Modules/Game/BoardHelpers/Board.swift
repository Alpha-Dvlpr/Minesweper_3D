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
    
    func getFirstVertical(reversed: Bool = false) -> [Cell]? {
        let cells = self.b.map { $0.first }.compactMap { $0 }
        
        guard cells.count == Constants.numberOfItems else { return nil }
        
        return reversed ? cells.reversed() : cells
    }
    
    func getLastVertical(reversed: Bool = false) -> [Cell]? {
        let cells = self.b.map { $0.last }.compactMap { $0 }
        
        guard cells.count == Constants.numberOfItems else { return nil }
        
        return reversed ? cells.reversed() : cells
    }
}
