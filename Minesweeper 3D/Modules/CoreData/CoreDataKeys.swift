//
//  CoreDataKeys.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 12/05/2021.
//

import Foundation

enum SettingKey: String, CaseIterable {
    case username
    case language
    case autosaveRanks
    case maxNumberOfRanks
    
    var title: String {
        switch self {
        case .username: return Texts.username.localized
        case .language: return Texts.language.localized
        case .autosaveRanks: return Texts.autosaveRanks.localized
        case .maxNumberOfRanks: return Texts.maxRanks.localized
        }
    }
    
    var id: Int {
        switch self {
        case .username: return 1
        case .language: return 2
        case .autosaveRanks: return 3
        case .maxNumberOfRanks: return 4
        }
    }
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
