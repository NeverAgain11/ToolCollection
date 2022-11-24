//
//  UIViewController+SK.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/10/20.
//

import Foundation

//extension UIViewController: SKKitCompatible {}

public extension SKKit where Base: UIViewController {
    
    //EZSE: Makes the UIViewController register tap events and hides keyboard when clicked somewhere in the ViewController.
    func hideKeyboardWhenTappedAround(cancelTouches: Bool = false) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.base, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = cancelTouches
        base.view.addGestureRecognizer(tap)
    }
    
    /// 某些情况下，需要跳转下一个页面的时候同时移除当前页面。
    func popThenPush(_ controller: UIViewController, popCount: Int = 1) {
        var controllers = base.navigationController?.viewControllers ?? []
        var count = popCount
        while count > 0 {
            _ = controllers.popLast()
            count -= 1
        }
        controllers.append(controller)
        
        base.navigationController?.setViewControllers(controllers, animated: true)
    }
}

extension UIViewController {
    
    //EZSE: Dismisses keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
