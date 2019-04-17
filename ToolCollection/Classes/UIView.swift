//
//  UIView.swift
//  Common
//
//  Created by lsc on 27/02/2017.
//
//

import UIKit

extension UIView: NamespaceWrappable {}

public extension TypeWrapperProtocol where WrappedType == UIView {
    
    var x: CGFloat {
        set {
            var frame = wrappedValue.frame
            frame.origin.x = newValue
            wrappedValue.frame = frame
        }
        get {
            return wrappedValue.frame.origin.x
        }
    }
    
    var y: CGFloat {
        set {
            var frame = wrappedValue.frame
            frame.origin.y = newValue
            wrappedValue.frame = frame
        }
        get {
            return wrappedValue.frame.origin.y
        }
    }
    
    var left: CGFloat {
        set {
            wrappedValue.frame = CGRect(x: newValue, y: self.top, width: self.width, height: self.height)
        }
        get {
            return wrappedValue.frame.origin.x
        }
    }
    
    var top: CGFloat {
        set {
            wrappedValue.frame = CGRect(x: self.left, y: newValue, width: self.width, height: self.height)
        }
        get {
            return wrappedValue.frame.origin.y
        }
    }
    
    var right: CGFloat {
        set {
            wrappedValue.frame = CGRect(x: newValue - self.width, y: self.top, width: self.width, height: self.height)
        }
        get {
            return self.left + self.width
        }
    }
    
    var bottom: CGFloat {
        set {
            wrappedValue.frame = CGRect(x: self.left, y: newValue - self.height, width: self.width, height: self.height)
        }
        get {
            return self.top + self.height
        }
    }
    
    var centerX: CGFloat {
        set {
            var center = wrappedValue.center
            center.x = newValue
            wrappedValue.center = center
        }
        get {
            return wrappedValue.center.x
        }
    }
    
    var centerY: CGFloat {
        set {
            var center = wrappedValue.center
            center.y = newValue
            wrappedValue.center = center
        }
        get {
            return wrappedValue.center.y
        }
    }
    
    var width: CGFloat {
        set {
            wrappedValue.frame.size = CGSize(width: newValue, height: wrappedValue.frame.height)
        }
        get {
            return wrappedValue.bounds.size.width
        }
    }
    
    var height: CGFloat {
        set {
            wrappedValue.frame = CGRect(origin: wrappedValue.frame.origin, size: CGSize(width: self.width, height: newValue))
        }
        get {
            return wrappedValue.bounds.size.height
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
            wrappedValue.frame.size = newValue
        }
        get {
            return wrappedValue.frame.size
        }
    }
}
