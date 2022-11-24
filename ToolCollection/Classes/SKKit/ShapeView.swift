//
//  ShapeView.swift
//  ToolCollection
//
//  Created by flow on 2022/11/24.
//

import Foundation
import UIKit

open class ShapeView: UIView {
    
    public override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    public var shapeLayer: CAShapeLayer {
        return layer as! CAShapeLayer
    }
    
    public var path: UIBezierPath? {
        didSet {
            shapeLayer.path = path?.cgPath
        }
    }
    
    public var fillColor: UIColor? {
        didSet {
            shapeLayer.fillColor = fillColor?.cgColor
        }
    }
    
    public var strokeColor: UIColor? {
        didSet {
            shapeLayer.strokeColor = strokeColor?.cgColor
        }
    }
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
                shapeLayer.fillColor = fillColor?.cgColor
                shapeLayer.strokeColor = strokeColor?.cgColor
            }
        }
    }
}
