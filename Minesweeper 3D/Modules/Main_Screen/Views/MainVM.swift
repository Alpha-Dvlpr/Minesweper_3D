//
//  MainVM.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 05/01/2022.
//

import SwiftUI

class MainVM {
    
    @Published var savedGame: Game?
    var error: Error?
    private let coreData = CoreDataController.shared
    
    init() {
        self.getSavedGame()
    }
    
    // MARK: Error methods
    // ===================
    func updateError(_ error: Error?) {
        self.error = error
    }
    
    // MARK: Game functions
    // ====================
    func getSavedGame() {
        self.coreData.getGame(iteration: 0) { self.savedGame = $0 }
    }
    
    func deleteGame() {
        self.coreData.deleteSavedGame()
    }
}
