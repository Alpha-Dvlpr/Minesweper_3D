//
//  CoreDataController.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import Foundation

class CoreDataController {
    static let shared = CoreDataController()
    
    // MARK: Saving
    // ============
    func save(settings: Settings, reset: Bool) {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: settings, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: CoreDataKey.settings.key)
            if reset { self.restart() }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func save(game: Game, completion: @escaping ((Error?) -> Void)) {
        do {
            let encodedGame = try NSKeyedArchiver.archivedData(withRootObject: game, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedGame, forKey: CoreDataKey.game.key)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    func save(rank: Rank, completion: @escaping ((Error?) -> Void)) {
        func save(ranks: [Rank], completion: @escaping ((Error?) -> Void)) {
            do {
                let encodedRank = try NSKeyedArchiver.archivedData(withRootObject: ranks, requiringSecureCoding: false)
                UserDefaults.standard.set(encodedRank, forKey: CoreDataKey.ranks.key)
                completion(nil)
            } catch {
                completion(error)
            }
        }
        
        self.getRanks(iteration: 1) { existingRanks in
            if var existingRanks = existingRanks {
                existingRanks.append(rank)
                save(ranks: existingRanks, completion: completion)
            } else {
                save(ranks: [rank], completion: completion)
            }
        }
    }
    
    // MARK: Retrieving
    // ================
    func getSettingModel(iteration: Int) -> Settings {
        if iteration == 3 { fatalError("Could not get settings") }
        
        let model = Settings(
            username: "",
            appLanguage: nil,
            autosaveRanks: false,
            maxRanks: Constants.maxRanksRange.lowerBound
        )
        
        if let decoded = UserDefaults.standard.object(forKey: CoreDataKey.settings.key) as? Data {
            do {
                let decodedSettings = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? Settings
                return decodedSettings!
            } catch { fatalError(error.localizedDescription) }
        } else {
            self.save(settings: model, reset: false)
            return self.getSettingModel(iteration: iteration + 1)
        }
    }
    
    func getGame(iteration: Int, completion: @escaping ((Game?) -> Void)) {
        guard iteration < 3 else { completion(nil); return }
        
        if let decoded = UserDefaults.standard.object(forKey: CoreDataKey.game.key) as? Data {
            do {
                let decodedGame = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? Game
                completion(decodedGame)
            } catch { completion(nil) }
        } else {
            self.getGame(iteration: iteration + 1, completion: completion)
        }
    }
    
    func getRanks(iteration: Int, completion: @escaping (([Rank]?) -> Void)) {
        guard iteration < 3 else { completion(nil); return }
        
        if let decoded = UserDefaults.standard.object(forKey: CoreDataKey.ranks.key) as? Data {
            do {
                let decodedRanks = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [Rank]
                completion(decodedRanks)
            } catch { completion(nil) }
        } else {
            self.getRanks(iteration: iteration + 1, completion: completion)
        }
    }
    
    // MARK: Deletion
    // ==============
    func deleteAllData() {
        UserDefaults.standard.removeObject(forKey: CoreDataKey.settings.key)
        UserDefaults.standard.removeObject(forKey: CoreDataKey.game.key)
        UserDefaults.standard.removeObject(forKey: CoreDataKey.ranks.key)
        self.restart()
    }
    
    func deleteSavedGame() {
        UserDefaults.standard.removeObject(forKey: CoreDataKey.game.key)
    }
    
    func deleteSavedRanks() {
        UserDefaults.standard.removeObject(forKey: CoreDataKey.ranks.key)
    }
    
    func restart() {
        AppState.shared.gameID = UUID()
    }
}
