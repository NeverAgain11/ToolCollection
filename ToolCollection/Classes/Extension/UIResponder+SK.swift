//
//  UIResponder+SK.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/16.
//

import Foundation

//extension UIResponder {
//    @objc open func responseEvent(_ event: Event) {
//        self.next?.responseEvent(event)
//    }
//
//    public class Event: NSObject {
//        public init(sender: UIView, identifier: Any) {
//            self.sender = sender
//            self.identifier = identifier
//        }
//
//        public let sender: UIView
//        public let identifier: Any
//        public var info: [String : Any] = [:]
//    }
//}
//
//public extension CaseIterable where Self: Equatable {
//    func next() -> Self {
//        let all = Self.allCases
//        let idx = all.firstIndex(of: self)!
//        let next = all.index(after: idx)
//        return all[next == all.endIndex ? all.startIndex : next]
//    }
//}
