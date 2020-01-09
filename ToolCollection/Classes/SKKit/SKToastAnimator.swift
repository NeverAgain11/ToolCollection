//
//  SKToastAnimator.swift
//  QMUI.swift
//
//  Created by 黄伯驹 on 2017/7/10.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

/**
 * `SKToastAnimatorDelegate`是所有`SKToastAnimator`或者其子类必须遵循的协议，是整个动画过程实现的地方。
 */
protocol SKToastAnimatorDelegate {
    func show(with completion: ((Bool) -> Void)?)

    func hide(with completion: ((Bool) -> Void)?)

    var isShowing: Bool { get }

    var isAnimating: Bool { get }
}

// TODO: 实现多种animation类型

enum SKToastAnimationType: Int {
    case fade = 0
    case zoom
    case slide
}

/**
 * `SKToastAnimator`可以让你通过实现一些协议来自定义ToastView显示和隐藏的动画。你可以继承`SKToastAnimator`，然后实现`SKToastAnimatorDelegate`中的方法，即可实现自定义的动画。SKToastAnimator默认也提供了几种type的动画：1、SKToastAnimationTypeFade；2、SKToastAnimationTypeZoom；3、SKToastAnimationTypeSlide；
 */
open class SKToastAnimator: NSObject {

    internal var _isShowing = false
    internal var _isAnimating = false

    /**
     * 初始化方法，请务必使用这个方法来初始化。
     *
     * @param toastView 要使用这个animator的SKToastView实例。
     */

    public init(toastView: SKToastView) {
        super.init()
        self.toastView = toastView
    }

    /**
     * 获取初始化传进来的SKToastView。
     */
    public private(set) var toastView: SKToastView?

    /**
     * 指定SKToastAnimator做动画的类型type。此功能暂时未实现，目前所有动画类型都是SKToastAnimationTypeFade。
     */
    private var animationType: SKToastAnimationType = .fade
}

extension SKToastAnimator: SKToastAnimatorDelegate {
    @objc func show(with completion: ((Bool) -> Void)?) {
        _isShowing = true
        _isAnimating = true

        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveOut, .beginFromCurrentState], animations: {
            self.toastView?.backgroundView?.alpha = 1.0
            self.toastView?.contentView?.alpha = 1.0
        }, completion: { finished in
            self._isAnimating = false
            completion?(finished)
        })
    }

    @objc func hide(with completion: ((Bool) -> Void)?) {
        _isShowing = false
        _isAnimating = true
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveOut, .beginFromCurrentState], animations: {
            self.toastView?.backgroundView?.alpha = 0.0
            self.toastView?.contentView?.alpha = 0.0
        }, completion: { finished in
            self._isAnimating = false
            completion?(finished)
        })
    }

    var isShowing: Bool {
        return _isShowing
    }

    var isAnimating: Bool {
        return _isAnimating
    }
}
