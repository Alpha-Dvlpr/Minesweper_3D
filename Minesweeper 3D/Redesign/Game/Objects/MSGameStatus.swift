//
//  MSGameStatus.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import Foundation

enum MSGameStatus: String {
    case running
    case paused
    case won
    case lost
    case generating
    case recurssive
    
    var text: String {
        switch self {
        case .paused: return MSTexts.gamePaused.localized
        case .won: return MSTexts.gameWon.localized
        case .lost: return MSTexts.gameLost.localized
        case .generating: return MSTexts.generatingGame.localized
        default: return ""
        }
    }
}
