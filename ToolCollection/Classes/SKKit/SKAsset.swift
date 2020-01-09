//
//  SKAsset.swift
//  ToolCollection
//
//  Created by Endless Summer on 2020/1/9.
//

import Foundation
import Photos
import MobileCoreServices

public enum SKAssetType: Int {
    case unknow // 未知类型的 Asset
    case image // 图片类型的 Asset
    case video // 视频类型的 Asset
    case audio // 音频类型的 Asset，仅被 PhotoKit 支持，因此只适用于 iOS 8.0
    @available(iOS 9.1, *)
    case livePhoto // Live Photo 类型的 Asset，仅被 PhotoKit 支持，因此只适用于 iOS 9.1
}

public enum SKAssetSubType {
    case unknow // 未知类型
    case image // 图片类型
    case gif   // GIF类型
    @available(iOS 9.1, *)
    case livePhoto // Live Photo 类型的 Asset，仅被 PhotoKit 支持，因此只适用于 iOS 9.1
}

/// 从 iCloud 请求 Asset 大图的状态
public enum SKAssetDownloadStatus {
    case succeed // 下载成功或资源本来已经在本地
    case downloading // 下载中
    case canceled // 取消下载
    case failed // 下载失败
}

public class SKAsset: NSObject {
    public private(set) var assetType: SKAssetType = .unknow
    
    public private(set) var assetSubType: SKAssetSubType = .unknow

    public private(set) var phAsset: PHAsset
    
    public private(set) var downloadStatus: SKAssetDownloadStatus = .failed // 从 iCloud 下载资源大图的状态
    
    public init(phAsset: PHAsset) {
        self.phAsset = phAsset
        
        switch phAsset.mediaType {
        case .image:
            assetType = .image
            let value = phAsset.value(forKey: "uniformTypeIdentifier")
            if value as? String == kUTTypeGIF as String {
                assetSubType = .gif
            } else {
                if #available(iOS 9.1, *) {
                    if (phAsset.mediaSubtypes.rawValue & PHAssetMediaSubtype.photoLive.rawValue) > 1 {
                        assetSubType = .livePhoto
                    } else {
                        assetSubType = .image
                    }
                } else {
                    assetSubType = .image
                }
            }
        case .video:
            assetType = .video
        case .audio:
            assetType = .audio
        default:
            assetType = .unknow
        }
        super.init()
    }

}
