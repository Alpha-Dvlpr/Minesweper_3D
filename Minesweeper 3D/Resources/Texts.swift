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
    case save
    case delete
    case deleteTitle
    case deleteDisclaimer
    case username
    case language
    case autosaveRanks
    case maxRanks
    case boolToString(value: Bool)
    case typeNewValue
    case currentValueDisclaimer
    
    var localized: String {
        switch self {
        case .main: return "Inicio"
        case .newGame: return "Nueva partitda"
        case .bestMarks: return "Mejores puntuaciones"
        case .settings: return "Ajustes"
        case .accept: return "Aceptar"
        case .cancel: return "Cancelar"
        case .save: return "Guardar"
        case .delete: return "Eliminar"
        case .deleteTitle: return "Eliminar datos"
        case .deleteDisclaimer: return "¿Desea eliminar todos los datos de la aplicación?\nLa aplicación se reiniciará para que los cambios surtan efecto"
        case .username: return "Nombre de usuario"
        case .language: return "Idioma de la aplicación"
        case .autosaveRanks: return "Auto guardado de puntuaciones"
        case .maxRanks: return "Número máximo de puntuaciones"
        case .boolToString(let value): return value ? "SI" : "NO"
        case .typeNewValue: return "Introduce el nuevo valor"
        case .currentValueDisclaimer: return "El valor actual es '%@', ¿desea cambiarlo a '%@'?"
        }
    }
}
