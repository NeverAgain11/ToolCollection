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

public struct Carbon {
    public struct Spacing: IdentifiableComponent, Hashable {
        public var height: CGFloat
        
        public init(_ height: CGFloat) {
            self.height = height
        }
        
        public func renderContent() -> UIView {
            UIView()
        }
        
        public func render(in content: UIView) {}

        public func referenceSize(in bounds: CGRect) -> CGSize? {
            CGSize(width: bounds.width, height: height)
        }
    }
    
    open class View<T: ASDisplayNode>: UIView {
        public lazy var node = T()
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubnode(node)
            
            configure()
            setupData()
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        open override func layoutSubviews() {
            super.layoutSubviews()
            
            node.frame = bounds
        }
        
        open func configure() {
            
        }
        
        open func setupData() {
            
        }
        
    }
    
    final class NodeView<T: ASDisplayNode>: UIView {
        let node: T
        init(node: T) {
            self.node = node
            
            super.init(frame: .zero)
            
            addSubnode(node)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public override func layoutSubviews() {
            super.layoutSubviews()
            
            node.frame = bounds
        }
        
    }
}



