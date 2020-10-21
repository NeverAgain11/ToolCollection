//
//  UIImage+SK.swift
//  DifferenceKit
//
//  Created by Endless Summer on 2020/1/8.
//

import Foundation

extension UIImage: SKKitCompatible {}

public extension SKKit where Base: UIImage {
    
    /// 将文字渲染成图片，最终图片和文字一样大
    static func image(attributedString: NSAttributedString) -> UIImage? {
        
        let stringSize = attributedString.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil).size.sizeCeil
        UIGraphicsBeginImageContextWithOptions(stringSize, false, 0)
        guard UIGraphicsGetCurrentContext() != nil else { return nil }
        
        attributedString.draw(in: stringSize.rect)
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    func image(spacingExtensionInsets: UIEdgeInsets) -> UIImage? {
        return self.base.image(spacingExtensionInsets: spacingExtensionInsets)
    }
}

fileprivate extension UIImage {
    
    /// 在当前图片的上下左右增加一些空白（不支持负值），通常用于调节NSAttributedString里的图片与文字的间距
    func image(spacingExtensionInsets: UIEdgeInsets) -> UIImage? {
        let contextSize = CGSize(width: size.width + spacingExtensionInsets.horizontalValue, height: size.height + spacingExtensionInsets.verticalValue)
        UIGraphicsBeginImageContextWithOptions(contextSize, qmui_opaque, scale)
        draw(at: CGPoint(x: spacingExtensionInsets.left, y: spacingExtensionInsets.top))
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage
    }
    
    /**
     *  判断一张图是否不存在 alpha 通道，注意 “不存在 alpha 通道” 不等价于 “不透明”。一张不透明的图有可能是存在 alpha 通道但 alpha 值为 1。
     */
    var qmui_opaque: Bool {
        let alphaInfo = cgImage!.alphaInfo
        let opaque = alphaInfo == .noneSkipLast
            || alphaInfo == .noneSkipFirst
            || alphaInfo == .none
        return opaque
    }

}
