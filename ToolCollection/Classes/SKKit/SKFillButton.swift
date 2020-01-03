//
//  SKFillButton.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/3.
//

import Foundation

/**
 *  用于 `QMUIFillButton.cornerRadius` 属性，当 `cornerRadius` 为 `SKFillButtonCornerRadiusAdjustsBounds` 时，`QMUIFillButton` 会在高度变化时自动调整 `cornerRadius`，使其始终保持为高度的 1/2。
 */
fileprivate let SKFillButtonCornerRadiusAdjustsBounds: CGFloat = -1

/**
 *  QMUIFillButton
 *  实心填充颜色的按钮
 */

open class SKFillButton: SKButton {
    @IBInspectable open var fillColor: UIColor = .blue { // 默认为 FillButtonColorBlue
        didSet {
            backgroundColor = fillColor
        }
    }
    
    @IBInspectable open var titleTextColor: UIColor = UIColor.white { // 默认为 UIColorWhite
        didSet {
            setTitleColor(titleTextColor, for: .normal)
            if adjustsImageWithTitleTextColor {
                updateImageColor()
            }
        }
    }
    
    @IBInspectable @objc open dynamic var cornerRadius: CGFloat = SKFillButtonCornerRadiusAdjustsBounds { // 默认为 SKFillButtonCornerRadiusAdjustsBounds，也即固定保持按钮高度的一半。
        didSet {
            setNeedsLayout()
        }
    }
    
    /**
     *  控制按钮里面的图片是否也要跟随 `titleTextColor` 一起变化，默认为 `NO`
     */
    @objc dynamic var adjustsImageWithTitleTextColor: Bool = false {
        didSet {
            if adjustsImageWithTitleTextColor {
                updateImageColor()
            }
        }
    }
    
    convenience public init(fillColor: UIColor, titleTextColor: UIColor) {
        self.init(fillColor: fillColor, titleTextColor: titleTextColor, frame: .zero)
    }
    
    init(fillColor: UIColor, titleTextColor: UIColor, frame: CGRect) {
        super.init(frame: frame)
        didInitialized(fillColor, titleTextColor: titleTextColor)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.fillColor = UIColor.blue
        self.titleTextColor = UIColor.white
    }
    
    private static let _onceToken = UUID().uuidString
    
    private func didInitialized(_ fillColor: UIColor, titleTextColor: UIColor) {
        self.fillColor = fillColor
        self.titleTextColor = titleTextColor
        
    }
    
    override open func setImage(_ image: UIImage?, for state: UIControl.State) {
        var image = image
        if adjustsImageWithTitleTextColor {
            image = image?.withRenderingMode(.alwaysTemplate)
        }
        super.setImage(image, for: state)
    }
    
    private func updateImageColor() {
        self.imageView?.tintColor = adjustsImageWithTitleTextColor ? self.titleTextColor : nil
        if self.currentImage != nil {
            let states: [UIControl.State] = [.normal, .highlighted, .disabled]
            for state in states {
                if let image = self.image(for: state) {
                    if self.adjustsImageWithTitleTextColor {
                        // 这里的image不用做renderingMode的处理，而是放到重写的setImage:forState里去做
                        self.setImage(image, for: state)
                    } else {
                        // 如果不需要用template的模式渲染，并且之前是使用template的，则把renderingMode改回Original
                        self.setImage(image.withRenderingMode(.alwaysOriginal), for: state)
                    }
                }
            }
        }
    }
    
    override open func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        if self.cornerRadius != SKFillButtonCornerRadiusAdjustsBounds {
            self.layer.cornerRadius = self.cornerRadius
        } else {
            self.layer.cornerRadius = self.bounds.height / 2
        }
    }
}
