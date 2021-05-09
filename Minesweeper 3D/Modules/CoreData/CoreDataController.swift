//
//  CoreDataController.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import Foundation

enum SettingKey: String, CaseIterable {
    case username
    case language
    case autosaveRanks
    case maxNumberOfRanks
}

enum CoreDataKey {
    case settings(key: SettingKey)
    case ranks
    
    var key: String {
        switch self {
        case .settings(let key): return key.rawValue
        default: return "\(self)"
        }
    }
}

class CoreDataController {
    static let shared = CoreDataController()
    
    func save(value: Any, for key: CoreDataKey) {
        
    }
    
    func getValkue(for key: CoreDataKey) -> Any {
        switch key {
        case .settings(key: let innerKey):
            var model = SettingsModel()
            model.key = innerKey
            
            switch innerKey {
            case .username:
                model.title = Texts.username.localized
                model.value = "Alpha Dvlpr"
            case .language:
                model.title = Texts.language.localized
                model.value = "es"
            case .autosaveRanks:
                model.title = Texts.autosaveRanks.localized
                model.value = true
            case .maxNumberOfRanks:
                model.title = Texts.maxRanks.localized
                model.value = 15
            }
            
            return model
        case .ranks: return "all ranks saved: ^_^"
        }
    }
    
    func deleteAllData() {
        
    }
}
