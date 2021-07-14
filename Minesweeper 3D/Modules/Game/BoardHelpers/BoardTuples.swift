//
//  BoardTuples.swift
//  Minesweeper 3D
//
//  Created by Aaron on 14/7/21.
//

import Foundation

struct BoardT_2 {
    
    var t: ([Cell], [Cell])
    var ok: Bool {
        let noEmpty = !self.t.0.isEmpty
            && !self.t.1.isEmpty
        let allEqualCount = (self.t.0.count + self.t.1.count) / 2 == self.t.0.count
        
        return noEmpty && allEqualCount
    }
    
    static var empty: BoardT_2 { return BoardT_2([], []) }
    
    init(_ t1: [Cell], _ t2: [Cell]) {
        self.t = (t1, t2)
    }
}

struct BoardT_4 {
    
    var t: ([Cell], [Cell], [Cell], [Cell])
    var ok: Bool {
        let noEmpty = !self.t.0.isEmpty
            && !self.t.1.isEmpty
            && !self.t.2.isEmpty
            && !self.t.3.isEmpty
        let allEqualCount = (self.t.0.count + self.t.1.count + self.t.2.count + self.t.3.count) / 4 == self.t.0.count
        
        return noEmpty && allEqualCount
    }
    
    static var empty: BoardT_4 { return BoardT_4([], [], [], []) }
    
    init(_ t1: [Cell], _ t2: [Cell], _ t3: [Cell], _ t4: [Cell]) {
        self.t = (t1, t2, t3, t4)
    }
}
