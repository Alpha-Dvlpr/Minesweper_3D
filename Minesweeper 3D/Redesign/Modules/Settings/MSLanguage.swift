//
//  MSLanguage.swift
//  Minesweeper 3D
//
//  Created by Aaron Granado Amores on 10/05/2021.
//

import Foundation
import RealmSwift

enum MSLanguageDescriptions: String {
    case ms_es_code = "es"
    case ms_es_name = "Español"
    case ms_es_setting = "spanish"
    
    case ms_ca_code = "ca-ES"
    case ms_ca_name = "Català"
    case ms_ca_setting = "catalan"
    
    case ms_en_code = "en"
    case ms_en_name = "English"
    case ms_en_setting = "english"
    
    case ms_fr_code = "fr"
    case ms_fr_name = "Français"
    case ms_fr_setting = "french"
}

enum MSLanguageType: CaseIterable, Identifiable {
    
    // MARK: - Variables
    enum MSSpanish: String {
        case es
        case ca
    }
    
    case spanish(MSSpanish)
    case english
    case french
    
    // MARK: - Protocols
    static let allCases: [MSLanguageType] = [ .spanish(.es), .spanish(.ca), .english, .french ]
    
    // MARK: - Variables
    var id: String { return code }
    
    var code: String {
        switch self {
        case .spanish(let spanish):
            switch spanish {
            case .es: return MSLanguageDescriptions.ms_es_code.rawValue
            case .ca: return MSLanguageDescriptions.ms_ca_code.rawValue
            }
        case .english: return MSLanguageDescriptions.ms_en_code.rawValue
        case .french: return MSLanguageDescriptions.ms_fr_code.rawValue
        }
    }
    
    var name: String {
        switch self {
        case .spanish(let spanish):
            switch spanish {
            case .es: return MSLanguageDescriptions.ms_es_name.rawValue
            case .ca: return MSLanguageDescriptions.ms_ca_name.rawValue
            }
        case .english: return MSLanguageDescriptions.ms_en_name.rawValue
        case .french: return MSLanguageDescriptions.ms_fr_name.rawValue
        }
    }
    
    var setting: String {
        switch self {
        case .spanish(let spanish):
            switch spanish {
            case .es: return MSLanguageDescriptions.ms_es_setting.rawValue
            case .ca: return MSLanguageDescriptions.ms_ca_setting.rawValue
            }
        case .english: return MSLanguageDescriptions.ms_en_setting.rawValue
        case .french: return MSLanguageDescriptions.ms_fr_setting.rawValue
        }
    }
    
    // MARK: - Inits
    init?(languageCode: String?) {
        guard let languageCode = languageCode else { return nil }
        
        switch languageCode {
        case MSLanguageDescriptions.ms_es_code.rawValue: self = .spanish(.es)
        case MSLanguageDescriptions.ms_ca_code.rawValue: self = .spanish(.ca)
        case MSLanguageDescriptions.ms_en_code.rawValue: self = .english
        case MSLanguageDescriptions.ms_fr_code.rawValue: self = .french
        default: return nil
        }
    }
    
    init?(languageName: String?) {
        guard let languageName = languageName else { return nil }
        
        switch languageName {
        case MSLanguageDescriptions.ms_es_name.rawValue: self = .spanish(.es)
        case MSLanguageDescriptions.ms_ca_name.rawValue: self = .spanish(.ca)
        case MSLanguageDescriptions.ms_en_name.rawValue: self = .english
        case MSLanguageDescriptions.ms_fr_name.rawValue: self = .french
        default: return nil
        }
    }
    
    init?(languageSetting: String?) {
        guard let languageSetting = languageSetting else { return nil }
        
        switch languageSetting {
        case MSLanguageDescriptions.ms_es_setting.rawValue: self = .spanish(.es)
        case MSLanguageDescriptions.ms_ca_setting.rawValue: self = .spanish(.ca)
        case MSLanguageDescriptions.ms_en_setting.rawValue: self = .english
        case MSLanguageDescriptions.ms_fr_setting.rawValue: self = .french
        default: return nil
        }
    }
}

class MSLanguage: Object, ObjectKeyIdentifiable {
    
    // MARK: - Variables
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var code: String = MSLanguageType.spanish(.es).code
    var language: MSLanguageType = MSLanguageType.spanish(.es)
    
    // MARK: - Inits
    convenience init(type: MSLanguageType) {
        self.init()
        
        self.code = type.code
        self.language = type
    }
    
    convenience init(code: String?) {
        self.init()
        
        guard let type = MSLanguageType(languageCode: code) else { return }
        
        self.code = type.code
        self.language = type
    }
    
    convenience init(name: String?) {
        self.init()
        
        guard let type = MSLanguageType(languageName: name) else { return }
        
        self.code = type.code
        self.language = type
    }
    
    convenience init(setting: String?) {
        self.init()
        
        guard let type = MSLanguageType(languageSetting: setting) else { return }
        
        self.code = type.code
        self.language = type
    }
}
