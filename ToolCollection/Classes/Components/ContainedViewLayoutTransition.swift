//
//  ContainedViewLayoutTransition.swift
//  CalculatorVault
//
//  Created by Endless Summer on 2020/4/17.
//  Copyright © 2020 Tracy. All rights reserved.
//

import Foundation
import UIKit

public enum ContainedViewLayoutTransitionCurve {
    case easeInOut
    case spring
    case custom(Float, Float, Float, Float)
    
    public static var slide: ContainedViewLayoutTransitionCurve {
        return .custom(0.33, 0.52, 0.25, 0.99)
    }
}

public extension ContainedViewLayoutTransitionCurve {
    var timingFunction: String {
        switch self {
            case .easeInOut:
                return CAMediaTimingFunctionName.easeInEaseOut.rawValue
            case .spring:
                return kCAMediaTimingFunctionSpring
            case .custom:
                return CAMediaTimingFunctionName.easeInEaseOut.rawValue
        }
    }
    
    var mediaTimingFunction: CAMediaTimingFunction? {
        switch self {
            case .easeInOut:
                return nil
            case .spring:
                return nil
            case let .custom(p1, p2, p3, p4):
                return CAMediaTimingFunction(controlPoints: p1, p2, p3, p4)
        }
    }
    
    #if os(iOS)
    var viewAnimationOptions: UIView.AnimationOptions {
        switch self {
            case .easeInOut:
                return [.curveEaseInOut]
            case .spring:
                return UIView.AnimationOptions(rawValue: 7 << 16)
            case .custom:
                return []
        }
    }
    #endif
}

public enum ContainedViewLayoutTransition {
    case immediate
    case animated(duration: Double, curve: ContainedViewLayoutTransitionCurve)
    
    public var isAnimated: Bool {
        if case .immediate = self {
            return false
        } else {
            return true
        }
    }
}

public extension ContainedViewLayoutTransition {
    
    
    
    func updateBounds(layer: CALayer, bounds: CGRect, force: Bool = false, completion: ((Bool) -> Void)? = nil) {
        if layer.bounds.equalTo(bounds) && !force {
            completion?(true)
        } else {
            switch self {
            case .immediate:
                layer.bounds = bounds
                if let completion = completion {
                    completion(true)
                }
            case let .animated(duration, curve):
                let previousBounds = layer.bounds
                layer.bounds = bounds
                layer.animateBounds(from: previousBounds, to: bounds, duration: duration, timingFunction: curve.timingFunction, mediaTimingFunction: curve.mediaTimingFunction, force: force, completion: { result in
                    if let completion = completion {
                        completion(result)
                    }
                })
            }
        }
    }
    
    func updatePosition(layer: CALayer, position: CGPoint, completion: ((Bool) -> Void)? = nil) {
        if layer.position.equalTo(position) {
            completion?(true)
        } else {
            switch self {
            case .immediate:
                layer.position = position
                if let completion = completion {
                    completion(true)
                }
            case let .animated(duration, curve):
                let previousPosition = layer.position
                layer.position = position
                layer.animatePosition(from: previousPosition, to: position, duration: duration, timingFunction: curve.timingFunction, mediaTimingFunction: curve.mediaTimingFunction, completion: { result in
                    if let completion = completion {
                        completion(result)
                    }
                })
            }
        }
    }
    
    func animateBounds(layer: CALayer, from bounds: CGRect, removeOnCompletion: Bool = true, completion: ((Bool) -> Void)? = nil) {
        switch self {
            case .immediate:
                if let completion = completion {
                    completion(true)
                }
            case let .animated(duration, curve):
                layer.animateBounds(from: bounds, to: layer.bounds, duration: duration, timingFunction: curve.timingFunction, mediaTimingFunction: curve.mediaTimingFunction, removeOnCompletion: removeOnCompletion, completion: { result in
                    if let completion = completion {
                        completion(result)
                    }
                })
        }
    }
    
