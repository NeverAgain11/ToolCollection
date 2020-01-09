//
//  UINavigationController.swift
//  DifferenceKit
//
//  Created by mac on 2020/1/3.
//

import Foundation
import UIKit

@objc public protocol UINavigationControllerHoldBackHandlerProtocol: NSObjectProtocol {
    /// 是否可以`popViewController`，可以在这个返回里面做一些业务的判断，比如点击返回按钮的时候，如果输入框里面的文本没有满足条件的则可以弹alert并且返回NO
    @objc optional func shouldPopViewControllerByBackButtonOrPopGesture(_ byPopGesture: Bool) -> Bool
    
    /// 当自定义了`leftBarButtonItem`按钮之后，系统的手势返回就失效了。可以通过`forceEnableInteractivePopGestureRecognizer`来决定要不要把那个手势返回强制加回来。当 interactivePopGestureRecognizer.enabled = NO 或者当前`UINavigationController`堆栈的viewControllers小于2的时候此方法无效。
    @objc optional func forceEnableInterativePopGestureRecognizer() -> Bool
}

extension UINavigationController: SKSelfAware {
    public static func awake() {
        let clazz = UINavigationController.self
        
        ReplaceMethod(clazz, #selector(UINavigationController.viewDidLoad), #selector(UINavigationController.qmui_viewDidLoad))
        ReplaceMethod(clazz, #selector(UINavigationBarDelegate.navigationBar(_:shouldPop:)), #selector(UINavigationController.qmui_navigationBar(_:shouldPop:)))
        
    }
    
    
}

extension UINavigationController {

    private struct AssociatedKeys {
        static var tmp_topViewController = "tmp_topViewController"
        static var isPushingViewControllerKey = "isPushingViewControllerKey"
        static var isPoppingViewController = "isPoppingViewController"
        static var originGestureDelegateKey = "originGestureDelegateKey"
        static var isPoppingByGesture = "isPoppingByGesture"
    }
    
    var tmp_topViewController: UIViewController? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tmp_topViewController) as? UIViewController
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tmp_topViewController, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var isPoppingByGesture: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isPoppingByGesture) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isPoppingByGesture, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc func qmui_viewDidLoad() {
        qmui_viewDidLoad()
        
        objc_setAssociatedObject(self, &AssociatedKeys.originGestureDelegateKey, interactivePopGestureRecognizer?.delegate, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        interactivePopGestureRecognizer?.delegate = self
    }
    
    @objc func qmui_navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        
        // 如果nav的vc栈中有两个vc，第一个是root，第二个是second。这是second页面如果点击系统的返回按钮，topViewController获取的栈顶vc是second，而如果是直接代码写的pop操作，则获取的栈顶vc是root。也就是说只要代码写了pop操作，则系统会直接将顶层vc也就是second出栈，然后才回调的，所以这时我们获取到的顶层vc就是root了。然而不管哪种方式，参数中的item都是second的item。
        let isPopedByCoding = item != topViewController?.navigationItem
        isPoppingByGesture = false
        // !isPopedByCoding 要放在前面，这样当 !isPopedByCoding 不满足的时候就不会去询问 canPopViewController 了，可以避免额外调用 canPopViewController 里面的逻辑导致
        let canPop = !isPopedByCoding && canPopViewController(tmp_topViewController ?? topViewController)
        if canPop || isPopedByCoding {
            tmp_topViewController = nil
            return qmui_navigationBar(navigationBar, shouldPop: item)
        } else {
            resetSubviewsInNavBar(navigationBar)
            tmp_topViewController = nil
        }

        return false
    }
    
    private func resetSubviewsInNavBar(_ navBar: UINavigationBar) {
        if #available(iOS 11.0, *) {
            
        } else {
            for view in navBar.subviews {
                if view.alpha < 1.0 {
                    UIView.animate(withDuration: 0.25) {
                        view.alpha = 1.0
                    }
                }
            }
        }
    }
    
    private func canPopViewController(_ viewController: UIViewController?) -> Bool {
        var canPop = true
        
        if let vc = viewController as? UINavigationControllerHoldBackHandlerProtocol, let canPopViewController = vc.shouldPopViewControllerByBackButtonOrPopGesture?(self.isPoppingByGesture), !canPopViewController {
            canPop = false
        }
        
        return canPop
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == interactivePopGestureRecognizer {
            tmp_topViewController = topViewController
            isPoppingByGesture = true
            let canPop = canPopViewController(tmp_topViewController)
            
            if canPop {
                if let originGestureDelegate = objc_getAssociatedObject(self, &AssociatedKeys.originGestureDelegateKey) as? UIGestureRecognizerDelegate, (originGestureDelegate.gestureRecognizerShouldBegin != nil)  {
                    return originGestureDelegate.gestureRecognizerShouldBegin!(gestureRecognizer)
                } else {
                    return false
                }
            } else {
                return false
            }
        }
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer == interactivePopGestureRecognizer {
            if let originGestureDelegate = objc_getAssociatedObject(self, &AssociatedKeys.originGestureDelegateKey) as? UIGestureRecognizerDelegate {
                // 先判断要不要强制开启手势返回
                if viewControllers.count > 1, interactivePopGestureRecognizer?.isEnabled ?? false, let viewController = topViewController as? UINavigationControllerHoldBackHandlerProtocol,  viewController.forceEnableInterativePopGestureRecognizer != nil, viewController.forceEnableInterativePopGestureRecognizer!() {
                    return true
                }

                // 调用默认实现
                return originGestureDelegate.gestureRecognizer?(gestureRecognizer, shouldReceive: touch) ?? false
            }
        }
        return true
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == interactivePopGestureRecognizer {
            if let originGestureDelegate = objc_getAssociatedObject(self, &AssociatedKeys.originGestureDelegateKey) as? UIGestureRecognizerDelegate {
                return originGestureDelegate.gestureRecognizer?(gestureRecognizer, shouldRecognizeSimultaneouslyWith: otherGestureRecognizer) ?? false
            }
        }
        return false
    }

    // 是否要gestureRecognizer检测失败了，才去检测otherGestureRecognizer
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy _: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == interactivePopGestureRecognizer {
            // 如果只是实现了上面几个手势的delegate，那么返回的手势和当前界面上的scrollview或者其他存在的手势会冲突，所以如果判断是返回手势，则优先响应返回手势再响应其他手势。
            // 不知道为什么，系统竟然没有实现这个delegate，那么它是怎么处理返回手势和其他手势的优先级的
            return true
        }
        return false
    }
}

extension UIViewController: UINavigationControllerHoldBackHandlerProtocol {}
