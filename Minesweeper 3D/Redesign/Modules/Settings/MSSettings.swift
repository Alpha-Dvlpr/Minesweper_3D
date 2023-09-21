//
//  MSSettings.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 21/05/2021.
//

import Foundation
import RealmSwift

class MSSettings: Object, ObjectKeyIdentifiable {
    
    // MARK: - Variables
    enum MSMissingData {
        case invalidName
    }
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var username: String
    @Persisted var appLanguage: String
    @Persisted var autosaveRanks: Bool
    @Persisted var maxRanks: Int
    
    // MARK: - Init
    convenience init(username: String, appLanguage: String, autosaveRanks: Bool, maxRanks: Int) {
        self.init()
        
        self.username = username
        self.appLanguage = appLanguage
        self.autosaveRanks = autosaveRanks
        self.maxRanks = maxRanks
    }
    
    // MARK: - Functions
    func getMissingData() -> Int? {
        var missing: [MSMissingData] = []
        
        if !isNameValid() { missing.append(.invalidName) }
        
        return missing.isEmpty ? nil : missing.count
    }
    
    static func ==(lhs: MSSettings, rhs: MSSettings) -> Bool {
        return lhs.username == rhs.username
            && lhs.appLanguage == rhs.appLanguage
            && lhs.autosaveRanks == rhs.autosaveRanks
            && lhs.maxRanks == rhs.maxRanks
    }
    
    static func empty() -> MSSettings {
        return MSSettings(
            username: "",
            appLanguage: MSLanguage(type: .spanish(.es)).code,
            autosaveRanks: false,
            maxRanks: MSConstants.maxRanksRange.lowerBound
        )
    }
    
    // MARK: - Data validation
    func isNameValid() -> Bool { return username.count > 5 }
}
