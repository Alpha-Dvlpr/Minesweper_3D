//
//  MSRealmManager.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import Foundation
import RealmSwift

class MSRealmManager {
    
    static let shared = MSRealmManager()
    
    // MARK: - Settings
    func getSettings() -> RealmSettings {
        do {
            let realm = try Realm()
            let settings = realm.objects(RealmSettings.self)
            
            if let first = settings.first {
                return first
            } else {
                let empty = RealmSettings.empty()
                
                self.saveSettings(empty)
                
                return empty
            }
        } catch {
            MSLogManager.shared.log(type: .error(error: MSError(error.localizedDescription)))
        }
        
        return RealmSettings.empty()
    }
    
    func saveSettings(_ settings: RealmSettings) {
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.add(settings)
            }
        } catch {
            MSLogManager.shared.log(type: .error(error: MSError(error.localizedDescription)))
        }
    }
    
    func updateSettings(_ settings: RealmSettings) {
        do {
            let realm = try Realm()
            let existing = realm.objects(RealmSettings.self)
            
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
            
            MSAppState.shared.restart()
        } catch {
            MSLogManager.shared.log(type: .error(error: MSError(error.localizedDescription)))
        }
    }
    
    // MARK: - General
    func deleteAllData() {
        do {
            let realm = try Realm()
            let existingSettings = realm.objects(RealmSettings.self)
            
            try realm.write {
                existingSettings.forEach { realm.delete($0) }
            }
        } catch {
            MSLogManager.shared.log(type: .error(error: MSError(error.localizedDescription)))
            MSAppState.shared.restart()
        }
        
        MSAppState.shared.restart()
    }
}
