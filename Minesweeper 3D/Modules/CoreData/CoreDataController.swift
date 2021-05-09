//
//  CoreDataController.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import Foundation

enum SettingKey: String {
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
        case .ranks: return "ranks"
        }
    }
}

class CoreDataController {
    static let shared = CoreDataController()
    
    func save(value: Any, for key: CoreDataKey) {
        
    }
    
    func getValkue(for key: CoreDataKey) -> Any {
        return 6
    }
    
    func deleteAllData() {
        
    }
}
