//
//  MSMainVM.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 05/01/2022.
//

import SwiftUI

class MSMainVM: ObservableObject {
    
//    @Published var savedGame: Game?
    @Published var settings: MSSettings?
    @Published var error: Error?
    private let coreData = MSCoreDataController.shared
    
    // MARK: Game functions
    // ====================
    func getSavedGame() {
//        coreData.getGame(iteration: 0) { self.savedGame = $0 }
    }
    
    func deleteGame() {
//        coreData.deleteSavedGame()
    }
    
    // MARK: UI update functions
    // =========================
    func updateSettings() {
        settings = coreData.getSettingModel(iteration: 1)
    }
}
