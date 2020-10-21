//
//  SKLayout.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/10/20.
//

import UIKit

public extension SKKit where Base: UIView {
    //约束点属性
    @available(iOS 11.0, *)
    var safe_width: NSLayoutDimension  { get { return base.safeAreaLayoutGuide.widthAnchor }}
    @available(iOS 11.0, *)
    var safe_height: NSLayoutDimension  { get {return base.safeAreaLayoutGuide.heightAnchor} }
    @available(iOS 11.0, *)
    var safe_top: NSLayoutYAxisAnchor { get {return base.safeAreaLayoutGuide.topAnchor} }
    @available(iOS 11.0, *)
    var safe_bottom: NSLayoutYAxisAnchor { get {return base.safeAreaLayoutGuide.bottomAnchor} }
    @available(iOS 11.0, *)
    var safe_right: NSLayoutXAxisAnchor { get {return base.safeAreaLayoutGuide.rightAnchor}}
    @available(iOS 11.0, *)
    var safe_left: NSLayoutXAxisAnchor { get {return base.safeAreaLayoutGuide.leftAnchor}}
    @available(iOS 11.0, *)
    var safe_centerX: NSLayoutXAxisAnchor { get {return base.safeAreaLayoutGuide.centerXAnchor}}
    @available(iOS 11.0, *)
    var safe_centerY: NSLayoutYAxisAnchor { get {return base.safeAreaLayoutGuide.centerYAnchor}}
    @available(iOS 11.0, *)
    var safe_leading: NSLayoutXAxisAnchor { get {return base.safeAreaLayoutGuide.leadingAnchor}}
    @available(iOS 11.0, *)
    var safe_trailing: NSLayoutXAxisAnchor { get {return base.safeAreaLayoutGuide.trailingAnchor}}
    
    
    //MARK: **********************************************************************************************
    var width: NSLayoutDimension  { get {return base.widthAnchor} }
    
    var height: NSLayoutDimension  { get {return base.heightAnchor} }
    
    var top: NSLayoutYAxisAnchor { get {return base.topAnchor} }
    
    var bottom: NSLayoutYAxisAnchor { get {return base.bottomAnchor} }
    
    var right: NSLayoutXAxisAnchor { get {return base.rightAnchor} }
    
    var left: NSLayoutXAxisAnchor { get {return base.leftAnchor} }
    
    var centerX: NSLayoutXAxisAnchor { get {return base.centerXAnchor} }
    
    var centerY: NSLayoutYAxisAnchor { get {return base.centerYAnchor} }
    
    var leading: NSLayoutXAxisAnchor { get {return base.leadingAnchor} }
    
    var trailing: NSLayoutXAxisAnchor { get {return base.trailingAnchor} }
    
    var firstBaseline: NSLayoutYAxisAnchor { get {return base.firstBaselineAnchor} }
    
    var lastBaseline: NSLayoutYAxisAnchor { get {return base.lastBaselineAnchor} }
    
}

public extension SKKit where Base: UIView {
    
    //MARK: **********************************************************************************************
    //与一个视图上下左右重叠
    @discardableResult
    func edges(equalTo aView: UIView) -> SKKit {
        top(equalTo: aView.sk.top).leading(equalTo: aView.sk.leading).trailing(equalTo: aView.sk.trailing).bottom(equalTo: aView.sk.bottom)
        return self
    }
    
    //与一个视图约束并带insets
    @discardableResult
    func edges(equalTo aView: UIView, insets: UIEdgeInsets) -> SKKit {
        top(equalTo: aView.sk.top, constant: insets.top).trailing(equalTo: aView.sk.trailing, constant: -insets.right).leading(equalTo: aView.sk.leading, constant: insets.left).bottom(equalTo: aView.sk.bottom, constant: -insets.bottom)
        return self
    }
    
