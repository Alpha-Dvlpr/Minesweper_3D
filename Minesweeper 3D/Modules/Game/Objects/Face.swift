//
//  Face.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import Foundation

class Face: Identifiable {
    var id: UUID = UUID()
    var number: Int
    var topReference: Int = 0
    var bottomReference: Int = 0
    var leftReference: Int = 0
    var rightReference: Int = 0
    
    init(number: Int) {
        self.number = number
    }
}
