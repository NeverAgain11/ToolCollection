//
//  SKAssetsManager.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/8.
//

import Foundation
import Photos

public class SKAssetsManager: NSObject {
    static public let shared = SKAssetsManager()
    
    public lazy var phCachingImageManager = PHCachingImageManager()
    
}
