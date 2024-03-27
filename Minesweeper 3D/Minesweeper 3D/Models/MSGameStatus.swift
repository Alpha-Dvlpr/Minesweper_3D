//
//  MSGameStatus.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 27/3/24.
//

import Foundation

enum MSGameStatus: String {
    
    case generating
    case lost
    case paused
    case recurssive
    case running
    case won
    
    var text: String {
        switch self {
        case .generating: return MSTexts.generatingGame.localized
        case .lost: return MSTexts.gameLost.localized
        case .paused: return MSTexts.gamePaused.localized
        case .won: return MSTexts.gameWon.localized
        default: return ""
        }
    }
}
