//
//  MSMainVM.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 05/01/2022.
//

import SwiftUI

class MSMainVM {
    
    @Published var savedGame: Game?
    var settings: Settings!
    var error: Error?
    private let coreData = CoreDataController.shared
    
    init() {
        getSavedGame()
        settings = coreData.getSettingModel(iteration: 1)
    }
    
    // MARK: Error methods
    // ===================
    func updateError(_ error: Error?) {
        self.error = error
    }
    
    // MARK: Game functions
    // ====================
    func getSavedGame() {
        coreData.getGame(iteration: 0) { self.savedGame = $0 }
    }
    
    func deleteGame() {
        coreData.deleteSavedGame()
    }
    
    // MARK: UI update functions
    // =========================
    func updateSettings() {
        settings = coreData.getSettingModel(iteration: 1)
    }
}
