//
//  UIApplication+SK.swift
//  ToolCollection
//
//  Created by ryeex on 2022/6/2.
//

import UIKit

extension UIWindow {
    
    public static var keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            if let key = UIApplication.shared.connectedScenes.flatMap({ ($0 as? UIWindowScene)?.windows ?? [] }).first(where: { $0.isKeyWindow }) {
                    return key
                }
            
            if UIApplication.shared.windows.isEmpty {
                guard let delegate = UIApplication.shared.delegate else { return nil }
                guard let window = delegate.window else { return nil }
                return window
                
            } else {
                return UIApplication.shared.windows.first
            }
            
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
