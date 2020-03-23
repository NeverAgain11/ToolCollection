//
//  TextKitContext.swift
//  Cassowary
//
//  Created by nangezao on 2018/1/24.
//  Copyright © 2018年 nange. All rights reserved.
//
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

public struct TextContext{
    let layoutManager = NSLayoutManager()
    let textContainer = NSTextContainer()
    let textStorage = NSTextStorage()
    let constraintSize: CGSize
    
    public typealias TextKitLockedBlock = (NSLayoutManager,NSTextContainer, NSTextStorage)->()
    
    init(attributeText: NSAttributedString,
         lineBreakMode: NSLineBreakMode,
         maxNumberOfLines: Int,
         exclusionPaths: [UIBezierPath],
         constraintSize: CGSize) {
        
        // remove extra white space
        layoutManager.usesFontLeading = false
        textStorage.addLayoutManager(layoutManager)
        textStorage.setAttributedString(attributeText)
        
        textContainer.size = constraintSize
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines = maxNumberOfLines
        textContainer.exclusionPaths = exclusionPaths
        layoutManager.addTextContainer(textContainer)
        self.constraintSize = constraintSize
    }
    
    public func performBlockWithLockedComponent(_ block: TextKitLockedBlock){
        block(layoutManager,textContainer,textStorage)
    }
    
}
