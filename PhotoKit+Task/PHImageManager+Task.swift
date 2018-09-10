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
        requestID = requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options, resultHandler: { (result, info) in
            if let info = info, let isCancelled = info[PHImageCancelledKey] as? Bool, isCancelled == true {
                taskSource.cancel()
                return
            }
            if let result = result {
                taskSource.set(result: (result, info))
                return
            }
            taskSource.set(error: PHImageManager_TaskError.failedToGetResult(info))
        })
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
            taskSource.set(error: PHImageManager_TaskError.failedToGetResult(info))
        })
        return taskSource.task
    }
    
    public func requestLivePhoto(with requestID: inout PHImageRequestID, for asset: PHAsset, targetSize: CGSize, contentMode: PHImageContentMode, options: PHLivePhotoRequestOptions?) -> Task<(PHLivePhoto, [AnyHashable : Any]?)> {
        let taskSource = TaskCompletionSource<(PHLivePhoto, [AnyHashable : Any]?)>()
        requestID = requestLivePhoto(for: asset, targetSize: targetSize, contentMode: contentMode, options: options, resultHandler: { (result, info) in
            if let info = info, let isCancelled = info[PHImageCancelledKey] as? Bool, isCancelled == true {
                taskSource.cancel()
                return
            }
            if let result = result {
                taskSource.set(result: (result, info))
                return
            }
            taskSource.set(error: PHImageManager_TaskError.failedToGetResult(info))
        })
        return taskSource.task
    }
    
    public func requestPlayerItem(with requestID: inout PHImageRequestID, forVideo asset: PHAsset, options: PHVideoRequestOptions?) -> Task<(AVPlayerItem, [AnyHashable : Any]?)> {
        let taskSource = TaskCompletionSource<(AVPlayerItem, [AnyHashable : Any]?)>()
        requestID = requestPlayerItem(forVideo: asset, options: options, resultHandler: { (result, info) in
            if let info = info, let isCancelled = info[PHImageCancelledKey] as? Bool, isCancelled == true {
                taskSource.cancel()
                return
            }
            if let result = result {
                taskSource.set(result: (result, info))
                return
            }
            taskSource.set(error: PHImageManager_TaskError.failedToGetResult(info))
        })
        return taskSource.task
    }
    
    public func requestExportSession(with requestID: inout PHImageRequestID, forVideo asset: PHAsset, options: PHVideoRequestOptions?, exportPreset: String) -> Task<(AVAssetExportSession, [AnyHashable : Any]?)> {
        let taskSource = TaskCompletionSource<(AVAssetExportSession, [AnyHashable : Any]?)>()
        requestID = requestExportSession(forVideo: asset, options: options, exportPreset: exportPreset, resultHandler: { (result, info) in
            if let info = info, let isCancelled = info[PHImageCancelledKey] as? Bool, isCancelled == true {
                taskSource.cancel()
                return
            }
            if let result = result {
                taskSource.set(result: (result, info))
                return
            }
            taskSource.set(error: PHImageManager_TaskError.failedToGetResult(info))
        })
        return taskSource.task
    }
    
    public func requestAVAsset(with requestID: inout PHImageRequestID, forVideo asset: PHAsset, options: PHVideoRequestOptions?) -> Task<(AVAsset, AVAudioMix?, [AnyHashable : Any]?)> {
        let taskSource = TaskCompletionSource<(AVAsset, AVAudioMix?, [AnyHashable : Any]?)>()
        requestID = requestAVAsset(forVideo: asset, options: options, resultHandler: { (asset, audioMix, info) in
            if let info = info, let isCancelled = info[PHImageCancelledKey] as? Bool, isCancelled == true {
                taskSource.cancel()
                return
            }
            if let asset = asset {
                taskSource.set(result: (asset, audioMix, info))
                return
            }
            taskSource.set(error: PHImageManager_TaskError.failedToGetResult(info))
        })
        return taskSource.task
    }
    
}

public enum PHImageManager_TaskError: Error {
    case failedToGetResult([AnyHashable : Any]?)
}
