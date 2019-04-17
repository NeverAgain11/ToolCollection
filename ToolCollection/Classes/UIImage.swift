//
//  UIImage.swift
//  Common
//
//  Created by lsc on 27/02/2017.
//
//

import UIKit

extension UIImage: NamespaceWrappable {}

public extension TypeWrapperProtocol where WrappedType == UIImage {
    
    func tinted(color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(wrappedValue.size, false, 0.0)
        let rect = CGRect(x: 0, y: 0, width: wrappedValue.size.width, height: wrappedValue.size.height)
        wrappedValue.draw(in: rect)
        
        color.set()
        UIRectFillUsingBlendMode(rect, .sourceAtop)
        let tintImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return tintImage
    }
    
    func rotated(by rotationAngle: CGFloat) -> UIImage? {
        guard let cgImage = wrappedValue.cgImage else { return nil }
        
        let rotatedViewBox = UIView(frame: CGRect(origin: .zero, size: wrappedValue.size))
        rotatedViewBox.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        let size = rotatedViewBox.frame.size
        
        UIGraphicsBeginImageContextWithOptions(wrappedValue.size, false, 0.0)
        
        if let bitmap = UIGraphicsGetCurrentContext() {
            bitmap.translateBy(x: size.width / 2.0, y: size.height / 2.0)
            bitmap.rotate(by: rotationAngle)
            bitmap.scaleBy(x: 1.0, y: -1.0)
            
            let origin = CGPoint(x: -wrappedValue.size.width / 2.0, y: -wrappedValue.size.height / 2.0)
            
            bitmap.draw(cgImage, in: CGRect(origin: origin, size: wrappedValue.size))
        }
        
        if let newImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return newImage
        } else {
            UIGraphicsEndImageContext()
            return nil
        }
    }
    
}

public extension UIImage {
    
    static func color(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        return UIImage(cgImage: cgImage)
    }
    
}
