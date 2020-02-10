//
//  UIResponder+SK.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/16.
//

import Foundation

public class SKEvent: NSObject {
    public var sender: UIResponder
    
    public var info: [String : Any]
    
    public let identifier: Any
    
    public init(sender: UIResponder, info: [String: Any], identifier: Any) {
        self.sender = sender
        self.info = info
        self.identifier = identifier
        
        super.init()
    }
}

extension UIResponder {
    @objc open func responseEvent(_ event: SKEvent) {
        self.next?.responseEvent(event)
    }
}

public extension CaseIterable where Self: Equatable {
    func next() -> Self {
        let all = Self.allCases
        let idx = all.index(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
}
