//
//  NSAttributedString+SK.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/9.
//

import Foundation

extension NSAttributedString: SKKitCompatible {}

public extension SKKit where Base: NSAttributedString {
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

public extension NSAttributedString {
    func height(containerWidth: CGFloat) -> CGFloat {

        let rect = self.boundingRect(with: CGSize.init(width: containerWidth, height: CGFloat.greatestFiniteMagnitude),
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     context: nil)
        return ceil(rect.size.height)
    }
    
    func width(containerHeight: CGFloat) -> CGFloat {
        let rect = self.boundingRect(with: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height: containerHeight),
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     context: nil)
        return ceil(rect.size.width)
    }
}
