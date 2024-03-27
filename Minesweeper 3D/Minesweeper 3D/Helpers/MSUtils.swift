//
//  MSUtils.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 27/3/24.
//

import Foundation

class MSUtils {
    
    static func getStringTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        
        var text = ""
        
        if hours != 0 { text.append("\(hours):") }
        if minutes < 10 { text.append("0") }
        text.append("\(minutes):")
        
        if seconds < 10 { text.append("0") }
        text.append("\(seconds)")
        
        return text
    }
    
    static func getAppVersion() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "-"
        
        return MSTexts.version.localized(with: [ "\(version) (\(build))" ])
    }
    
    static func getAppCopyright() -> String { return "© \(Calendar.current.component(.year, from: Date())). Aarón Granado Amores." }
}
