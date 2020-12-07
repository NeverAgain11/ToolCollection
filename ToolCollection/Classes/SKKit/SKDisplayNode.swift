//
//  SKDisplayNode.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/10/30.
//

import Foundation
import AsyncDisplayKit

fileprivate let queue = DispatchQueue.global()

open class BaseControlNode: ASControlNode {
    
    public typealias BaseControlAction = (_ sender: BaseControlNode) -> Void
    
    open var action: BaseControlAction?
    
    open override func didLoad() {
        super.didLoad()
        #if DEBUG
        queue.async { [weak self] in
            guard let self = self else { return }
            let typeName = _typeName(type(of: self))
            DispatchQueue.main.async {
                guard self.accessibilityIdentifier == nil else { return }
                self.accessibilityIdentifier = typeName
            }
        }
        #endif
    }
    
    public override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        
        addTarget(self, action: #selector(BaseControlNode.didPressed(_:)), forControlEvents: .touchUpInside)
    }
    
    open func addAction(_ action: @escaping BaseControlAction) {
        self.action = action
    }
    
    @objc open func didPressed(_ sender: BaseControlNode) {
        action?(sender)
    }
    
}

open class BaseButtonNode: ASButtonNode {
    
    public typealias BaseControlAction = (_ sender: BaseButtonNode) -> Void
    
    open var action: BaseControlAction?
    
    open override func didLoad() {
        super.didLoad()
        #if DEBUG
        queue.async { [weak self] in
            guard let self = self else { return }
            let typeName = _typeName(type(of: self))
            DispatchQueue.main.async {
                guard self.accessibilityIdentifier == nil else { return }
                self.accessibilityIdentifier = typeName
            }
        }
        #endif
    }
    
    public override init() {
        super.init()
        
        automaticallyManagesSubnodes = true
        
        addTarget(self, action: #selector(BaseButtonNode.didPressed(_:)), forControlEvents: .touchUpInside)
    }
    
    open func addAction(_ action: @escaping BaseControlAction) {
        self.action = action
    }
    
    @objc open func didPressed(_ sender: BaseButtonNode) {
        action?(sender)
    }
    
}
