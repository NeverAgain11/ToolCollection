//
//  Preference.swift
//  Example
//
//  Created by ljk on 2019/5/31.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import MMKV
import CleanJSON

@propertyWrapper
public class OptionalMMKVProperty<T: Codable> {
    let key: String
    let defaultValue: T?
    let mmkv: MMKV
    
    public init(key: String, defaultValue: T? = nil, mmkvID: String? = nil) {
        self.key = key
        self.defaultValue = defaultValue
        
        self.mmkv = MMKV.customMMKV(mmkvID: mmkvID)
    }
    
    public var wrappedValue: T? {
        get {
            switch T.self {
            case is String.Type:
                return self.mmkv.string(forKey: self.key, defaultValue:self.defaultValue as? String) as? T
            case is Data.Type:
                return self.mmkv.data(forKey: self.key, defaultValue:self.defaultValue as? Data) as? T
            case is Date.Type:
                return self.mmkv.date(forKey: self.key, defaultValue:self.defaultValue as? Date) as? T
            case is Bool.Type:
                return self.mmkv.bool(forKey: self.key, defaultValue: ((self.defaultValue as? Bool) ?? false)) as? T
            case is Int32.Type:
                return self.mmkv.int32(forKey: self.key, defaultValue: ((self.defaultValue as? Int32) ?? 0)) as? T
            case is UInt32.Type:
                return self.mmkv.uint32(forKey: self.key, defaultValue: ((self.defaultValue as? UInt32) ?? 0)) as? T
            case is Int.Type:
                return Int(self.mmkv.int64(forKey: self.key, defaultValue: Int64((self.defaultValue as? Int) ?? 0))) as? T
            case is Int64.Type:
                return self.mmkv.int64(forKey: self.key, defaultValue: ((self.defaultValue as? Int64) ?? 0)) as? T
            case is UInt64.Type:
                return self.mmkv.uint64(forKey: self.key, defaultValue: ((self.defaultValue as? UInt64) ?? 0)) as? T
            case is Float.Type:
                return self.mmkv.float(forKey: self.key, defaultValue: ((self.defaultValue as? Float) ?? 0)) as? T
            case is Double.Type:
                return self.mmkv.double(forKey: self.key, defaultValue: ((self.defaultValue as? Double) ?? 0)) as? T
            default:
                if let object = mmkv.object(forKey: key, as: T.self) {
                    return object
                }
                return defaultValue;
            }
        }
        set {
            //self.mmkv.set(newValue, forKey: self.key)
            switch newValue {
            case let str as NSString?:
                self.mmkv.set(str, forKey: self.key)
            case let data as NSData?:
                self.mmkv.set(data, forKey: self.key)
            case let date as NSDate?:
                self.mmkv.set(date, forKey: self.key)
            case let bool as Bool:
                self.mmkv.set(bool, forKey: self.key)
            case let int as Int32:
                self.mmkv.set(int, forKey: self.key)
            case let uint as UInt32:
                self.mmkv.set(uint, forKey: self.key)
            case let int64 as Int64:
                self.mmkv.set(int64, forKey: self.key)
            case let int as Int:
                self.mmkv.set(Int64(int), forKey: self.key)
            case let uint64 as UInt64:
                self.mmkv.set(uint64, forKey: self.key)
            case let float as Float:
                self.mmkv.set(float, forKey: self.key)
            case let double as Double:
                self.mmkv.set(double, forKey: self.key)
            case let uint64 as UInt64:
                self.mmkv.set(uint64, forKey: self.key)
            default:
                self.mmkv.setObject(newValue, forKey: key)
            }
        }
    }
}

@propertyWrapper
public class MMKVProperty<T: Codable> {
    
    let key: String
    let defaultValue: T
    let mmkv: MMKV
    
    public init(key: String, defaultValue: T, mmkvID: String? = nil) {
        self.key = key
        self.defaultValue = defaultValue
        
        self.mmkv = MMKV.customMMKV(mmkvID: mmkvID)
    }
    
