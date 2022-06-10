//
//  StackViewBuilder.swift
//  LiteUIBuilder
//
//  Created by Nghia Nguyen on 8/15/19.
//  Copyright © 2019 Nghia Nguyen. All rights reserved.
//

import UIKit

public protocol StackNode {
    var subNodes: [UIView] { get }
}

extension UIView: StackNode {
    public var subNodes: [UIView] { [self] }
}

extension Array: StackNode where Element: StackNode {
    public var subNodes: [UIView] {
        return self.flatMap { $0.subNodes }
    }
}

struct ComponentNode: StackNode {
    let views: [UIView]
    var subNodes: [UIView] { views }
}

struct EmptyNode: StackNode {
    var subNodes: [UIView] { [] }
}

@resultBuilder
public struct StackViewBuilder {
    public static func buildBlock(_ component: StackNode) -> StackNode {
        return component
    }
    
    public static func buildBlock(_ components: StackNode...) -> StackNode {
        ComponentNode(views: components.flatMap{ $0.subNodes })
    }
    
    public static func buildBlock(_ components: [StackNode]) -> StackNode {
        ComponentNode(views: components.flatMap{ $0.subNodes })
    }
    
    public static func buildArray(_ components: [StackNode]) -> StackNode {
        ComponentNode(views: components.flatMap{ $0.subNodes })
    }
    
    public static func buildEither(first component: StackNode) -> StackNode {
        component
    }
    
    public static func buildEither(second component: StackNode) -> StackNode {
        component
    }
    
    public static func buildOptional(_ component: StackNode?) -> StackNode {
        component ?? EmptyNode()
    }
}
