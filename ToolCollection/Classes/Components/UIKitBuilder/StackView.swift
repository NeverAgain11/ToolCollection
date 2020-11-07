//
//  StackView.swift
//  UIKitBuilder
//
//  Created by Nghia on 4/26/20.
//  Copyright © 2020 Nghia. All rights reserved.
//

import UIKit

public class StackView: UIStackView {
    
    public init(
        axis: NSLayoutConstraint.Axis,
        distribution: UIStackView.Distribution,
        alignment: UIStackView.Alignment,
        spacing: CGFloat,
        layoutMargins: UIEdgeInsets,
        arrangedSubviews: [UIView]) {
        super.init(frame: .zero)
        arrangedSubviews.forEach { self.addArrangedSubview($0) }
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        self.spacing = spacing
        isLayoutMarginsRelativeArrangement = false
        self.layoutMargins = layoutMargins
    }
    
    public required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private var color: UIColor?
    
    public override var backgroundColor: UIColor? {
        get { return color }
        set {
            color = newValue
            self.setNeedsLayout() // EDIT 2017-02-03 thank you @BruceLiu
        }
    }
    
    private lazy var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.path = UIBezierPath(rect: self.bounds).cgPath
        backgroundLayer.fillColor = self.backgroundColor?.cgColor
    }
    
}
