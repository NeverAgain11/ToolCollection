//
//  UIView+SK.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/8.
//

import Foundation

//extension UIView: SKKitCompatible {}
extension UIResponder: SKKitCompatible {}

public extension UIView {
    
    /// 性能较差
    func sk_snapshotLayerImage() -> UIImage? {
        return self.sk.snapshotLayerImage()
    }
    
    /// 界面要已经render完，否则截到得图将会是empty
    func sk_snapshotImage(afterScreenUpdates: Bool) -> UIImage? {
        return self.sk.snapshotImage(afterScreenUpdates: afterScreenUpdates)
    }
}

public extension SKKit where Base: UIView {
    /// 性能较差
    func snapshotLayerImage() -> UIImage? {
        let view = self.base
        // 如果可以用新方式，则建议使用新方式，性能上好很多
        var resultImage: UIImage?
        // 第二个参数是不透明度，这里默认设置为YES，不用出来alpha通道的事情，可以提高性能
        // 第三个参数是scale，设置为0的时候，意思是使用屏幕的scale
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        view.layer.render(in: context)
        resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    /// 界面要已经render完，否则截到得图将会是empty
    func snapshotImage(afterScreenUpdates: Bool) -> UIImage? {
        let view = self.base
        var resultImage: UIImage?
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0)
        
        view.drawHierarchy(in: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), afterScreenUpdates: afterScreenUpdates)
        resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: base.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        base.layer.mask = mask
    }
}
