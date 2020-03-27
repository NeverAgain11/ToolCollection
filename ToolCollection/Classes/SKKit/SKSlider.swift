//
//  SKSlider.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/9.
//

import Foundation

/**
 *  相比系统的 UISlider，支持：
 *  1. 修改背后导轨的高度
 *  2. 修改圆点的大小
 *  3. 修改圆点的阴影样式
 */
public class SKSlider: UISlider {

    /// 背后导轨的高度，默认为 0，表示使用系统默认的高度。
    @IBInspectable public var trackHeight: CGFloat = 0
    
    // MARK: Override
    override public func trackRect(forBounds bounds: CGRect) -> CGRect {
        var result = super.trackRect(forBounds: bounds)
        if trackHeight == 0 {
            return result
        }
        
        result = result.setHeight(trackHeight)
        result = result.setY(bounds.height.center(result.height))
        return result
    }

}
