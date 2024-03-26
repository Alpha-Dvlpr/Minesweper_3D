//
//  MSTexts.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import SwiftUI

enum MSTexts: String {
    
    case advanced
    case autosaveRanks
    case bestMarks
    case cancel
    case close
    case delete
    case deleteDisclaimer
    case deleteTitle
    case deleteRanksDisclaimer
    case deleteRanksTitle
    case errorSavingGame
    case finishGame
    case finishGameDisclaimer
    case gameLost
    case gamePaused
    case gameWon
    case general
    case generatingGame
    case info
    case language
    case main
    case maxRanks
    case menu
    case moreInfo
    case newGame
    case no
    case options
    case restartGame
    case resumeGame
    case save
    case settings
    case shop
    case username
    case version
    case yes
    
    var localized: String {
        return local()
    }
    
    var localizedText: Text {
        return Text(local())
    }
    
    func localized(with parameters: [String]) -> String {
        return String.init(format: local(), arguments: parameters)
    }
    
    func localizedText(with parameters: [String]) -> Text {
        return Text(String.init(format: local(), arguments: parameters))
    }
    
    private func local(comment: String = "") -> String {
        let realm = MSRealmManager.shared
        let lang: String = realm.getSettings().appLanguage
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let result = NSLocalizedString(
            self.rawValue,
            tableName: "Localizable",
            bundle: Bundle(path: path!)!,
            value: self.rawValue,
            comment: comment
        )
        
        return result
    }
}
