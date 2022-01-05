//
//  References.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/5/21.
//

import Foundation

struct References {
    
    var _self: Int = 0
    var top: Int = 0
    var bottom: Int = 0
    var left: Int = 0
    var right: Int = 0
    
    init() { }
    
    init(_ _self: Int, top: Int, bottom: Int, left: Int, right: Int) {
        self._self = _self
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }
}
