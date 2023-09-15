//
//  MSCoreDataController.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import Foundation

class MSCoreDataController {
    static let shared = MSCoreDataController()
    
    // MARK: Saving
    // ============
    func save(settings: MSSettings, reset: Bool) {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: settings, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: MSCoreDataKey.settings.key)
            
            if reset { restart() }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
//    func save(game: Game, completion: @escaping ((Error?) -> Void)) {
//        do {
//            let encodedGame = try NSKeyedArchiver.archivedData(withRootObject: game, requiringSecureCoding: false)
//            UserDefaults.standard.set(encodedGame, forKey: MSCoreDataKey.game.key)
//            completion(nil)
//        } catch {
//            completion(error)
//        }
//    }
    
    // MARK: Retrieving
    // ================
    func getSettingModel(iteration: Int) -> MSSettings {
        if iteration == 3 { fatalError("Could not get settings") }
        
        let model = MSSettings(
            username: "",
            appLanguage: nil,
            autosaveRanks: false,
            maxRanks: MSConstants.maxRanksRange.lowerBound
        )
        
        if let decoded = UserDefaults.standard.object(forKey: MSCoreDataKey.settings.key) as? Data {
            do {
                return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? MSSettings ?? model
            } catch { fatalError(error.localizedDescription) }
        } else {
            save(settings: model, reset: false)
            
            return getSettingModel(iteration: iteration + 1)
        }
    }
    
//    func getGame(iteration: Int, completion: @escaping ((Game?) -> Void)) {
//        guard iteration < 3 else { completion(nil); return }
//
//        if let decoded = UserDefaults.standard.object(forKey: MSCoreDataKey.game.key) as? Data {
//            do {
//                let decodedGame = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? Game
//                completion(decodedGame)
//            } catch { completion(nil) }
//        } else {
//            self.getGame(iteration: iteration + 1, completion: completion)
//        }
//    }
    
    // MARK: Deletion
    // ==============
    func deleteAllData() {
        UserDefaults.standard.removeObject(forKey: MSCoreDataKey.settings.key)
        UserDefaults.standard.removeObject(forKey: MSCoreDataKey.game.key)
        
        restart()
    }
    
//    func deleteSavedGame() {
//        UserDefaults.standard.removeObject(forKey: MSCoreDataKey.game.key)
//    }
    
    func restart() {
        MSAppState.shared.gameID = UUID()
    }
}
