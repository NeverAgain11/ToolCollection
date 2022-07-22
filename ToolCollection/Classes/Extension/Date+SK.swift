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
    
    @objc static func posixString(from date: Date, dateFormat: String) -> String {
        if let f = formatterDict[dateFormat] {
            return f.string(from: date)
        }
        let f = DateFormatter().then {
            $0.locale = Locale(identifier: "en_US_POSIX")
            $0.dateFormat = dateFormat
        }
        formatterDict[dateFormat] = f
        
        return f.string(from: date)
    }
    
}
