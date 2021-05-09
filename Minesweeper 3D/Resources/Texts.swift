//
//  Texts.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import Foundation

enum Texts {
    case newGame
    case bestMarks
    case settings
    
    var localized: String {
        switch self {
        case .newGame: return "Nueva partitda"
        case .bestMarks: return "Mejores puntuaciones"
        case .settings: return "Ajustes"
        }
    }
}
