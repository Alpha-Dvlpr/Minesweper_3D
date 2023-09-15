//
//  MSSettings.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 21/05/2021.
//

import Foundation

enum MSMissingData {
    case invalidName
}

class MSSettings: NSObject, NSCoding {
    var username: String
    var appLanguage: MSLanguage
    var autosaveRanks: Bool
    var maxRanks: Int
    
    init(
        username: String,
        appLanguage: MSLanguage?,
        autosaveRanks: Bool,
        maxRanks: Int
    ) {
        self.username = username
        self.appLanguage = appLanguage ?? .spanish(.es)
        self.autosaveRanks = autosaveRanks
        self.maxRanks = maxRanks
    }
    
    required init(coder aDecoder: NSCoder) {
        let code = aDecoder.decodeObject(forKey: MSCoreDataKey.appLanguage.key) as? String
        let ranks = aDecoder.decodeInteger(forKey: MSCoreDataKey.maxNumberOfRanks.key)
        let lowerBound = MSConstants.maxRanksRange.lowerBound
        
        username = aDecoder.decodeObject(forKey: MSCoreDataKey.username.key) as? String ?? ""
        appLanguage = MSLanguage(languageSetting: code) ?? .spanish(.es)
        autosaveRanks = aDecoder.decodeBool(forKey: MSCoreDataKey.autoSaveRanks.key)
        maxRanks = ranks < lowerBound ? lowerBound : ranks
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(username, forKey: MSCoreDataKey.username.key)
        aCoder.encode(appLanguage.setting, forKey: MSCoreDataKey.appLanguage.key)
        aCoder.encode(autosaveRanks, forKey: MSCoreDataKey.autoSaveRanks.key)
        aCoder.encode(maxRanks, forKey: MSCoreDataKey.maxNumberOfRanks.key)
    }
    
    func equals(settings: MSSettings) -> Bool {
        return username == settings.username
            && appLanguage.code == settings.appLanguage.code
            && autosaveRanks == settings.autosaveRanks
            && maxRanks == settings.maxRanks
    }
    
    func getMissingData() -> Int? {
        var missing: [MSMissingData] = []
        
        if username.isEmpty || username.count < 5 { missing.append(.invalidName) }
        
        return missing.isEmpty ? nil : missing.count
    }
}
