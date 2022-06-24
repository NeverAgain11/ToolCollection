//
//  GradientView.swift
//  ToolCollection
//
//  Created by ryeex on 2022/6/23.
//

import Foundation

open class GradientView: UIView {
    open override class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    public var gradientLayer: CAGradientLayer {
        layer as! CAGradientLayer
    }
}
