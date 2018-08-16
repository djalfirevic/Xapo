//
//  Logger.swift
//  Xapo
//
//  Created by Djuro Alfirevic on 8/16/18.
//  Copyright © 2018 Djuro Alfirevic. All rights reserved.
//

import Foundation

enum LogType: String {
    case error = "[🛑]"
    case info = "[ℹ️]"
    case debug = "[💬]"
    case warning = "[⚠️]"
    case fatal = "[🔥]"
    case success = "[✅]"
}

class Logger {
    
    // MARK: - Properties
    static var dateFormat = "yyyy-MM-dd"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = .current
        formatter.timeZone = .current
        
        return formatter
    }
    
    // MARK: - Public API
    class func log(message: String,
                   type: LogType,
                   fileName: String = #file,
                   line: Int = #line,
                   column: Int = #column,
                   function: String = #function) {
        
        #if DEBUG
            print("\(Date().formatted()) \(type.rawValue)[\(sourceFileName(filePath: fileName))]: line: \(line), column: \(column) func: \(function) -> \(message)")
        #endif
        
        if type == .fatal {
            fatalError(message)
        }
    }
    
    // MARK: - Private API
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
}

internal extension Date {
    
    func formatted() -> String {
        return Logger.dateFormatter.string(from: self)
    }
    
}
