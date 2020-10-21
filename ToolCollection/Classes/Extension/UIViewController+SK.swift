//
//  UIViewController+SK.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/10/20.
//

import Foundation

extension UIViewController: SKKitCompatible {}

public extension SKKit where Base: UIViewController {
    
    //EZSE: Makes the UIViewController register tap events and hides keyboard when clicked somewhere in the ViewController.
    func hideKeyboardWhenTappedAround(cancelTouches: Bool = false) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.base, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = cancelTouches
        base.view.addGestureRecognizer(tap)
    }
    
}

extension UIViewController {
    
    //EZSE: Dismisses keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
