//
//  String.swift
//  Template
//
//  Created by ljk on 2019/5/5.
//  Copyright © 2019 flow. All rights reserved.
//

import Foundation

public extension String {
    
    /**
     Generates a unique string that can be used as a filename for storing data objects that need to ensure they have a unique filename. It is guranteed to be unique.
     
     - parameter prefix: The prefix of the filename that will be added to every generated string.
     - returns: A string that will consists of a prefix (if available) and a generated unique string.
     */
    static func uniqueFilename() -> String {
        let uniqueString = ProcessInfo.processInfo.globallyUniqueString
        return uniqueString
    }
    
    var modificationTimestamp: Int? {
        var stat1 = stat()
        if stat((self as NSString).fileSystemRepresentation, &stat1) != 0 {
            return nil
        } else {
            return stat1.st_ctimespec.tv_sec
        }
    }
    
    var creationTimestamp: Int? {
        var stat1 = stat()
        if stat((self as NSString).fileSystemRepresentation, &stat1) != 0 {
            return nil
        } else {
            return stat1.st_birthtimespec.tv_sec
        }
    }
    
    // 格式化： 调用 ByteCountFormatter.string(fromByteCount: size, countStyle: .decimal)
    /// 文件大小 Byte
    var size: Int64? {
        var stat1 = stat()
        if stat((self as NSString).fileSystemRepresentation, &stat1) != 0 {
            return nil
        } else {
            return stat1.st_size
        }
    }
    
    func width(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return ceil(boundingBox.width)
    }
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(
            with: constraintRect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        return ceil(boundingBox.height)
    }
    
    func containsChinese() -> Bool {
        for (_, value) in self.enumerated() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    func firstLetterIsChinese() -> Bool {
        for (_, value) in self.enumerated() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func transformToPinyin() -> String {
        let stringRef = NSMutableString(string: self) as CFMutableString
        // 转换为带音标的拼音
        CFStringTransform(stringRef, nil, kCFStringTransformToLatin, false)
        // 去掉音标
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false)
        let pinyin = stringRef as String
        return pinyin
    }
}

