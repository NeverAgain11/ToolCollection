//
//  SKTips.swift
//  QMUI.swift
//
//  Created by 黄伯驹 on 2017/7/10.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

// 自动计算秒数的标志符，在 delay 里面赋值 SKTipsAutomaticallyHideToastSeconds 即可通过自动计算 tips 消失的秒数
public let SKTipsAutomaticallyHideToastSeconds: TimeInterval = -1

/// 默认的 parentView
public var DefaultTipsParentView: UIView {
    return UIApplication.shared.delegate!.window!!
}

/**
 * 简单封装了 SKToastView，支持弹出纯文本、loading、succeed、error、info 等五种 tips。如果这些接口还满足不了业务的需求，可以通过 SKTips 的分类自行添加接口。
 * 注意用类方法显示 tips 的话，会导致父类的 willShowBlock 无法正常工作，具体请查看 willShowBlock 的注释。
 * @see [SKToastView willShowBlock]
 */

open class SKTips: SKToastView {

    private var contentCustomView: UIView?

    /// 实例方法：需要自己addSubview，hide之后不会自动removeFromSuperView

    public func show(text: String?,
              detailText: String? = nil,
              hideAfterDelay delay: TimeInterval = SKTipsAutomaticallyHideToastSeconds) {
        contentCustomView = nil
        showTip(text: text,
                detailText: detailText,
                hideAfterDelay: delay)
    }

    public func showLoading(text: String? = nil,
                     detailText: String? = nil,
                     hideAfterDelay delay: TimeInterval = SKTipsAutomaticallyHideToastSeconds) {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.startAnimating()
        contentCustomView = indicator
        showTip(text: text,
                detailText: detailText,
                hideAfterDelay: delay)
    }
    
    private func showTip(text: String?,
                         detailText: String?,
                         hideAfterDelay delay: TimeInterval) {

        guard let contentView = contentView as? SKToastContentView else {
            return
        }
        
        contentView.customView = contentCustomView
        contentView.textLabelText = text ?? ""
        contentView.detailTextLabelText = detailText ?? ""
        
        show(animated: true)
        
        if delay == SKTipsAutomaticallyHideToastSeconds {
            hide(animated: true, afterDelay: SKTips.smartDelaySeconds(for: text ?? ""))
        } else if delay > 0 {
            hide(animated: true, afterDelay: delay)
        }
    }

    /// 类方法：主要用在局部一次性使用的场景，hide之后会自动removeFromSuperView
    
    static public func createTips(to view: UIView) -> SKTips {
        let tips = SKTips(view: view)
        view.addSubview(tips)
        tips.removeFromSuperViewWhenHide = true
        return tips
    }

    @discardableResult
    static public func show(text: String?,
                     detailText: String? = nil,
                     in view: UIView = DefaultTipsParentView,
                     hideAfterDelay delay: TimeInterval = SKTipsAutomaticallyHideToastSeconds) -> SKTips {
        let tips = createTips(to: view)
        tips.show(text: text,
                  detailText: detailText,
                  hideAfterDelay: delay)
        return tips
    }

    @discardableResult
    static public func showLoading(text: String? = nil,
                            detailText: String? = nil,
                            in view: UIView = DefaultTipsParentView,
                            hideAfterDelay delay: TimeInterval = SKTipsAutomaticallyHideToastSeconds) -> SKTips {
        let tips = createTips(to: view)
        tips.showLoading(text: text,
                         detailText: detailText,
                         hideAfterDelay: delay)
        return tips
    }
    
    /// 隐藏 tips
    static public func hideAllTips(in view: UIView) {
        SKTips.hideAllToast(in: view, animated: true)
    }
    
    static public func hideAllTips() {
        SKTips.hideAllToast(in: DefaultTipsParentView, animated: true)
    }
    
    static func smartDelaySeconds(for tipsText: String) -> TimeInterval {
        let length = tipsText.qmui_lengthWhenCountingNonASCIICharacterAsTwo
        if length <= 20 {
            return 1.5
        } else if length <= 40 {
            return 2.0
        } else if length <= 50 {
            return 2.5
        } else {
            return 3.0
        }
    }
}

extension String {
    var qmui_lengthWhenCountingNonASCIICharacterAsTwo: Int {
        func isChinese(_ char: Character) -> Bool {
            return "\u{4E00}" <= char && char <= "\u{9FA5}"
        }
        
        var characterLength = 0
        for char in self {
            if isChinese(char) {
                characterLength += 2
            } else {
                characterLength += 1
            }
        }

        return characterLength
    }

}
