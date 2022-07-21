//
//  UIButton+SK.swift
//  ToolCollection
//
//  Created by ryeex on 2022/7/21.
//

import Foundation
import UIKit

extension UIButton {
    @objc public func setTitle(_ title: String?, font: UIFont, textColor: UIColor, for state: UIControl.State) {
        setAttributedTitle(title?.attributedString().font(font).textColor(textColor), for: state)
    }
}
