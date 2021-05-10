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

class CoreDataController {
    static let shared = CoreDataController()
    
    // MARK: Saving
    // ============
    func saveSetting(bool: Bool, for key: SettingKey) {
        self.saveToCoreData(value: bool, for: .settings(key: key))
    }
    
    func saveSetting(string: String, for key: SettingKey) {
        self.saveToCoreData(value: string, for: .settings(key: key))
    }
    
    func saveSetting(integer: Int, for key: SettingKey) {
        self.saveToCoreData(value: integer, for: .settings(key: key))
    }
    
    func saveSetting(language: Language) {
        self.saveToCoreData(value: language.setting, for: .settings(key: .language))
    }
    
    private func saveToCoreData(value: Any, for key: CoreDataKey) {
        UserDefaults.standard.setValue(value, forKey: key.key)
    }
    
    // MARK: Retrieving
    // ================
    func getLanguage() -> Language? {
        let savedLanguageCode = UserDefaults.standard.string(forKey: SettingKey.language.rawValue)
        return Language.init(languageSetting: savedLanguageCode)
    }
    
    func getSettingModel(for settingKey: SettingKey) -> SettingsModel {
        let value = UserDefaults.standard.value(forKey: settingKey.rawValue)
        var model = SettingsModel()
        model.key = settingKey
        
        switch settingKey {
        case .username: model.value = value as? String ?? ""
        case .language: model.value = Language.init(languageSetting: value as? String) ?? .spanish(.es)
        case .autosaveRanks: model.value = value as? Bool ?? false
        case .maxNumberOfRanks: model.value = value as? Int ?? 15
        }

        return model
    }
    
    func getRanks(for value: Any?) -> String {
        guard let stringValue = value as? String else { return "" }
        return stringValue
    }
    
    // MARK: Deletion
    // ==============
    func deleteAllData() {
        SettingKey.allCases.forEach { UserDefaults.standard.removeObject(forKey: $0.rawValue) }
        UserDefaults.standard.removeSuite(named: CoreDataKey.ranks.key)
    }
}
