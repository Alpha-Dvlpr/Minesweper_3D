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
        let code = aDecoder.decodeObject(forKey: "language") as? String
        let lang = Language(languageSetting: code) ?? .spanish(.es)
        
        self.username = aDecoder.decodeObject(forKey: "username") as? String ?? ""
        self.appLanguage = lang
        self.autosaveRanks = aDecoder.decodeBool(forKey: "autosaveRanks")
        self.maxRanks = aDecoder.decodeInteger(forKey: "maxRanks")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.username, forKey: "username")
        aCoder.encode(self.appLanguage.setting, forKey: "language")
        aCoder.encode(self.autosaveRanks, forKey: "autosaveRanks")
        aCoder.encode(self.maxRanks, forKey: "maxRanks")
    }
    
    func equals(settings: Settings) -> Bool {
        return self.username == settings.username
            && self.appLanguage.code == settings.appLanguage.code
            && self.autosaveRanks == settings.autosaveRanks
            && self.maxRanks == settings.maxRanks
    }
}
