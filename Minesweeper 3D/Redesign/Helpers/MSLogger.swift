//
//  MSLogger.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 20/9/23.
//

import Foundation


enum MSLogType: String {
    case error = "[‼️]"
    case info = "[ℹ️]"
    case warning = "[⚠️]"
    case severe = "[🔥]"
}

enum MSErrorKey: String {
    case general = "error_general"
    case parsing = "error_parsing"
}

class MSError: Error {
    
    private var messageKey: MSErrorKey?
    private var customMessage: String = ""
    var message: String { return messageKey?.rawValue ?? customMessage }
    
    init(_ key: MSErrorKey) { messageKey = key }
    init(_ message: String) { customMessage = message }
    
    class func generalError() -> MSError { return MSError(.general) }
}

class MSLogManager {
    
    private var isLoggingEnabled: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    var type: MSLogType
    var error: MSError
    
    init(type: MSLogType, error: MSError) {
        self.type = type
        self.error = error
    }
    
    func log() {
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm:ss"
            formatter.locale = Locale.current
            formatter.timeZone = TimeZone.current
            return formatter
        }
        
        print("\(type.rawValue) LogManager: \(dateFormatter.string(from: Date())) \(error.message)")
    }
}

