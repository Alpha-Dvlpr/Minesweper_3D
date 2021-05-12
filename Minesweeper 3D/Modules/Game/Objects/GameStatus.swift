//
//  GameStatus.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import Foundation

enum GameStatus {
    case running
    case paused
    case won
    case lost
    
    var text: String {
        switch self {
        case .paused: return Texts.gamePaused.localized
        case .won: return Texts.gameWon.localized
        case .lost: return Texts.gameLost.localized
        default: return ""
        }
    }
}
