//
//  NSAttributedString+SK.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/9.
//

import Foundation

extension NSAttributedString: SKKitCompatible {}

public extension SKKit where Base == NSAttributedString {
    func image() -> UIImage? {
        let attributedString = self.base
        let stringSize = attributedString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil).size.sizeCeil
        UIGraphicsBeginImageContextWithOptions(stringSize, false, 0)
        guard UIGraphicsGetCurrentContext() != nil else { return nil }
        
        attributedString.draw(in: stringSize.rect)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
}

public extension SKKit where Base == NSMutableAttributedString {
    func image() -> UIImage? {
        return (self.base as NSAttributedString).sk.image()
    }
}
