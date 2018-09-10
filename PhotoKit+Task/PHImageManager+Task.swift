//
//  PHImageManager+Task.swift
//  PhotoKit+Task
//
//  Created by 阿部 仁史 on 2018/09/10.
//  Copyright © 2018年 hitoshiabe. All rights reserved.
//

import Photos
import BoltsSwift

extension PHImageManager {
    
    public func requestImage(with requestID: inout PHImageRequestID, for asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHImageRequestOptions?) -> Task<(UIImage, [AnyHashable : Any]?)> {
        let taskSource = TaskCompletionSource<(UIImage, [AnyHashable : Any]?)>()
        
        requestID = requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { (image, info) in
            if let info = info, let isCancelled = info[PHImageCancelledKey] as? Bool, isCancelled == true {
                taskSource.cancel()
                return
            }
            if let image = image {
                taskSource.set(result: (image, info))
                return
            }
            taskSource.set(error: PHImageManager_TaskError.noImage)
        }
        
        return taskSource.task
    }
    
    public func requestImageData(with requestID: inout PHImageRequestID, for asset: PHAsset, options: PHImageRequestOptions?) -> Task<(Data, String?, UIImageOrientation, [AnyHashable : Any]?)> {
        let taskSource = TaskCompletionSource<(Data, String?, UIImageOrientation, [AnyHashable : Any]?)>()
        
        requestID = requestImageData(for: asset, options: options, resultHandler: { (imageData, dataUTI, orientation, info) in
            if let info = info, let isCancelled = info[PHImageCancelledKey] as? Bool, isCancelled == true {
                taskSource.cancel()
                return
            }
            if let imageData = imageData {
                taskSource.set(result: (imageData, dataUTI, orientation, info))
                return
            }
            taskSource.set(error: PHImageManager_TaskError.noData)
        })
        
        return taskSource.task
    }
    
}

public enum PHImageManager_TaskError: Error {
    case noImage, noData
}
