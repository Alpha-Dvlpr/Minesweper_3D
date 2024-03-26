//
//  MSLogger.swift
//  Minesweeper 3D
//
//  Created by Aarón Granado Amores on 26/3/24.
//

import Foundation

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

enum MSLogType {
    
    case error(error: MSError)
    case info(info: String)
    case warning(info: String)
    case severe(info: String)
    
    var rawValue: String {
        switch self {
        case .error:
            return "[‼️]"
        case .info:
            return "[ℹ️]"
        case .warning:
            return "[⚠️]"
        case .severe:
            return "[🔥]"
        }
    }
    
    var message: String {
        switch self {
        case .error(let error):
            return error.message
        case .info(let info), .warning(let info), .severe(let info):
            return info
        }
    }
}

class MSLogManager {
    
    static let shared = MSLogManager()
    
    private var isLoggingEnabled: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    func log(type: MSLogType) {
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm:ss"
            formatter.locale = Locale.current
            formatter.timeZone = TimeZone.current
            return formatter
        }
        
        print("\(type.rawValue) LogManager: \(dateFormatter.string(from: Date())) \(type.message)")
    }
}
