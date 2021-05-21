//
//  Texts.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 09/05/2021.
//

import SwiftUI

enum Texts: String {
    case main
    case newGame
    case restartGame
    case bestMarks
    case settings
    case accept
    case cancel
    case save
    case delete
    case deleteTitle
    case deleteDisclaimer
    case username
    case language
    case autosaveRanks
    case maxRanks
    case yes
    case no
    case typeNewValue
    case currentValueDisclaimer
    case gamePaused
    case gameLost
    case gameWon
    case general
    case advanced
    case termsOfUse
    
    var localized: String {
        return self.local()
    }
    
    private func local(comment: String = "") -> String {
        let coreData = CoreDataController.shared
        var lang: String!
        
        let savedLanguage = coreData.getSettingModel(iteration: 0).appLanguage.code
        lang = savedLanguage

        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let result = NSLocalizedString(
            self.rawValue,
            tableName: "Localized",
            bundle: Bundle(path: path!)!,
            value: self.rawValue,
            comment: comment
        )
        
        return result
    }
}
