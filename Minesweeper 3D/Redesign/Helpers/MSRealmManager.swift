//
//  MSRealmManager.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 20/9/23.
//

import Foundation
import RealmSwift

class MSRealmManaager {
    
    static let shared = MSRealmManaager()
    
    // MARK: -  Global functions
    func deleteAllData() {
        do {
            let realm = try Realm()
            let existingSettings = realm.objects(MSSettings.self)
            
            try realm.write {
                existingSettings.forEach { realm.delete($0) }
            }
        } catch {
            MSLogManager(type: .error, error: MSError(error.localizedDescription)).log()
            restart()
        }
        
        restart()
    }
    
    private func restart() {
        MSAppState.shared.gameID = UUID()
    }
    
    // MARK: - Settings functions
    func saveSettings(_ settings: MSSettings) {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.add(settings)
            }
        } catch {
            MSLogManager(type: .error, error: MSError(error.localizedDescription)).log()
        }
    }
    
    func updateSettings(_ settings: MSSettings) {
        do {
            let realm = try Realm()
            let existing = realm.objects(MSSettings.self)
            
            if existing.isEmpty {
                saveSettings(settings)
            } else {
                try realm.write {
                    existing.first?.username = settings.username
                    existing.first?.appLanguage = settings.appLanguage
                    existing.first?.autosaveRanks = settings.autosaveRanks
                    existing.first?.maxRanks = settings.maxRanks
                }
            }
            
            restart()
        } catch {
            MSLogManager(type: .error, error: MSError(error.localizedDescription)).log()
        }
    }
    
    func getSetings() -> MSSettings {
        do {
            let realm = try Realm()
            let settings = realm.objects(MSSettings.self)
            
            if let first = settings.first {
                return first
            } else {
                let empty = MSSettings.empty()
                
                self.saveSettings(empty)
                
                return empty
            }
        } catch {
            MSLogManager(type: .error, error: MSError(error.localizedDescription)).log()
        }
        
        return MSSettings.empty()
    }
}
