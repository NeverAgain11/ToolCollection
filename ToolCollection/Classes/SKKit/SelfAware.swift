//
//  SelfAware.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/3.
//

import Foundation

public protocol SKSelfAware: class {
    static func awake()
}

public protocol SelfAware2: class {
    static func awake2()
}

class NothingToSeeHere {
    
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SKSelfAware.Type)?.awake()
            (types[index] as? SelfAware2.Type)?.awake2()
        }
        
        types.deallocate()
    }
}

extension UIApplication {

    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()

    open override var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }
}
