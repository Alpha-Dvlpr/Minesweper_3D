//
//  MSSettings.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import Foundation

struct MSSettings: Identifiable, Hashable {
    
    enum MSMissingData {
        case invalidName
    }
    
    var id = UUID()
    var username: String = ""
    var appLanguage: String = MSLanguage(type: .spanish).code
    var autosaveRanks: Bool = false
    var maxRanks: Int = MSConstants.maxRanksRange.lowerBound
    
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
}