    func animateOffsetAdditive(layer: CALayer, offset: CGFloat, completion: (() -> Void)? = nil) {
        switch self {
            case .immediate:
                completion?()
            case let .animated(duration, curve):
                layer.animateBoundsOriginYAdditive(from: offset, to: 0.0, duration: duration, timingFunction: curve.timingFunction, mediaTimingFunction: curve.mediaTimingFunction, completion: { _ in
                    completion?()
                })
        }
    }
    
    func animatePositionAdditive(layer: CALayer, offset: CGFloat, removeOnCompletion: Bool = true, completion: @escaping (Bool) -> Void) {
        switch self {
            case .immediate:
                completion(true)
            case let .animated(duration, curve):
                layer.animatePosition(from: CGPoint(x: 0.0, y: offset), to: CGPoint(), duration: duration, timingFunction: curve.timingFunction, mediaTimingFunction: curve.mediaTimingFunction, removeOnCompletion: removeOnCompletion, additive: true, completion: completion)
        }
    }
    
    func animatePositionAdditive(layer: CALayer, offset: CGPoint, to toOffset: CGPoint = CGPoint(), removeOnCompletion: Bool = true, completion: (() -> Void)? = nil) {
        switch self {
            case .immediate:
                completion?()
            case let .animated(duration, curve):
                layer.animatePosition(from: offset, to: toOffset, duration: duration, timingFunction: curve.timingFunction, mediaTimingFunction: curve.mediaTimingFunction, removeOnCompletion: removeOnCompletion, additive: true, completion: { _ in
                    completion?()
                })
        }
    }
    
    func updateFrame(view: UIView, frame: CGRect, force: Bool = false, completion: ((Bool) -> Void)? = nil) {
        if view.frame.equalTo(frame) && !force {
            completion?(true)
        } else {
            switch self {
            case .immediate:
                view.frame = frame
                if let completion = completion {
                    completion(true)
                }
            case let .animated(duration, curve):
                let previousFrame = view.frame
                view.frame = frame
                view.layer.animateFrame(from: previousFrame, to: frame, duration: duration, timingFunction: curve.timingFunction, mediaTimingFunction: curve.mediaTimingFunction, force: force, completion: { result in
                    if let completion = completion {
                        completion(result)
                    }
                })
            }
        }
    }
    
    func updateFrame(layer: CALayer, frame: CGRect, completion: ((Bool) -> Void)? = nil) {
        if layer.frame.equalTo(frame) {
            completion?(true)
        } else {
            switch self {
            case .immediate:
                layer.frame = frame
                if let completion = completion {
                    completion(true)
                }
            case let .animated(duration, curve):
                let previousFrame = layer.frame
                layer.frame = frame
                layer.animateFrame(from: previousFrame, to: frame, duration: duration, timingFunction: curve.timingFunction, mediaTimingFunction: curve.mediaTimingFunction, completion: { result in
                    if let completion = completion {
                        completion(result)
                    }
                })
            }
        }
    }
    
    func updateAlpha(layer: CALayer, alpha: CGFloat, completion: ((Bool) -> Void)? = nil) {
        if layer.opacity.isEqual(to: Float(alpha)) {
            if let completion = completion {
                completion(true)
            }
            return
        }
        
        switch self {
        case .immediate:
            layer.opacity = Float(alpha)
            if let completion = completion {
                completion(true)
            }
        case let .animated(duration, curve):
            let previousAlpha = layer.opacity
            layer.opacity = Float(alpha)
            layer.animateAlpha(from: CGFloat(previousAlpha), to: alpha, duration: duration, timingFunction: curve.timingFunction, mediaTimingFunction: curve.mediaTimingFunction, completion: { result in
                if let completion = completion {
                    completion(result)
                }
            })
        }
    }
    
    func animateTransformScale(view: UIView, from fromScale: CGFloat, completion: ((Bool) -> Void)? = nil) {
        let t = view.layer.transform
        let currentScale = sqrt((t.m11 * t.m11) + (t.m12 * t.m12) + (t.m13 * t.m13))
        if currentScale.isEqual(to: fromScale) {
            if let completion = completion {
                completion(true)
            }
            return
        }
        
        switch self {
        case .immediate:
            if let completion = completion {
                completion(true)
            }
        case let .animated(duration, curve):
            view.layer.animateScale(from: fromScale, to: currentScale, duration: duration, timingFunction: curve.timingFunction, mediaTimingFunction: curve.mediaTimingFunction, completion: { result in
                if let completion = completion {
                    completion(result)
                }
            })
        }
    }
    
