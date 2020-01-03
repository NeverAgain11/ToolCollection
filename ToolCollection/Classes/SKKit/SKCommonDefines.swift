//
//  SKCommonDefines.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/3.
//

import Foundation

let ScreenScale = UIScreen.main.scale

/// MARK: - CGFloat

/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
func flatSpecificScale(_ value: CGFloat, _ scale: CGFloat) -> CGFloat {
    let s = scale == 0 ? ScreenScale : scale
    return ceil(value * s) / s
}

/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale
 */
func flat(_ value: CGFloat) -> CGFloat {
    return flatSpecificScale(value, 0)
}

extension CGFloat {
    /**
     *  某些地方可能会将 CGFLOAT_MIN 作为一个数值参与计算（但其实 CGFLOAT_MIN 更应该被视为一个标志位而不是数值），可能导致一些精度问题，所以提供这个方法快速将 CGFLOAT_MIN 转换为 0
     *  issue: https://github.com/QMUI/QMUI_iOS/issues/203
     */
    func removeFloatMin() -> CGFloat {
        return self == CGFloat.leastNormalMagnitude ? 0 : self
    }
    
    /**
     *  调整给定的某个 CGFloat 值的小数点精度，超过精度的部分按四舍五入处理。
     *
     *  例如 0.3333.fixed(2) 会返回 0.33，而 0.6666.fixed(2) 会返回 0.67
     *
     *  @warning 参数类型为 CGFloat，也即意味着不管传进来的是 float 还是 double 最终都会被强制转换成 CGFloat 再做计算
     *  @warning 该方法无法解决浮点数精度运算的问题
     */
    func fixed(_ precision: Int) -> CGFloat {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.maximumFractionDigits = precision
        var cgFloat:CGFloat = 0
        if let result = nf.string(from: NSNumber(value: Double(self))), let doubleValue = Double(result) {
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
    
    /// 用于居中运算
    func center(_ child: CGFloat) -> CGFloat {
        return flat((self - child) / 2.0)
    }
}

// MARK: - CGSize

extension CGSize {

    //    static var max: CGSize {
    //        return CGSize(width: CGFloat.infinity, height: CGFloat.infinity)
    //    }

    /// 返回一个x/y为0的CGRect
    var rect: CGRect {
        return CGRect(origin: .zero, size: self)
    }

    var center: CGPoint {
        return CGPoint(x: flat(width / 2.0), y: flat(height / 2.0))
    }

    /// 判断一个size是否为空（宽或高为0）
    var isEmpty: Bool {
        return width <= 0 || height <= 0
    }

    /// 将一个CGSize像素对齐
    var flatted: CGSize {
        return CGSize(width: flat(width), height: flat(height))
    }

    /// 将一个 CGSize 以 pt 为单位向上取整
    var sizeCeil: CGSize {
        return CGSize(width: ceil(width), height: ceil(height))
    }

    /// 将一个 CGSize 以 pt 为单位向下取整
    var sizeFloor: CGSize {
        return CGSize(width: floor(width), height: floor(height))
    }

    static var max: CGSize {
        return CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    }
    
    func fixed(_ precision: Int) -> CGSize {
        let width = self.width.fixed(precision)
        let height = self.height.fixed(precision)
        let result = CGSize(width: width, height: height)
        return result
    }
    
    func removeFloatMin() -> CGSize {
        let width = self.width.removeFloatMin()
        let height = self.height.removeFloatMin()
        let result = CGSize(width: width, height: height)
        return result
    }
}
// MARK: - CGRect

/// 创建一个像素对齐的CGRect
let CGRectFlat: (CGFloat, CGFloat, CGFloat, CGFloat) -> CGRect = { x, y, w, h in
    CGRect(x: flat(x), y: flat(y), width: flat(w), height: flat(h))
}

public extension CGRect {
    /// 通过 size 获取一个 x/y 为 0 的 CGRect
    static func rect(size: CGSize) -> CGRect {
        return CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
    /// 获取rect的center，包括rect本身的x/y偏移
    var center: CGPoint {
        return CGPoint(x: flat(midX), y: flat(midY))
    }
    
    /// 对CGRect的x/y、width/height都调用一次flat，以保证像素对齐
    var flatted: CGRect {
        return CGRect(x: flat(minX), y: flat(minY), width: flat(width), height: flat(height))
    }
    
    /// 判断一个 CGRect 是否存在NaN
    var isNaN: Bool {
        return self.origin.x.isNaN || self.origin.y.isNaN || self.size.width.isNaN || self.size.height.isNaN
    }
    
    /// 系统提供的 CGRectIsInfinite 接口只能判断 CGRectInfinite 的情况，而该接口可以用于判断 INFINITY 的值
    var isInf: Bool {
        return self.origin.x.isInfinite || self.origin.y.isInfinite || self.size.width.isInfinite || self.size.height.isInfinite
    }
    
    /// 判断一个 CGRect 是否合法（例如不带无穷大的值、不带非法数字）
    var isValidated: Bool {
        return !self.isNull && !self.isInfinite && !self.isNaN && !self.isInf
    }

    /// 为一个CGRect叠加scale计算
    func apply(scale: CGFloat) -> CGRect {
        return CGRect(x: minX * scale, y: minY * scale, width: width * scale, height: height * scale).flatted
    }

    /// 计算view的水平居中，传入父view和子view的frame，返回子view在水平居中时的x值
    func minXHorizontallyCenter(in parentRect: CGRect) -> CGFloat {
        return flat((parentRect.width - width) / 2.0)
    }

    /// 计算view的垂直居中，传入父view和子view的frame，返回子view在垂直居中时的y值
    func minYVerticallyCenter(in parentRect: CGRect) -> CGFloat {
        return flat((parentRect.height - height) / 2.0)
    }

    /// 返回值：同一个坐标系内，想要layoutingRect和已布局完成的referenceRect(self)保持垂直居中时，layoutingRect的originY
    func minYVerticallyCenter(_ layoutingRect: CGRect) -> CGFloat {
        return minY + layoutingRect.minYVerticallyCenter(in: self)
    }

    /// 返回值：同一个坐标系内，想要layoutingRect和已布局完成的referenceRect保持水平居中时，layoutingRect的originX
    func minXHorizontallyCenter(_ layoutingRect: CGRect) -> CGFloat {
        return minX + layoutingRect.minXHorizontallyCenter(in: self)
    }

    /// 为给定的rect往内部缩小insets的大小
    func insetEdges(_ insets: UIEdgeInsets) -> CGRect {
        let newX = minX + insets.left
        let newY = minY + insets.top
        let newWidth = width - insets.horizontalValue
        let newHeight = height - insets.verticalValue
        return CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
    }

    func float(top: CGFloat) -> CGRect {
        var result = self
        result.origin.y = top
        return result
    }

    func float(bottom: CGFloat) -> CGRect {
        var result = self
        result.origin.y = bottom - height
        return result
    }

    func float(right: CGFloat) -> CGRect {
        var result = self
        result.origin.x = right - width
        return result
    }

    func float(left: CGFloat) -> CGRect {
        var result = self
        result.origin.x = left
        return result
    }

    /// 保持rect的左边缘不变，改变其宽度，使右边缘靠在right上
    func limit(right: CGFloat) -> CGRect {
        var result = self
        result.size.width = right - minX
        return result
    }

    /// 保持rect右边缘不变，改变其宽度和origin.x，使其左边缘靠在left上。只适合那种右边缘不动的view
    /// 先改变origin.x，让其靠在offset上
    /// 再改变size.width，减少同样的宽度，以抵消改变origin.x带来的view移动，从而保证view的右边缘是不动的
    func limit(left: CGFloat) -> CGRect {
        var result = self
        let subOffset = left - minX
        result.origin.x = left
        result.size.width -= subOffset
        return result
    }

    /// 限制rect的宽度，超过最大宽度则截断，否则保持rect的宽度不变
    func limit(maxWidth: CGFloat) -> CGRect {
        var result = self
        result.size.width = width > maxWidth ? maxWidth : width
        return result
    }

    func setX(_ x: CGFloat) -> CGRect {
        var result = self
        result.origin.x = flat(x)
        return result
    }

    func setY(_ y: CGFloat) -> CGRect {
        var result = self
        result.origin.y = flat(y)
        return result
    }

    func setXY(_ x: CGFloat, _ y: CGFloat) -> CGRect {
        var result = self
        result.origin.x = flat(x)
        result.origin.y = flat(y)
        return result
    }

    func setWidth(_ width: CGFloat) -> CGRect {
        var result = self
        result.size.width = flat(width)
        return result
    }

    func setHeight(_ height: CGFloat) -> CGRect {
        var result = self
        result.size.height = flat(height)
        return result
    }

    func setSize(size: CGSize) -> CGRect {
        var result = self
        result.size = size.flatted
        return result
    }
    
    func fixed(_ precision: Int) -> CGRect {
        let x = self.origin.x.fixed(precision)
        let y = self.origin.y.fixed(precision)
        let width = self.width.fixed(precision)
        let height = self.height.fixed(precision)
        let result = CGRect(x: x, y: y, width: width, height: height)
        return result
    }
    
    func removeFloatMin() -> CGRect {
        let x = self.origin.x.removeFloatMin()
        let y = self.origin.y.removeFloatMin()
        let width = self.width.removeFloatMin()
        let height = self.height.removeFloatMin()
        let result = CGRect(x: x, y: y, width: width, height: height)
        return result
    }
}

// MARK: - UIEdgeInsets
extension UIEdgeInsets {
    /// 获取UIEdgeInsets在水平方向上的值
    var horizontalValue: CGFloat {
        return left + right
    }

    /// 获取UIEdgeInsets在垂直方向上的值
    var verticalValue: CGFloat {
        return top + bottom
    }

    /// 将两个UIEdgeInsets合并为一个
    func concat(insets: UIEdgeInsets) -> UIEdgeInsets {
        let top = self.top + insets.top
        let left = self.left + insets.left
        let bottom = self.bottom + insets.bottom
        let right = self.right + insets.right
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    func fixed(_ precision: Int) -> UIEdgeInsets {
        let top = self.top.fixed(precision)
        let left = self.left.fixed(precision)
        let bottom = self.bottom.fixed(precision)
        let right = self.right.fixed(precision)
        let result = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return result
    }
    
    func removeFloatMin() -> UIEdgeInsets {
        let top = self.top.removeFloatMin()
        let left = self.left.removeFloatMin()
        let bottom = self.bottom.removeFloatMin()
        let right = self.right.removeFloatMin()
        let result = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return result
    }
}
