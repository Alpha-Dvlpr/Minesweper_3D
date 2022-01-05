//
//  Language.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 10/05/2021.
//

import Foundation

enum Language: Equatable, Identifiable, CaseIterable, Hashable {
    
    // MARK: Protocols stuff
    // =====================
    static var allCases: [Language] { return [.spanish(.es), .spanish(.ca), .english, .french] }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.code)
        hasher.combine(self.name)
        hasher.combine(self.setting)
    }
    
    enum Spanish {
        case es
        case ca
    }
    
    // MARK: Types
    // ===========
    case spanish(Spanish)
    case english
    case french
    
    // MARK: Variables
    // ===============
    var code: String {
        switch self {
        case .spanish(let spanish):
            switch spanish {
            case .es: return "es"
            case .ca: return "ca-ES"
            }
        case .english: return "en"
        case .french: return "fr"
        }
    }
    
    var name: String {
        switch self {
        case .spanish(let spanish):
            switch spanish {
            case .es: return "Español"
            case .ca: return "Català"
            }
        case .english: return "English"
        case .french: return "Français"
        }
    }
    
    var setting: String {
        switch self {
        case .spanish(let spanish):
            switch spanish {
            case .es: return "spanish"
            case .ca: return "catalan"
            }
        case .english: return "english"
        case .french: return "french"
        }
    }
    
    var id: String { self.code }
    
    // MARK: Inits
    // ===========
    init?(languageCode: String?) {
        guard let languageCode = languageCode else { return nil }
        switch languageCode {
        case "es": self = .spanish(.es)
        case "ca-ES": self = .spanish(.ca)
        case "en": self = .english
        case "fr": self = .french
        default: return nil
        }
    }
    
    init?(languageSetting: String?) {
        guard let languageSetting = languageSetting else { return nil }
        switch languageSetting {
        case "spanish": self = .spanish(.es)
        case "catalan": self = .spanish(.ca)
        case "english": self = .english
        case "french": self = .french
        default: return nil
        }
    }
}