    public var wrappedValue: T {
        get {
            switch T.self {
            case is String.Type:
                return self.mmkv.string(forKey: self.key, defaultValue:(self.defaultValue as! String)) as! T
            case is Data.Type:
                return self.mmkv.data(forKey: self.key, defaultValue:(self.defaultValue as! Data)) as! T
            case is Date.Type:
                return self.mmkv.date(forKey: self.key, defaultValue:(self.defaultValue as! Date)) as! T
            case is Bool.Type:
                return self.mmkv.bool(forKey: self.key, defaultValue: self.defaultValue as! Bool) as! T
            case is Int32.Type:
                return self.mmkv.int32(forKey: self.key, defaultValue: self.defaultValue as! Int32) as! T
            case is UInt32.Type:
                return self.mmkv.uint32(forKey: self.key, defaultValue: self.defaultValue as! UInt32) as! T
            case is Int.Type:
                return Int(self.mmkv.int64(forKey: self.key, defaultValue: Int64(self.defaultValue as! Int))) as! T;
            case is Int64.Type:
                return self.mmkv.int64(forKey: self.key, defaultValue: self.defaultValue as! Int64) as! T
            case is UInt64.Type:
                return self.mmkv.uint64(forKey: self.key, defaultValue: self.defaultValue as! UInt64) as! T
            case is Float.Type:
                return self.mmkv.float(forKey: self.key, defaultValue: self.defaultValue as! Float) as! T
            case is Double.Type:
                return self.mmkv.double(forKey: self.key, defaultValue: self.defaultValue as! Double) as! T
            default:
                if let object = mmkv.object(forKey: key, as: T.self) {
                    return object
                }
                return defaultValue;
            }
        }
        set {
            //self.mmkv.set(newValue, forKey: self.key)
            switch newValue {
            case let str as NSString:
                self.mmkv.set(str, forKey: self.key)
            case let data as NSData:
                self.mmkv.set(data, forKey: self.key)
            case let date as NSDate:
                self.mmkv.set(date, forKey: self.key)
            case let bool as Bool:
                self.mmkv.set(bool, forKey: self.key)
            case let int as Int32:
                self.mmkv.set(int, forKey: self.key)
            case let uint as UInt32:
                self.mmkv.set(uint, forKey: self.key)
            case let int as Int:
                self.mmkv.set(Int64(int), forKey: self.key)
            case let int64 as Int64:
                self.mmkv.set(int64, forKey: self.key)
            case let uint64 as UInt64:
                self.mmkv.set(uint64, forKey: self.key)
            case let float as Float:
                self.mmkv.set(float, forKey: self.key)
            case let double as Double:
                self.mmkv.set(double, forKey: self.key)
            case let uint64 as UInt64:
                self.mmkv.set(uint64, forKey: self.key)
            default:
                self.mmkv.setObject(newValue, forKey: key)
            }
        }
    }
}

extension MMKV {
    
    static private let didInitialize = false
    
    public static var skRelativePath: String? = SKHelper.libraryPath.appending("MMKV") {
        didSet {
            initializeMMKV()
        }
    }
    
    static func customMMKV(mmkvID: String? = "default") -> MMKV {
        initializeMMKV()
        if let mmkvID = mmkvID, let mmkv = MMKV(mmapID: mmkvID, rootPath: MMKV.skRelativePath) {
            return mmkv
        } else {
            return MMKV.default()!
        }
    }
    
    static private func initializeMMKV() {
        guard !didInitialize else { return }
        MMKV.initialize(rootDir: nil)
    }
}

public extension MMKV {
    func setObject<T: Codable>(_ object: T?, forKey key: String) {
        if let data = try? JSONEncoder().encode(object) {
            set(data, forKey: key)
        } else {
            self.removeValue(forKey: key)
        }
    }
    
    func object<T: Codable>(forKey key: String, as _: T.Type) -> T? {
        if let data = self.data(forKey: key), let value = try? CleanJSONDecoder().decode(T.self, from: data) {
            return value
        }
        return nil
    }
    
}
