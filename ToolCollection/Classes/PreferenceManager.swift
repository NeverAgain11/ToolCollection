//
//  Preference.swift
//  Example
//
//  Created by ljk on 2019/5/31.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import MMKV

public let defaults = PreferenceManager(mmapID: "default.mmkv")

final public class PreferenceKey<T>: BaseKey {
    let defaultValue: T?
    
    public init(_ key: String, defaultValue: T? = nil) {
        self.defaultValue = defaultValue
        super.init(rawValue: key)
    }
    
    required public init!(rawValue: String) {
        defaultValue = nil
        super.init(rawValue: rawValue)
    }
}

public class BaseKey: RawRepresentable, Hashable {
    public let rawValue: String
    
    required public init!(rawValue: String) {
        self.rawValue = rawValue
    }
    
    convenience init(_ key: String) {
        self.init(rawValue: key)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}

final public class PreferenceManager {
    static let shared = PreferenceManager(mmapID: "default.mmkv")
    public let mmkv: MMKV
    
    public init(mmapID: String, relativePath: String? = nil) {
        let path = relativePath ?? NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        mmkv = MMKV(mmapID: mmapID, relativePath: path)!
        
    }
    
}

public extension PreferenceManager {
    
    subscript(key: PreferenceKey<String>) -> String? {
        get { return mmkv.string(forKey: key.rawValue, defaultValue: key.defaultValue) }
        set {
            if let newValue = newValue {
                mmkv.set(newValue, forKey: key.rawValue)
            } else {
                mmkv.removeValue(forKey: key.rawValue)
            }
        }
    }
    
    subscript(key: PreferenceKey<Data>) -> Data? {
        get { return mmkv.data(forKey: key.rawValue) }
        set {
            if let newValue = newValue {
                mmkv.set(newValue, forKey: key.rawValue)
            } else {
                mmkv.removeValue(forKey: key.rawValue)
            }
        }
    }
    
    subscript(key: PreferenceKey<Bool>) -> Bool {
        get {
            if let defaultValue = key.defaultValue {
                return mmkv.bool(forKey: key.rawValue, defaultValue: defaultValue)
            }
            return mmkv.bool(forKey: key.rawValue)
        }
        set { mmkv.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<Int>) -> Int {
        get {
            if let defaultValue = key.defaultValue {
                return Int(mmkv.int64(forKey: key.rawValue, defaultValue: Int64(defaultValue)))
            }
            return Int(mmkv.int64(forKey: key.rawValue))
        }
        set { mmkv.set(Int64(newValue), forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<Float>) -> Float {
        get {
            if let defaultValue = key.defaultValue {
                return mmkv.float(forKey: key.rawValue, defaultValue: defaultValue)
            }
            return mmkv.float(forKey: key.rawValue)
        }
        set { mmkv.set(newValue, forKey: key.rawValue) }
    }
    
    subscript(key: PreferenceKey<Double>) -> Double {
        get {
            if let defaultValue = key.defaultValue {
                return mmkv.double(forKey: key.rawValue, defaultValue: defaultValue)
            }
            return mmkv.double(forKey: key.rawValue)
        }
        set { mmkv.set(newValue, forKey: key.rawValue) }
    }
    
}
