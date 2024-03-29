//
//  MSGameVM.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 27/3/24.
//

import SwiftUI

class MSGameVM: ObservableObject {
    
    @Published var gameStatus: MSGameStatus = .generating
    @Published var gameTime: Int = 0
    @Published var actionsEnabled: Bool = false
    @Published var showActionSheet: Bool = false
    @Published var showCloseAlert: Bool = false
    
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
    
    // MARK: - Board And Game Actions
    func timerAction() { gameTime += gameStatus == .running ? 1 : 0 }
    func closeAction() { showCloseAlert = true }
    func menuAction() { showActionSheet = true }
    
    func printCurrentFace() {
        
    }
    
    func pauseAction() {
        switch gameStatus {
        case .paused: gameStatus = .running
        case .running: gameStatus = .paused
        default: break
        }
    }
    
    func newGame() { }
    
    func restartGame() { }
    
    func saveGame() { }
    
    // MARK: - Hints
    func getHints(for position: MSHintPosition) -> [Int] {
        switch position {
        case .top: return getTopHints()
        case .bottom: return getBottomHints()
        case .left: return getLeftHints()
        case .right: return getRightHints()
        }
    }
    
    func hintRowAction() {
        
    }
    
    // MARK: - Bottom Actions
    func actionButtonTapped(_ action: MSAction) {
        guard actionsEnabled else { return }
        
        switch action {
        case .number: handleNumberAction()
        case .flag: handleFlagAction()
        case .mine: handleMineAction()
        }
    }
}

private extension MSGameVM {
    
    // MARK: - Hints
    func getTopHints() -> [Int] {
        return []
    }
    
    func getBottomHints() -> [Int] {
        return []
    }
    
    func getLeftHints() -> [Int] {
        return []
    }
    
    func getRightHints() -> [Int] {
        return []
    }
    
    // MARK: - Bottom Actions
    func handleNumberAction() {
        
    }
    
    func handleFlagAction() {
        
    }
    
    func handleMineAction() {
        
    }
}
