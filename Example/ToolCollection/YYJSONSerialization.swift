//
//  YYJSONSerialization.swift
//  ToolCollection_Example
//
//  Created by Summer on 2021/12/2.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import yyjson

private struct YYJsonType: OptionSet {
    
    let rawValue: UInt8
    
    init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
    
    static let NONE = UInt8(0)        /* _____000 */
    static let NULL = UInt8(2)        /* _____010 */
    static let BOOL = UInt8(3)        /* _____011 */
    static let NUM = UInt8(4)        /* _____100 */
    static let STR = UInt8(5)        /* _____101 */
    static let ARR = UInt8(6)        /* _____110 */
    static let OBJ = UInt8(7)        /* _____111 */
}

private struct YYJsonSubType: OptionSet {
    
    let rawValue: UInt8
    
    init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
    
    static let NONE = UInt8(0 << 3) /* ___00___ */
    static let FALSE = UInt8(0 << 3) /* ___00___ */
    static let TRUE = UInt8(1 << 3) /* ___01___ */
    static let UINT = UInt8(0 << 3) /* ___00___ */
    static let SINT = UInt8(1 << 3) /* ___01___ */
    static let REAL = UInt8(2 << 3) /* ___10___ */
}

private extension Data {
    
    func getBytes<T>() -> UnsafePointer<T>? {
        withUnsafeBytes { (ptr: UnsafeRawBufferPointer) in
            ptr.baseAddress?.assumingMemoryBound(to: T.self)
        }
    }
}

@objc public class YYJSONSerialization: NSObject {
    
    @objc public class func jsonObject(with data: Data, allowComments: Bool = false) -> Any? {
        let flags: UInt32 = allowComments ? YYJSON_READ_ALLOW_COMMENTS | YYJSON_READ_ALLOW_TRAILING_COMMAS : 0
        let doc = yyjson_read(data.getBytes(), data.count, flags)
        guard doc != nil else {
            return nil
        }
        
        defer {
            yyjson_doc_free(doc)
        }
        
        let root = yyjson_doc_get_root(doc)
        guard let obj = root else {
            return nil
        }
        
        return yyjson(obj: obj)
    }
    
    private class func yyjson(obj: UnsafeMutablePointer<yyjson_val>) -> Any? {
        let type = yyjson_get_type(obj)
        let subType = yyjson_get_subtype(obj)
        
        if type == YYJsonType.NULL {
            return nil
        }
        
        if type == YYJsonType.STR {
            return String(cString: yyjson_get_str(obj))
        }
        
        if type == YYJsonType.BOOL {
            return subType & YYJsonSubType.TRUE > 0 ? true : false
        }
        
        if type == YYJsonType.NUM {
            if subType & YYJsonSubType.REAL > 0 {
                return yyjson_get_real(obj)
            }
            
            return subType & YYJsonSubType.SINT > 0 ? yyjson_get_sint(obj) : yyjson_get_uint(obj)
        }
        
        if type == YYJsonType.ARR {
            var array = [Any]()
            let count = yyjson_arr_size(obj)
            for i in 0..<count {
                if let obj = yyjson(obj: yyjson_arr_get(obj, i)) {
                    array.append(obj)
                }
            }
            
            return array
        }
        
        var dictionary = [String: Any]()
        
        var iter = yyjson_obj_iter()
        yyjson_obj_iter_init(obj, &iter)
        
        while let key = yyjson_obj_iter_next(&iter) {
            let val = yyjson_obj_iter_get_val(key)
            let keyStr = String(cString: yyjson_get_str(key))
            
            if let val = val, let obj = yyjson(obj: val) {
                dictionary[keyStr] = obj
            }
        }
        
        return dictionary
    }
}
