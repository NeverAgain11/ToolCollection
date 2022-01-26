//
//  ASDisplayNode+Position.swift
//  DifferenceKit
//
//  Created by Endless Summer on 2020/4/28.
//

import Foundation
import AsyncDisplayKit

public extension ASDisplayNode {
    var left: CGFloat {
        set {
            self.frame = CGRect(x: newValue, y: self.top, width: self.width, height: self.height)
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var top: CGFloat {
        set {
            self.frame = CGRect(x: self.left, y: newValue, width: self.width, height: self.height)
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var right: CGFloat {
        set {
            self.frame = CGRect(x: newValue - self.width, y: self.top, width: self.width, height: self.height)
        }
        get {
            return self.left + self.width
        }
    }
    
    var bottom: CGFloat {
        set {
            self.frame = CGRect(x: self.left, y: newValue - self.height, width: self.width, height: self.height)
        }
        get {
            return self.top + self.height
        }
    }
    
    var center: CGPoint {
        return self.frame.center
    }
    
    var centerX: CGFloat {
        set {
            let value = newValue - halfWidth
            self.left = value
        }
        get {
            return self.center.x
        }
    }
    
    var centerY: CGFloat {
        set {
            let value = newValue - halfHeight
            self.top = value
        }
        get {
            return self.center.y
        }
    }
    
    var width: CGFloat {
        set {
            self.frame.size = CGSize(width: newValue, height: self.frame.height)
        }
        get {
            return self.bounds.size.width
        }
    }
    
    var height: CGFloat {
        set {
            self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: self.width, height: newValue))
        }
        get {
            return self.bounds.size.height
        }
    }
    
    var halfWidth: CGFloat {
        return self.width / 2
    }
    
    var halfHeight: CGFloat {
        return self.height / 2
    }
    
    var size: CGSize {
        set {
            self.frame.size = newValue
        }
        get {
            return self.frame.size
        }
    }
}

public class SKButtonNode<E>: ASButtonNode {
    public let model: E
    
    public init(model: E) {
        self.model = model
        
        super.init()
        
        addTarget(self, action: #selector(buttonTapped), forControlEvents: .touchUpInside)
    }
    
    @objc open func buttonTapped() {
//        let event = UIResponder.Event(sender: self.view, identifier: model)
//        
//        self.view.responseEvent(event)
    }
}

open class SKControlNode<E>: ASControlNode {
    public let model: E
    
    public init(model: E) {
        self.model = model
        
        super.init()
        
        addTarget(self, action: #selector(buttonTapped), forControlEvents: .touchUpInside)
        
        automaticallyManagesSubnodes = true
    }
    
    @objc open func buttonTapped() {
//        let event = UIResponder.Event(sender: self.view, identifier: model)
//
//        self.view.responseEvent(event)
    }
}

fileprivate let queue = DispatchQueue(label: "com.summer.node.identifier", qos: .background, attributes: .concurrent)

open class BaseDisplayNode: ASDisplayNode {

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
    
    automaticallyManagesSubnodes = true
  }
}
