//
//  MSSettings.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import Foundation
import RealmSwift

class MSSettings: Object, ObjectKeyIdentifiable {
    
    enum MSMissingData {
        case invalidName
    }
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var username: String
    @Persisted var appLanguage: String
    @Persisted var autosaveRanks: Bool
    @Persisted var maxRanks: Int
    
    convenience init(username: String, appLanguage:  String, autosaveranks: Bool, maxRanks: Int) {
        self.init()
        
        self.username = username
        self.appLanguage = appLanguage
        self.autosaveRanks = autosaveranks
        self.maxRanks = maxRanks
    }
    
    func getMissingData() -> Int {
        var missing: [MSMissingData] = []
        
        if !isValidName() { missing.append(.invalidName) }
        
        return missing.count
    }
    
    func isValidName() -> Bool { return username.count > 5 }
    
    static func == (lhs: MSSettings, rhs: MSSettings) -> Bool {
        return lhs.username == rhs.username
            && lhs.appLanguage == rhs.appLanguage
            && lhs.autosaveRanks == rhs.autosaveRanks
            && lhs.maxRanks == rhs.maxRanks
    }
    
    static func empty() -> MSSettings {
        return MSSettings(
            username: "",
            appLanguage: MSLanguage(type: .spanish).code,
            autosaveranks: false,
            maxRanks: MSConstants.maxRanksRange.lowerBound
        )
    }
}
