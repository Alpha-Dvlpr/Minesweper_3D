//
//  RealmSettings.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 27/3/24.
//

import Foundation
import RealmSwift

class RealmSettings: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var username: String
    @Persisted var appLanguage: String
    @Persisted var autosaveRanks: Bool
    @Persisted var maxRanks: Int
    
    convenience init(username: String, appLanguage:  String, autosaveRanks: Bool, maxRanks: Int) {
        self.init()
        
        self.username = username
        self.appLanguage = appLanguage
        self.autosaveRanks = autosaveRanks
        self.maxRanks = maxRanks
    }
    
    convenience init(settings: MSSettings) {
        self.init()
        
        username = settings.username
        appLanguage = settings.appLanguage
        autosaveRanks = settings.autosaveRanks
        maxRanks = settings.maxRanks
    }
    
    static func empty() -> RealmSettings { return RealmSettings(settings: MSSettings()) }
}
