//
//  Date+SK.swift
//  ToolCollection
//
//  Created by ryeex on 2022/7/22.
//

import Foundation

public extension Date {
    
    
    
}

public extension DateFormatter {
    
    static private var formatterDict = [String: DateFormatter]()
    
    static func formatter(_ dateFormat: String) -> DateFormatter {
        if let f = formatterDict[dateFormat] {
            return f
        }
        let f = DateFormatter().then {
            $0.locale = Locale(identifier: "en_US_POSIX")
            $0.dateFormat = dateFormat
        }
        formatterDict[dateFormat] = f
        return f
    }
    
    @objc static func posixString(from date: Date, dateFormat: String) -> String {
        return formatter(dateFormat).string(from: date)
    }
    
    @objc static func posixDate(from string: String, dateFormat: String) -> Date? {
        let date = formatter(dateFormat).date(from: string)
        return date
    }
    
}
