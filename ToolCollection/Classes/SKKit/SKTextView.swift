//
//  SKTextView.swift
//  ToolCollection
//
//  Created by mac on 2020/1/4.
//

import Foundation

open class SKTextView: UITextView {
    private lazy var placeholderLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        view.textColor = placeholderColor
        view.textAlignment = .center
        view.numberOfLines = 0
        view.alpha = 0
        return view
    }()
    
    /**
     *  placeholder 在默认位置上的偏移（默认位置会自动根据 textContainerInset、contentInset 来调整）
     */
    open var placeholderMargins: UIEdgeInsets = UIEdgeInsets.zero

    /**
     *   placeholder 的文字
     */
    @IBInspectable open var placeholder: String? {
        didSet {
            let attributes = Dictionary(uniqueKeysWithValues: convertFromNSAttributedStringKeyDictionary(typingAttributes).map {
                key, value in (key, value)
            })
            placeholderLabel.attributedText = NSAttributedString(string: placeholder ?? "", attributes: attributes)

            placeholderLabel.textColor = placeholderColor
            sendSubviewToBack(placeholderLabel)
            setNeedsLayout()
        }
    }

    /**
     *  placeholder 文字的颜色
     */
    @IBInspectable open var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    /// 重写 typingAttributes 的 setter 方法
    override open var typingAttributes: [NSAttributedString.Key: Any] {
        get {
            return convertFromNSAttributedStringKeyDictionary(super.typingAttributes)
        }
        set {
            super.typingAttributes = convertToNSAttributedStringKeyDictionary(newValue)
            updatePlaceholderStyle()
        }
    }

    override open var textColor: UIColor? {
        get {
            return super.textColor
        }
        set {
            super.textColor = newValue
            updatePlaceholderStyle()
        }
    }

    override open var textAlignment: NSTextAlignment {
        get {
            return super.textAlignment
        }
        set {
            super.textAlignment = newValue
            updatePlaceholderStyle()
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        guard !(placeholder?.isEmpty ?? true) else { return }
        
        let labelMargins = textContainerInset.concat(insets: placeholderMargins).concat(insets: UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5))
        let limitWidth = bounds.width - contentInset.horizontalValue - labelMargins.horizontalValue
        let limitHeight = bounds.height - contentInset.verticalValue - labelMargins.verticalValue
        var labelSize = placeholderLabel.sizeThatFits(CGSize(width: limitWidth, height: limitHeight))
        labelSize.height = fmin(limitHeight, labelSize.height)
        placeholderLabel.frame = CGRectFlat(labelMargins.left, labelMargins.top, limitWidth, labelSize.height)
    }

    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        updatePlaceholderLabelHidden()
    }
    
    private func updatePlaceholderLabelHidden() {
        if text?.isEmpty ?? true && !(placeholder?.isEmpty ?? true) {
            placeholderLabel.alpha = 1
        } else {
            placeholderLabel.alpha = 0
        }
    }
    
    private func updatePlaceholderStyle() {
        let placeholder = self.placeholder
        self.placeholder = placeholder // 触发文字样式的更新
    }

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKeyDictionary(_ input: [NSAttributedString.Key: Any]) -> [NSAttributedString.Key: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [NSAttributedString.Key: Any]) -> [NSAttributedString.Key: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (key, value)})
}