    //MARK: ****************************************UIView************************************************
    //MARK: 赋值宽高一个固定数值
    @discardableResult
    func setWidth(_ width: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.widthAnchor.constraint(equalToConstant: width).active()
        return self
    }
    @discardableResult
    func setHeight(_ height: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.heightAnchor.constraint(equalToConstant: height).active()
        return self
    }
    //MARK: 约束一个Anchor
    @discardableResult
    func width(equalTo aAnchor: NSLayoutDimension) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.widthAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    @discardableResult
    func height(equalTo aAnchor: NSLayoutDimension) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.heightAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    @discardableResult
    func top(equalTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.topAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    @discardableResult
    func bottom(equalTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.bottomAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    @discardableResult
    func left(equalTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.leftAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    @discardableResult
    func right(equalTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.rightAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    @discardableResult
    func leading(equalTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.leadingAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    @discardableResult
    func trailing(equalTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.trailingAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    @discardableResult
    func centerX(equalTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.centerXAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    @discardableResult
    func centerY(equalTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.centerYAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    @discardableResult
    func firstBaseline(equalTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.firstBaselineAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    @discardableResult
    func lastBaseline(equalTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.lastBaselineAnchor.constraint(equalTo: aAnchor).active()
        return self
    }
    //MARK: 约束一个Anchor和constant
    @discardableResult
    func width(equalTo aAnchor: NSLayoutDimension, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.widthAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func height(equalTo aAnchor: NSLayoutDimension, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.heightAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func top(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.topAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func bottom(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.bottomAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func left(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.leftAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func right(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.rightAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func leading(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.leadingAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func trailing(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.trailingAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func centerX(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.centerXAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func centerY(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.centerYAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func firstBaseline(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.firstBaselineAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func lastBaseline(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.lastBaselineAnchor.constraint(equalTo: aAnchor, constant: constant).active()
        return self
    }
    //MARK: lessThanOrEqualTo
    @discardableResult
    func width(lessThanOrEqualTo aAnchor: NSLayoutDimension) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.widthAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func height(lessThanOrEqualTo aAnchor: NSLayoutDimension) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.heightAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func top(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.topAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func bottom(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.bottomAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func left(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.leftAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func right(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.rightAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func leading(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.leadingAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func trailing(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.trailingAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func centerX(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.centerXAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func centerY(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.centerYAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func firstBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.firstBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func lastBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.lastBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor).active()
        return self
    }
    //MARK: lessThanOrEqualTo 和 constant
    @discardableResult
    func width(lessThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.widthAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func height(lessThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.heightAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func top(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.topAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func bottom(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.bottomAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func left(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.leftAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func right(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.rightAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func leading(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.leadingAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func trailing(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.trailingAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func centerX(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.centerXAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func centerY(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.centerYAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func firstBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.firstBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func lastBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.lastBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    
    
    
    //MARK: greaterThanOrEqualTo
    @discardableResult
    func width(greaterThanOrEqualTo aAnchor: NSLayoutDimension) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.widthAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func height(greaterThanOrEqualTo aAnchor: NSLayoutDimension) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.heightAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func top(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.topAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func bottom(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.bottomAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func left(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.leftAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func right(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.rightAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func leading(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.leadingAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func trailing(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.trailingAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func centerX(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.centerXAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func centerY(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.centerYAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func firstBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.firstBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    @discardableResult
    func lastBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.lastBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor).active()
        return self
    }
    //MARK: lessThanOrEqualTo 和 constant
    @discardableResult
    func width(greaterThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.widthAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func height(greaterThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.heightAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func top(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.topAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func bottom(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.bottomAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func left(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.leftAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func right(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.rightAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func leading(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.leadingAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func trailing(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.trailingAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func centerX(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.centerXAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func centerY(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.centerYAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func firstBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.firstBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    @discardableResult
    func lastBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.lastBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant).active()
        return self
    }
    //MARK: width 和 height 约束的倍数
    @discardableResult
    func width(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.widthAnchor.constraint(equalTo: aAnchor, multiplier: multiplier).active()
        return self
    }
    @discardableResult
    func height(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.heightAnchor.constraint(equalTo: aAnchor, multiplier: multiplier).active()
        return self
    }
    //MARK: width 和 height 约束的倍数 以及常量
    @discardableResult
    func width(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.widthAnchor.constraint(equalTo: aAnchor, multiplier: multiplier, constant: constant).active()
        return self
    }
    @discardableResult
    func height(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat) -> SKKit {
        base.translatesAutoresizingMaskIntoConstraints = false
        base.heightAnchor.constraint(equalTo: aAnchor, multiplier: multiplier, constant: constant).active()
        return self
    }
    //MARK: **********************************************************************************************
    //MARK: ****************************************NSLayoutConstraint************************************
    private
    func setLayout(constraint: NSLayoutConstraint, with priority: UILayoutPriority) {
        constraint.priority = priority
        constraint.active()
    }
    //MARK:NSLayoutConstraint赋值一个固定数值
    @discardableResult
    func setWidth(_ width: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.widthAnchor.constraint(equalToConstant: width), with: priority)
        return self
    }
    @discardableResult
    func setHeight(_ height: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.heightAnchor.constraint(equalToConstant: height), with: priority)
        return self
    }
    //MARK:NSLayoutConstraint约束一个Anchor
    @discardableResult
    func setWidth(equalTo aAnchor: NSLayoutDimension, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.widthAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setHeight(equalTo aAnchor: NSLayoutDimension, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.heightAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setTop(equalTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.topAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setBottom(equalTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.bottomAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setLeft(equalTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.leftAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setRight(equalTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.rightAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setLeading(equalTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.leadingAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setTrailing(equalTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.trailingAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setCenterX(equalTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.centerXAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setCenterY(equalTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.centerYAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setFirstBaseline(equalTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.firstBaselineAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setLastBaseline(equalTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.lastBaselineAnchor.constraint(equalTo: aAnchor), with: priority)
        return self
    }
    //MARK: NSLayoutConstraint约束一个Anchor和constant
    @discardableResult
    func setWidth(equalTo aAnchor: NSLayoutDimension, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.widthAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setHeight(equalTo aAnchor: NSLayoutDimension, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.heightAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setTop(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.topAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setBottom(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.bottomAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setLeft(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.leftAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setRight(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.rightAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setLeading(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.leadingAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setTrailing(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.trailingAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setCenterX(equalTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.centerXAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setCenterY(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.centerYAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setFirstBaseline(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.firstBaselineAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setLastBaseline(equalTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.lastBaselineAnchor.constraint(equalTo: aAnchor, constant: constant), with: priority)
        return self
    }
    //MARK: NSLayoutConstraint lessThanOrEqualTo
    @discardableResult
    func setWidth(lessThanOrEqualTo aAnchor: NSLayoutDimension, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.widthAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setHeight(lessThanOrEqualTo aAnchor: NSLayoutDimension, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.heightAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setTop(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.topAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setBottom(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.bottomAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setLeft(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.leftAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setRight(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.rightAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setLeading(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.leadingAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setTrailing(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.trailingAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setCenterX(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.centerXAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setCenterY(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.centerYAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setFirstBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.firstBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setLastBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.lastBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    //MARK: NSLayoutConstraint lessThanOrEqualTo 和 constant
    @discardableResult
    func setWidth(lessThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.widthAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setHeight(lessThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.heightAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setTop(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.topAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setBottom(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.bottomAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setLeft(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.leftAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setRight(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.rightAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setLeading(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.leadingAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setTrailing(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.trailingAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setCenterX(lessThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.centerXAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setCenterY(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.centerYAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setFirstBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.firstBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setLastBaseline(lessThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.lastBaselineAnchor.constraint(lessThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    
    //MARK: NSLayoutConstraint greaterThanOrEqualTo
    @discardableResult
    func setWidth(greaterThanOrEqualTo aAnchor: NSLayoutDimension, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.widthAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setHeight(greaterThanOrEqualTo aAnchor: NSLayoutDimension, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.heightAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setTop(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.topAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setBottom(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.bottomAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setLeft(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.leftAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setRight(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.rightAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setLeading(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.leadingAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setTrailing(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.trailingAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setCenterX(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.centerXAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setCenterY(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.centerYAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setFirstBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.firstBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    @discardableResult
    func setLastBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.lastBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor), with: priority)
        return self
    }
    //MARK: NSLayoutConstraint lessThanOrEqualTo 和 constant
    @discardableResult
    func setWidth(greaterThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.widthAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setHeight(greaterThanOrEqualTo aAnchor: NSLayoutDimension, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.heightAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setTop(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.topAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setBottom(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.bottomAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setLeft(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.leftAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setRight(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.rightAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setLeading(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.leadingAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setTrailing(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.trailingAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setCenterX(greaterThanOrEqualTo aAnchor: NSLayoutXAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.centerXAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setCenterY(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.centerYAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setFirstBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.firstBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    @discardableResult
    func setLastBaseline(greaterThanOrEqualTo aAnchor: NSLayoutYAxisAnchor, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.lastBaselineAnchor.constraint(greaterThanOrEqualTo: aAnchor, constant: constant), with: priority)
        return self
    }
    //MARK: NSLayoutConstraint width 和 height 约束的倍数
    @discardableResult
    func setWidth(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.widthAnchor.constraint(equalTo: aAnchor, multiplier: multiplier), with: priority)
        return self
    }
    @discardableResult
    func setHeight(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.heightAnchor.constraint(equalTo: aAnchor, multiplier: multiplier), with: priority)
        return self
    }
    //MARK: NSLayoutConstraint width 和 height 约束的倍数 以及常量
    @discardableResult
    func setWidth(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.widthAnchor.constraint(equalTo: aAnchor, multiplier: multiplier, constant: constant), with: priority)
        return self
    }
    
    @discardableResult
    func setHeight(equalTo aAnchor: NSLayoutDimension, multiplier: CGFloat, constant: CGFloat, priority: UILayoutPriority) -> SKKit {
        setLayout(constraint: base.heightAnchor.constraint(equalTo: aAnchor, multiplier: multiplier, constant: constant), with: priority)
        return self
    }
    
}

extension NSLayoutConstraint {
    func active() {
        isActive = true
    }
}

