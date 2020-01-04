//
//  SKLabel.swift
//  ToolCollection
//
//  Created by mac on 2020/1/4.
//

import Foundation

/**
* `QMUILabel`支持通过`contentEdgeInsets`属性来实现类似padding的效果。
*
*/
open class SKLabel: UILabel {
    /// 控制label内容的padding，默认为UIEdgeInsetsZero
    public var contentEdgeInsets: UIEdgeInsets = .zero
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let targetSize = CGSize(width: size.width - contentEdgeInsets.horizontalValue,
                                height: size.height - contentEdgeInsets.verticalValue)
        var retulet = super.sizeThatFits(targetSize)
        retulet.width += contentEdgeInsets.horizontalValue
        retulet.height += contentEdgeInsets.verticalValue
        return retulet
    }
    
    open override var intrinsicContentSize: CGSize {
        var preferredMaxLayoutWidth = self.preferredMaxLayoutWidth
        if preferredMaxLayoutWidth <= 0 {
            preferredMaxLayoutWidth = .greatestFiniteMagnitude
        }
        return self.sizeThatFits(CGSize(width: preferredMaxLayoutWidth, height: .greatestFiniteMagnitude))
    }
    
    override open func drawText(in rect: CGRect) {
        var drawRect = rect.inset(by: contentEdgeInsets)
        if numberOfLines == 1 {
            drawRect.setHeight(drawRect.height + contentEdgeInsets.top * 2)
        }
        super.drawText(in: drawRect)
    }
    
}