    func updateTransformScale(layer: CALayer, scale: CGFloat, completion: ((Bool) -> Void)? = nil) {
        let t = layer.transform
        let currentScale = sqrt((t.m11 * t.m11) + (t.m12 * t.m12) + (t.m13 * t.m13))
        if currentScale.isEqual(to: scale) {
            if let completion = completion {
                completion(true)
            }
            return
        }
        
        switch self {
        case .immediate:
            layer.transform = CATransform3DMakeScale(scale, scale, 1.0)
            if let completion = completion {
                completion(true)
            }
        case let .animated(duration, curve):
            layer.transform = CATransform3DMakeScale(scale, scale, 1.0)
            layer.animateScale(from: currentScale, to: scale, duration: duration, timingFunction: curve.timingFunction, mediaTimingFunction: curve.mediaTimingFunction, completion: { result in
                if let completion = completion {
                    completion(result)
                }
            })
        }
    }
    
    
    func updateSublayerTransformScale(layer: CALayer, scale: CGPoint, completion: ((Bool) -> Void)? = nil) {
        let t = layer.sublayerTransform
        let currentScaleX = sqrt((t.m11 * t.m11) + (t.m12 * t.m12) + (t.m13 * t.m13))
        var currentScaleY = sqrt((t.m21 * t.m21) + (t.m22 * t.m22) + (t.m23 * t.m23))
        if t.m22 < 0.0 {
            currentScaleY = -currentScaleY
        }
        if CGPoint(x: currentScaleX, y: currentScaleY) == scale {
            if let completion = completion {
                completion(true)
            }
            return
        }
        
        switch self {
        case .immediate:
            layer.sublayerTransform = CATransform3DMakeScale(scale.x, scale.y, 1.0)
            if let completion = completion {
                completion(true)
            }
        case let .animated(duration, curve):
            layer.sublayerTransform = CATransform3DMakeScale(scale.x, scale.y, 1.0)
            layer.animate(from: NSValue(caTransform3D: t), to: NSValue(caTransform3D: layer.sublayerTransform), keyPath: "sublayerTransform", timingFunction: curve.timingFunction, duration: duration, delay: 0.0, mediaTimingFunction: curve.mediaTimingFunction, removeOnCompletion: true, additive: false, completion: {
                result in
                if let completion = completion {
                    completion(result)
                }
            })
        }
    }
    
    
    func updateSublayerTransformOffset(layer: CALayer, offset: CGPoint, completion: ((Bool) -> Void)? = nil) {
        let t = layer.sublayerTransform
        let currentOffset = CGPoint(x: t.m41, y: t.m42)
        if currentOffset == offset {
            if let completion = completion {
                completion(true)
            }
            return
        }
        
        switch self {
        case .immediate:
            layer.sublayerTransform = CATransform3DMakeTranslation(offset.x, offset.y, 0.0)
            if let completion = completion {
                completion(true)
            }
        case let .animated(duration, curve):
            layer.sublayerTransform = CATransform3DMakeTranslation(offset.x, offset.y, 0.0)
            layer.animate(from: NSValue(caTransform3D: t), to: NSValue(caTransform3D: layer.sublayerTransform), keyPath: "sublayerTransform", timingFunction: curve.timingFunction, duration: duration, delay: 0.0, mediaTimingFunction: curve.mediaTimingFunction, removeOnCompletion: true, additive: false, completion: {
                result in
                if let completion = completion {
                    completion(result)
                }
            })
        }
    }
}

#if os(iOS)
    
public extension ContainedViewLayoutTransition {
    func animateView(_ f: @escaping () -> Void) {
        switch self {
        case .immediate:
            f()
        case let .animated(duration, curve):
            UIView.animate(withDuration: duration, delay: 0.0, options: curve.viewAnimationOptions, animations: {
                f()
            }, completion: nil)
        }
    }
}
    
#endif

