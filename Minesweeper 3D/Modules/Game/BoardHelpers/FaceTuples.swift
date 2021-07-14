//
//  FaceTuples.swift
//  Minesweeper 3D
//
//  Created by Aaron on 12/7/21.
//

import Foundation

struct FaceT_2 {
    
    var t: (Face, Face)
    var b: (Board, Board) {
        return (self.t.0.cells, self.t.1.cells)
    }
    var i: [Face] {
        return [self.t.0, self.t.1]
    }
    
    init(_ t1: Face, _ t2: Face) {
        self.t = (t1, t2)
    }
}

struct FaceT_3 {
    
    var t: (Face, Face, Face)
    var b: (Board, Board, Board) {
        return (self.t.0.cells, self.t.1.cells, self.t.2.cells)
    }
    var i: [Face] {
        return [self.t.0, self.t.1, self.t.2]
    }
    
    init(_ t1: Face, _ t2: Face, _ t3: Face) {
        self.t = (t1, t2, t3)
    }
}

struct FaceT_4 {
    
    var t: (Face, Face, Face, Face)
    var b: (Board, Board, Board, Board) {
        return (self.t.0.cells, self.t.1.cells, self.t.2.cells, self.t.3.cells)
    }
    var i: [Face] {
        return [self.t.0, self.t.1, self.t.2, self.t.3]
    }
    
    init(_ t1: Face, _ t2: Face, _ t3: Face, _ t4: Face) {
        self.t = (t1, t2, t3, t4)
    }
}

struct FaceT_6 {
    
    var t: (Face, Face, Face, Face, Face, Face)
    var b: (Board, Board, Board, Board, Board, Board) {
        return (self.t.0.cells, self.t.1.cells, self.t.2.cells, self.t.3.cells, self.t.4.cells, self.t.5.cells)
    }
    var i: [Face] {
        return [self.t.0, self.t.1, self.t.2, self.t.3, self.t.4, self.t.5]
    }
    
    init(_ t1: Face, _ t2: Face, _ t3: Face, _ t4: Face, _ t5: Face, _ t6: Face) {
        self.t = (t1, t2, t3, t4, t5, t6)
    }
}
