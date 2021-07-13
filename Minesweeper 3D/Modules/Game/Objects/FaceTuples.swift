//
//  FaceTuples.swift
//  Minesweeper 3D
//
//  Created by Aaron on 12/7/21.
//

import Foundation

struct FaceT_2 {
    
    var t: (Face, Face)
    var i: [Face] { return [self.t.0, self.t.1] }
    
    init(_ t: (Face, Face)) {
        self.t = t
    }
}

struct FaceT_3 {
    
    var t: (Face, Face, Face)
    var i: [Face] { return [self.t.0, self.t.1, self.t.2] }
    
    init(_ t: (Face, Face, Face)) {
        self.t = t
    }
}

struct FaceT_4 {
    
    var t: (Face, Face, Face, Face)
    var i: [Face] { return [self.t.0, self.t.1, self.t.2, self.t.3] }
    
    init(_ t: (Face, Face, Face, Face)) {
        self.t = t
    }
}

struct FaceT_6 {
    
    var t: (Face, Face, Face, Face, Face, Face)
    var i: [Face] { return [self.t.0, self.t.1, self.t.2, self.t.3, self.t.4, self.t.5] }
    
    init(_ t: (Face, Face, Face, Face, Face, Face)) {
        self.t = t
    }
}
