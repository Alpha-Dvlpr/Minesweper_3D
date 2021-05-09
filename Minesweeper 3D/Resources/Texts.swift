//
//  Texts.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import Foundation

enum Texts {
    case main
    case newGame
    case bestMarks
    case settings
    case accept
    case cancel
    case delete
    case deleteTitle
    case deleteDisclaimer
    
    var localized: String {
        switch self {
        case .main: return "Inicio"
        case .newGame: return "Nueva partitda"
        case .bestMarks: return "Mejores puntuaciones"
        case .settings: return "Ajustes"
        case .accept: return "Aceptar"
        case .cancel: return "Cancelar"
        case .delete: return "Eliminar"
        case .deleteTitle: return "Eliminar datos"
        case .deleteDisclaimer: return "¿Desea eliminar todos los datos de la aplicación?\nLa aplicación se reiniciará para que los cambios surtan efecto"
        }
    }
}
