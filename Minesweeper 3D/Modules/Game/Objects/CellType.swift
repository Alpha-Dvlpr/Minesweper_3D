//
//  CellType.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 14/05/2021.
//

import SwiftUI

enum CellType {
    case corner
    case vBorder
    case hBorder
    case inner
    
    init(x: Int, y: Int) {
        let end = Constants.numberOfItems - 1
        
        if y == 0 || y == end {
            self = (x == 0 || x == end) ? .corner : .hBorder
        } else {
            self = (x == 0 || x == end) ? .vBorder : .inner
        }
    }
    
    var color: Color {
        switch self {
        case .corner: return Color.red
        case .vBorder: return Color.yellow
        case .hBorder: return Color.orange
        case .inner: return Color.green
        }
    }
}
