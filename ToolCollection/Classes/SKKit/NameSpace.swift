//
//  NameSpace.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/8.
//

import Foundation

// 定义泛型类
public final class SKKit<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

// 定义泛型协议
public protocol SKKitCompatible {
    associatedtype CompatibleType
    var sk: CompatibleType { get }
}

// 协议的扩展
public extension SKKitCompatible {
    var sk: SKKit<Self>{
        get { return SKKit(self) }
    }
}
