//
//  UIImage+SK.swift
//  DifferenceKit
//
//  Created by Endless Summer on 2020/1/8.
//

import Foundation
import Photos

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

extension UIImage {
    
    ///生成二维码
    public class func generateQRCode(_ text: String, _ width:CGFloat, _ fillImage: UIImage? = nil, _ color: UIColor? = nil) -> UIImage? {
        
        //给滤镜设置内容
        guard let data = text.data(using: .utf8) else {
            return nil
        }
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            
            // 设置生成的二维码的容错率
            // value = @"L/M/Q/H"
            filter.setValue("H", forKey: "inputCorrectionLevel")
            
            //获取生成的二维码
            guard let outPutImage = filter.outputImage else {
                return nil
            }
            
            // 设置二维码颜色
            let colorFilter = CIFilter(name: "CIFalseColor", parameters: ["inputImage":outPutImage,"inputColor0":CIColor(cgColor: color?.cgColor ?? UIColor.black.cgColor),"inputColor1":CIColor(cgColor: UIColor.clear.cgColor)])
            
            //获取带颜色的二维码
            guard let newOutPutImage = colorFilter?.outputImage else {
                return nil
            }
            
            let scale = width/newOutPutImage.extent.width
            
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            
            let output = newOutPutImage.transformed(by: transform)
            
            let QRCodeImage = UIImage(ciImage: output)
            
            guard let fillImage = fillImage else {
                return QRCodeImage
            }
            
            let imageSize = QRCodeImage.size
            
            UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
            
            QRCodeImage.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            
            let fillRect = CGRect(x: (width - width/5)/2, y: (width - width/5)/2, width: width/5, height: width/5)
            
            fillImage.draw(in: fillRect)
            
            guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return QRCodeImage }
            
            UIGraphicsEndImageContext()
            
            return newImage
            
        }
        
        return nil
        
    }
    
    
    ///生成条形码
    public class func generateCode128(_ text:String, _ size:CGSize,_ color:UIColor? = nil ) -> UIImage?
    {
        //给滤镜设置内容
        guard let data = text.data(using: .utf8) else {
            return nil
        }
        
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            
            filter.setDefaults()
            
            filter.setValue(data, forKey: "inputMessage")
            
            //获取生成的条形码
            guard let outPutImage = filter.outputImage else {
                return nil
            }
            
            // 设置条形码颜色
            let colorFilter = CIFilter(name: "CIFalseColor", parameters: ["inputImage":outPutImage,"inputColor0":CIColor(cgColor: color?.cgColor ?? UIColor.black.cgColor),"inputColor1":CIColor(cgColor: UIColor.clear.cgColor)])
            
            //获取带颜色的条形码
            guard let newOutPutImage = colorFilter?.outputImage else {
                return nil
            }
            
            let scaleX:CGFloat = size.width/newOutPutImage.extent.width
            
            let scaleY:CGFloat = size.height/newOutPutImage.extent.height
            
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            
            let output = newOutPutImage.transformed(by: transform)
            
            let barCodeImage = UIImage(ciImage: output)
            
            return barCodeImage
            
        }
        
        return nil
    }
}
