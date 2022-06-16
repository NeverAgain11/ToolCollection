//
//  Spacer.swift
//  ToolCollection
//
//  Created by ryeex on 2022/6/10.
//

import Foundation
import UIKit

public extension UIView {
    /// Makes a fixed space along the axis of the containing stack view.
    static func spacer(length: CGFloat) -> UIView {
        Spacer(length: length, isFixed: true)
    }
    
    /// Makes a fixed space along the axis of the containing stack view.
    static func spacer(width: CGFloat) -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: width).isActive = true
        return v
    }
    
    /// Makes a fixed space along the axis of the containing stack view.
    static func spacer(heigth: CGFloat) -> UIView {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: heigth).isActive = true
        return v
    }
    
    /// Makes a flexible space along the axis of the containing stack view.
    static func spacer(minLength: CGFloat = 0) -> UIView {
        Spacer(length: minLength, isFixed: false)
    }
}

private final class Spacer: UIView {
    private let length: CGFloat
    private let isFixed: Bool
    private var axis: NSLayoutConstraint.Axis?
    private var observer: NSKeyValueObservation?
    private var _constraints: [NSLayoutConstraint] = []
    
    deinit {
        if #available(iOS 11.0, *) {} else if let observer = observer {
            removeObserver(observer, forKeyPath: "foo")
        }
    }
    
    init(length: CGFloat, isFixed: Bool) {
        self.length = length
        self.isFixed = isFixed
        super.init(frame: .zero)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard let stackView = newSuperview as? UIStackView else {
            axis = nil
            setNeedsUpdateConstraints()
            return
        }
        
        axis = stackView.axis
        observer = stackView.observe(\.axis, options: [.initial, .new]) { [weak self] _, axis in
            self?.axis = axis.newValue
            self?.setNeedsUpdateConstraints()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate override func updateConstraints() {
        super.updateConstraints()
        
        NSLayoutConstraint.deactivate(_constraints)
        
        let attributes: [NSLayoutConstraint.Attribute]
        switch axis {
            case .horizontal: attributes = [.width]
            case .vertical: attributes = [.height]
            default: attributes = [.height, .width] // Not really an expected use-case
        }
        _constraints = attributes.map {
            let constraint = NSLayoutConstraint(item: self, attribute: $0, relatedBy: isFixed ? .equal : .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: length)
            constraint.priority = UILayoutPriority(999)
            return constraint
        }
        
        NSLayoutConstraint.activate(_constraints)
    }
    
}
