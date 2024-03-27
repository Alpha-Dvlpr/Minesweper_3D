//
//  MSLanguage.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import Foundation

class MSLanguage {
    
    var code: String = MSLanguageType.spanish.code
    var language: MSLanguageType = .spanish
    
    convenience init(type: MSLanguageType) {
        self.init()
        
        self.code = type.code
        self.language = type
    }
    
    convenience init(code: String?) {
        self.init()
        
        guard let type = MSLanguageType(code: code) else { return }
        
        self.code = type.code
        self.language = type
    }
    
    convenience init(name: String?) {
        self.init()
        
        guard let type = MSLanguageType(name: name) else { return }
        
        self.code = type.code
        self.language = type
    }
    
    convenience init(setting: String?) {
        self.init()
        
        guard let type = MSLanguageType(setting: setting) else { return }
        
        self.code = type.code
        self.language = type
    }
}
