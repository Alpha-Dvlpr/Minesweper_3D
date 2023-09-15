//
//  MSUtils.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 12/5/21.
//

import Foundation

class MSUtils {
    static func getStringTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        
        var text: String = ""
        
        if hours != 0 { text.append("\(hours):") }
        
        if minutes < 10 { text.append("0") }
        text.append("\(minutes):")
        
        if seconds < 10 { text.append("0") }
        text.append("\(seconds)")
        
        return text
    }
    
    static func getFormattedDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateFormatter.locale = .current
        return "'\(dateFormatter.string(from: date))'"
    }
}
