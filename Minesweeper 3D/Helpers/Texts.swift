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
    
    var localized: String {
        return self.local()
    }
    
    private func local(comment: String = "") -> String {
        var lang: String!
        
        if let savedLanguage = CoreDataController.shared.getLanguage() {
            lang = savedLanguage.code
        } else {
            CoreDataController.shared.saveSetting(language: .spanish(.es))
            lang = Language.spanish(.es).code
        }
        
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
