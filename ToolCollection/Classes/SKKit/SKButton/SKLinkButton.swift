//
//  SKLinkButton.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/3.
//

import Foundation

/**
*  支持显示下划线的按钮，可用于需要链接的场景。下划线默认和按钮宽度一样，可通过 `underlineInsets` 调整。
*/
open class SKLinkButton: SKButton {
    
    /// 控制下划线隐藏或显示，默认为NO，也即显示下划线
    @IBInspectable open var underlineHidden: Bool = false {
        didSet {
            underlineLayer.isHidden = underlineHidden
        }
    }
    
    /// 设置下划线的宽度，默认为 1
    @IBInspectable open var underlineWidth: CGFloat = 1 {
        didSet {
            setNeedsLayout()
        }
    }
    
    /// 控制下划线颜色，若设置为nil，则使用当前按钮的titleColor的颜色作为下划线的颜色。默认为 nil。
    @IBInspectable open var underlineColor: UIColor? {
        didSet {
            updateUnderlineColor()
        }
    }
    
    /// 下划线的位置是基于 titleLabel 的位置来计算的，默认x、width均和titleLabel一致，而可以通过这个属性来调整下划线的偏移值。默认为UIEdgeInsetsZero。
    @IBInspectable open var underlineInsets: UIEdgeInsets = .zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    private var underlineLayer: CALayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didInitialized()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        didInitialized()
    }
    
    override func didInitialized() {
        super.didInitialized()
        underlineLayer.qmui_removeDefaultAnimations()
        layer.addSublayer(underlineLayer)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        if underlineLayer.isHidden {
            return
        }
        underlineLayer.frame = CGRect(x: underlineInsets.left, y: (titleLabel?.frame.maxY ?? 0) +  underlineInsets.top - underlineInsets.bottom, width: bounds.width - underlineInsets.horizontalValue, height: underlineWidth)
    }
    
    override open func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(color, for: state)
        updateUnderlineColor()
    }
    
    private func updateUnderlineColor() {
        var color = underlineColor
        if color == nil {
            color = titleColor(for: .normal)
        }
        underlineLayer.backgroundColor = color?.cgColor
    }
}
