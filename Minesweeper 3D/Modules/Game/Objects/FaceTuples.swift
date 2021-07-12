//
//  FaceTuples.swift
//  Minesweeper 3D
//
//  Created by Aaron on 12/7/21.
//

import Foundation

struct FaceT_2 {
    
    var t: (Face, Face)
    
    init(_ t: (Face, Face)) {
        self.t = t
    }
}

struct FaceT_3 {
    
    var t: (Face, Face, Face)
    
    init(_ t: (Face, Face, Face)) {
        self.t = t
    }
}

struct FaceT_4 {
    
    var t: (Face, Face, Face, Face)
    
    init(_ t: (Face, Face, Face, Face)) {
        self.t = t
    }
}

struct FaceT_6 {
    
    var t: (Face, Face, Face, Face, Face, Face)
    
    init(_ t: (Face, Face, Face, Face, Face, Face)) {
        self.t = t
    }
}
