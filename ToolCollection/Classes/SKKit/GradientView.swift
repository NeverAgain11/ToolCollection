//
//  GradientView.swift
//  ToolCollection
//
//  Created by ryeex on 2022/6/23.
//

import Foundation
import UIKit

open class GradientView: UIView {
    open override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    open var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    open var colors: [UIColor] = [] {
        didSet {
            guard colors != oldValue else { return }
            updateColors()
        }
    }
    
    open var locations: [CGFloat] = [] {
        didSet {
            gradientLayer.locations = locations as [NSNumber]
        }
    }
    
    open var startPoint: CGPoint {
        get { return gradientLayer.startPoint }
        set { gradientLayer.startPoint = newValue }
    }
    
    open var endPoint: CGPoint {
        get { return gradientLayer.endPoint }
        set { gradientLayer.endPoint = newValue }
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateColors()
    }
    
    private func updateColors() {
        gradientLayer.colors = colors.map {
            if #available(iOS 13.0, *) {
                return $0.resolvedColor(with: traitCollection).cgColor
            } else {
                return $0.cgColor
            }
        }
    }
}
