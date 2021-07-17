//
//  BoardTuples.swift
//  Minesweeper 3D
//
//  Created by Aaron on 14/7/21.
//

import Foundation

struct BoardT_2 {
    
    var t: ([Cell], [Cell])
    var ok: BoardT_2? {
        let equal = Int.equal(elements: [self.t.0.count, self.t.1.count])
        return equal.0 && equal.1 == Constants.numberOfItems ? self : nil
    }
    
    init(_ t1: [Cell], _ t2: [Cell]) {
        self.t = (t1, t2)
    }
}

struct BoardT_4 {
    
    var t: ([Cell], [Cell], [Cell], [Cell])
    var ok: BoardT_4? {
        let equal = Int.equal(elements: [self.t.0.count, self.t.1.count, self.t.2.count, self.t.3.count])
        return equal.0 && equal.1 == Constants.numberOfItems ? self : nil
    }
    
    init(_ t1: [Cell], _ t2: [Cell], _ t3: [Cell], _ t4: [Cell]) {
        self.t = (t1, t2, t3, t4)
    }
}
