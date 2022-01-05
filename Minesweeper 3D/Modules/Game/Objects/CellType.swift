//
//  CellType.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 14/05/2021.
//

import SwiftUI

enum Corner {
    case tL
    case tR
    case bL
    case bR
    
    init(_ x: Int, _ y: Int) {
        let end = Constants.numberOfItems - 1
        
        if x == 0 && y == 0 { self = .tL }
        else if x == 0 && y == end { self = .bL }
        else if x == end && y == 0 { self = .tR }
        else { self = .bR }
    }
}

enum HSide {
    case top
    case bottom
    
    init(_ y: Int) { self = y == (Constants.numberOfItems - 1) ? .bottom : .top }
}

enum VSide {
    case left
    case right
    
    init(_ x: Int) { self = x == (Constants.numberOfItems - 1) ? .right : .left }
}

enum CellType: Equatable {
    
    case corner(Corner)
    case vBorder(VSide)
    case hBorder(HSide)
    case inner
    
    init(x: Int, y: Int) {
        let end = Constants.numberOfItems - 1
        
        if y == 0 || y == end {
            self = (x == 0 || x == end) ? .corner(Corner(x, y)) : .hBorder(HSide(y))
        } else {
            self = (x == 0 || x == end) ? .vBorder(VSide(x)) : .inner
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
    
    var isCorner: Bool {
        return self == .corner(.tL) || self == .corner(.tR) || self == .corner(.bL) || self == .corner(.bR)
    }
    var isHSide: Bool { return self == .hBorder(.top) || self == .hBorder(.bottom) }
    var isVSide: Bool { return self == .vBorder(.left) || self == .vBorder(.right) }
}
