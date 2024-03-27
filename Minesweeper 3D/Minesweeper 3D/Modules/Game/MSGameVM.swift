//
//  MSGameVM.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 27/3/24.
//

import SwiftUI

class MSGameVM: ObservableObject {
    
    @Published var gameStatus: MSGameStatus = .running
    @Published var gameTime: Int = 0
    @Published var showActionSheet: Bool = false
    @Published var showCloseAlert: Bool = false
    @Published var showRanksAlert: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var stringTime: String { return MSUtils.getStringTime(seconds: gameTime) }
    
    var actionBarButton: Image {
        switch gameStatus {
        case .generating: return MSImages.system(.timer).image
        case .lost, .won: return MSImages.system(.restart).image
        case .paused: return MSImages.system(.play).image
        case .recurssive: return MSImages.system(.clock).image
        case .running: return MSImages.system(.pause).image
        }
    }
    
    func increaseTimer() {
        if gameStatus == .running { gameTime += 1 }
    }
    
    func pauseResumeButtonTapped() {
        switch gameStatus {
        case .paused: gameStatus = .running
        case .running: gameStatus = .paused
        default: break
        }
    }
    
    func newGame() {
        gameTime = 0
        gameStatus = .generating
        // generateFaceNumbers()
    }
    
    func restartGame() {
        gameTime = 0
        // faces.forEach { $0.cells.hideAllCells() }
        gameStatus = .running
    }
    
    func saveGame() {
        
    }
    
    func saveRank() {
        
    }
}
