//
//  Settings.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 21/05/2021.
//

import Foundation

class Settings: NSObject, NSCoding {
    var username: String
    var appLanguage: Language
    var autosaveRanks: Bool
    var maxRanks: Int
    var invalidData: Bool { return self.username.isEmpty || self.username.count < 5 }
    
    init(
        username: String,
        appLanguage: Language?,
        autosaveRanks: Bool,
        maxRanks: Int
    ) {
        self.username = username
        self.appLanguage = appLanguage ?? .spanish(.es)
        self.autosaveRanks = autosaveRanks
        self.maxRanks = maxRanks
    }
    
    required init(coder aDecoder: NSCoder) {
        let code = aDecoder.decodeObject(forKey: CoreDataKey.appLanguage.key) as? String
        
        self.username = aDecoder.decodeObject(forKey: CoreDataKey.username.key) as? String ?? ""
        self.appLanguage = Language(languageSetting: code) ?? .spanish(.es)
        self.autosaveRanks = aDecoder.decodeBool(forKey: CoreDataKey.autoSaveRanks.key)
        self.maxRanks = aDecoder.decodeInteger(forKey: CoreDataKey.maxNumberOfRanks.key)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.username, forKey: CoreDataKey.username.key)
        aCoder.encode(self.appLanguage.setting, forKey: CoreDataKey.appLanguage.key)
        aCoder.encode(self.autosaveRanks, forKey: CoreDataKey.autoSaveRanks.key)
        aCoder.encode(self.maxRanks, forKey: CoreDataKey.maxNumberOfRanks.key)
    }
    
    func equals(settings: Settings) -> Bool {
        return self.username == settings.username
            && self.appLanguage.code == settings.appLanguage.code
            && self.autosaveRanks == settings.autosaveRanks
            && self.maxRanks == settings.maxRanks
    }
}
