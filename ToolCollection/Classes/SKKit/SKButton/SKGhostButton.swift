//
//  SKGhostButton.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/3.
//

import Foundation

/**
 *  用于 `QMUIGhostButton.cornerRadius` 属性，当 `cornerRadius` 为 `SKGhostButtonCornerRadiusAdjustsBounds` 时，`QMUIGhostButton` 会在高度变化时自动调整 `cornerRadius`，使其始终保持为高度的 1/2。
 */
let SKGhostButtonCornerRadiusAdjustsBounds: CGFloat = -1

/**
 *  “幽灵”按钮，也即背景透明、带圆角边框的按钮
 *
 *  可通过 `QMUIGhostButtonColor` 设置几种预设的颜色，也可以用 `ghostColor` 设置自定义颜色。
 *
 *  @warning 默认情况下，`ghostColor` 只会修改文字和边框的颜色，如果需要让 image 也跟随 `ghostColor` 的颜色，则可将 `adjustsImageWithGhostColor` 设为 `YES`
 */
open class SKGhostButton: SKButton {
    @IBInspectable open var ghostColor: UIColor = UIColor.blue { // 默认为 GhostButtonColorBlue
        didSet {
            setTitleColor(ghostColor, for: .normal)
            layer.borderColor = ghostColor.cgColor
            if adjustsImageWithGhostColor {
                updateImageColor()
            }
        }
    }
    
    @IBInspectable @objc dynamic open var borderWidth: CGFloat = 1 { // 默认为 1pt
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable @objc dynamic open var cornerRadius: CGFloat = SKGhostButtonCornerRadiusAdjustsBounds { // 默认为 SKGhostButtonCornerRadiusAdjustsBounds，也即固定保持按钮高度的一半。
        didSet {
            setNeedsLayout()
        }
    }
    
    /**
     *  控制按钮里面的图片是否也要跟随 `ghostColor` 一起变化，默认为 `NO`
     */
    @objc dynamic open var adjustsImageWithGhostColor: Bool = false {
        didSet {
            updateImageColor()
        }
    }
    
    init(ghostColor: UIColor, frame: CGRect) {
        super.init(frame: frame)
        didInitialized(ghostColor)
    }
    
    private static let _onceToken = UUID().uuidString
    
    private func didInitialized(_ ghostColor:UIColor) {
        self.ghostColor = ghostColor
        self.borderWidth = 1
    }
    
    convenience public init() {
        self.init(ghostColor: UIColor.blue, frame: .zero)
    }
    
    convenience public init(ghostColor: UIColor) {
        self.init(ghostColor: ghostColor, frame: .zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInitialized(.blue)
    }
    
    private func updateImageColor() {
        imageView?.tintColor = adjustsImageWithGhostColor ? ghostColor : nil
        guard let _ = currentImage else { return }
        let states: [UIControl.State] = [.normal, .highlighted, .disabled]
        for state in states {
            if let image = image(for: state) {
                if adjustsImageWithGhostColor {
                    // 这里的image不用做renderingMode的处理，而是放到重写的setImage:forState里去做
                    setImage(image, for: state)
                } else {
                    // 如果不需要用template的模式渲染，并且之前是使用template的，则把renderingMode改回Original
                    setImage(image.withRenderingMode(.alwaysOriginal), for: state)
                }
            }
        }
    }
    
    override open func setImage(_ image: UIImage?, for state: UIControl.State) {
        var newImage = image
        if adjustsImageWithGhostColor {
            newImage = image?.withRenderingMode(.alwaysTemplate)
        }
        super.setImage(newImage, for: state)
    }
    
    override open func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        if cornerRadius != SKGhostButtonCornerRadiusAdjustsBounds {
            layer.cornerRadius = cornerRadius
        } else {
            layer.cornerRadius = flat(bounds.height / 2)
        }
    }
}
