//
//  PhotoOrVideoChatroomCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 29.7.2023.
//

import UIKit

extension ChatroomCell {
    
    func videoOrPhoto(message: Message) {
        
        appName = DataStore.shared.appName
//        diskPath = appName + "/chats/\(message.chatroomId)/images"
//        videoDiskPath = appName + "/chats/\(message.chatroomId)/videos"
        diskPath = appName + "/images"
        videoDiskPath = appName + "/videos"
        
        
        
        // if message is photoMessage
        if let photoObject = message.photoMessage {
            photoData = photoObject
            downloadImageVideoView.photoSizeInBytesLabel.text = photoObject.photoSizeInBytes
            if let savedOnDeviceId = photoObject.savedOnDeviceId {
    //            print("saved on device: ", savedOnDeviceId, deviceUinqueId)
                if deviceUinqueId  == savedOnDeviceId {
                    videoPlayView.alpha = 0
                    downloadImageVideoView.alpha = 0
                } else {
                    videoPlayView.alpha = 0
                    downloadImageVideoView.alpha = 1
                }
            } else {
                videoPlayView.alpha = 0
                downloadImageVideoView.alpha = 1
            }
                
            
            
            messageImage.LoadSaveDisplayImage(originalImageUrl: photoObject.photoUrl, placeHolderUrl: photoObject.placeHolderUrl, savePlaceHolder: true, folderName:  diskPath)
            
            setImageSize(size: photoObject.photoSizeInPX)
            
        }
        // else if message is a video message
        else if let videoObject = message.videoMessage {
            videoPhotoData = videoObject
            downloadImageVideoView.photoSizeInBytesLabel.text = videoObject.videoSizeInBytes
            
            if let savedOnDeviceId = videoObject.savedOnDeviceId {
    //            print("saved on device: ", savedOnDeviceId, deviceUinqueId)
                if deviceUinqueId  == savedOnDeviceId {
                    videoPlayView.alpha = 1
                    downloadImageVideoView.alpha = 0
                } else {
                    videoPlayView.alpha = 0
                    downloadImageVideoView.alpha = 1
                }
            } else {
                videoPlayView.alpha = 0
                downloadImageVideoView.alpha = 1
            }
            
            messageImage.LoadSaveDisplayImage(originalImageUrl: videoObject.videoImageUrl, placeHolderUrl: videoObject.videoPlaceHolderUrl, savePlaceHolder: true, folderName:  diskPath)
            
            setImageSize(size: videoObject.photoSizeInPX)
        }
    }
    
    
    
}
