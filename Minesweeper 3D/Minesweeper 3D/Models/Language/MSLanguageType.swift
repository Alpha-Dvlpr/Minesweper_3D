//
//  MSLanguageType.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import Foundation

enum MSLanguageType: CaseIterable, Identifiable {
    
    case spanish
    
    var id: String { return code }
    
    var code: String {
        switch self {
        case .spanish: return MSLanguageDescription.ms_es_code.rawValue
        }
    }
    
    var name: String {
        switch self {
        case .spanish: return MSLanguageDescription.ms_es_name.rawValue
        }
    }
    
    var setting: String {
        switch self {
        case .spanish: return MSLanguageDescription.ms_es_setting.rawValue
        }
    }
    
    init?(code: String?) {
        guard let code else { return nil }
        
        switch code {
        case MSLanguageDescription.ms_es_code.rawValue: self = .spanish
        default: return nil
        }
    }
    
    init?(name: String?) {
        guard let name else { return nil }
        
        switch name {
        case MSLanguageDescription.ms_es_name.rawValue: self = .spanish
        default: return nil
        }
    }
    
    init?(setting: String?) {
        guard let setting else { return nil }
        
        switch setting {
        case MSLanguageDescription.ms_es_setting.rawValue: self = .spanish
        default: return nil
        }
    }
}
