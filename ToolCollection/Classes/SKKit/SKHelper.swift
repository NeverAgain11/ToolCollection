//
//  SKHelper.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/3.
//

import Foundation

public class SKHelper: NSObject {
    static let pixelOne: CGFloat = {
        return 1 / UIScreen.main.scale
    }()
    
    static let isSimulator: Bool = {
        #if TARGET_OS_SIMULATOR
            return true
        #else
            return false
        #endif
    }()
    
    static let isIPad: Bool = {
        // [[[UIDevice currentDevice] model] isEqualToString:@"iPad"] 无法判断模拟器，改为以下方式
        return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad
    }()

}
