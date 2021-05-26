//
//  CellContent.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/5/21.
//

import SwiftUI

enum CellContent {
    case mine
    case number
    case void
    case none
    
    var display: Image {
        switch self {
        case .mine: return Image(systemName: "")
        case .number: return Image(systemName: "")
        case .void: return Image(systemName: "")
        case .none: return Image(systemName: "")
        }
    }
}
