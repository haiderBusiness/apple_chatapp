//
//  messageroom+setup.swift
//  Swift_UIKit_messageApp
//
//  Created by Al-Tameemi Hayder on 28.6.2023.
//

import UIKit


extension ChatroomCell {

    func setup( message:Message, isSelecting: Bool ) {


        isAuth = message.senderId == DataStore.shared.user.id ? true : false

        messageTime.text = getTimeStampTime(date: message.createdAt)

//        if let image = message.photoMessage {
//            messageImage.load(urlString: image)
//        }


        if let _ = message.photoMessage, let textMessage = message.textMessage {
            
            
            videoOrPhoto(message: message)
//            appName = DataStore.shared.appName
//            diskPath = appName + "/chats/\(message.chatroomId)/images"
//
//            photoData = photoObject
//
//            downloadImageVideoView.photoSizeInBytesLabel.text = photoData!.photoSizeInBytes
//
//            let deviceUinqueId = DataStore.shared.deviceUniqueIdentifier
//            if let savedOnDeviceId = photoData?.savedOnDeviceId {
//    //            print("saved on device: ", savedOnDeviceId, deviceUinqueId)
//                if deviceUinqueId  == savedOnDeviceId {
//                    downloadImageVideoView.alpha = 0
//                } else {
//                    downloadImageVideoView.alpha = 1
//                }
//            }
//
//            messageImage.LoadSaveDisplayImage(originalImageUrl: message.photoMessage!.photoUrl, placeHolderUrl: message.photoMessage!.placeHolderUrl, savePlaceHolder: true, folderName:  diskPath)
//
//            setImageSize(size: message.photoMessage!.photoSizeInPX)
            
//            self.setImageSize()
//            messageImage.load(urlString: photoObject.photoUrl) {
////                if !self.imageSizeIsSet {
////                    self.setImageSize()
////                }
//            }
            
            
            
//            if let image = GetImageFromUrl.load(urlString: photoObject.photoUrl) {
//                print("there is image: ", image)
//                messageImage.image = image
//                self.setImageSize()
//            }

            
//            let uiImage = UIImage(named: image)
//
//            let data = uiImage?.compress(to: 5)
//
//            messageImage.image = UIImage(data: data!)
            
            
//            if let imageData = uiImage!.jpegData(compressionQuality: 0.2) {
//                // Use the compressed image data here
//                messageImage.image = UIImage(data: imageData)
//            }
            
//            setImageSize(id: message.id)
//            fixImageSize()
//            adjustImageViewFrame()
//            messageImageViewWidth = messageImage.frame.size.width
        

//            setImageSize(receivedImageView: messageImage)

            messageTextLabel.text = textMessage

            messageBubbleTopToImage?.isActive = true

            messageImageBottomToTextMessage?.isActive = true


            setMessageTimeDefault()


        }
        
        else if let _ = message.photoMessage {
            
            videoOrPhoto(message: message)
            
//            photoData = photoObject
//
//
//
//            downloadImageVideoView.photoSizeInBytesLabel.text = photoData!.photoSizeInBytes
//
//            let deviceUinqueId = DataStore.shared.deviceUniqueIdentifier
//            if let savedOnDeviceId = photoData?.savedOnDeviceId {
//    //            print("saved on device: ", savedOnDeviceId, deviceUinqueId)
//                if deviceUinqueId  == savedOnDeviceId {
//                    downloadImageVideoView.alpha = 0
//                } else {
//                    downloadImageVideoView.alpha = 1
//                }
//            }
//
//            messageImage.LoadSaveDisplayImage(originalImageUrl: message.photoMessage!.photoUrl, placeHolderUrl: message.photoMessage!.placeHolderUrl, savePlaceHolder: true, folderName:  diskPath)
//
//            setImageSize(size: message.photoMessage!.photoSizeInPX)
            
//            self.setImageSize()
//            messageImage.load(urlString: photoObject.photoUrl) {
////                if !self.imageSizeIsSet {
////                    self.setImageSize()
////                }
//            }
//            print("messageImage: ", messageImage.image)
//            if let image = GetImageFromUrl.load(urlString: photoObject.photoUrl) {
//                print("there is image: ", image)
//                messageImage.image = image
//                self.setImageSize()
//            }
            
//            let uiImage = UIImage(named: image)
//
//            let data = uiImage?.compress(to: 5)
//
//            messageImage.image = UIImage(data: data!)
            
            
            
//            setImageSize(id: message.id)
//            fixImageSize()
//            adjustImageViewFrame()
            //setImageSize(receivedImageView: messageImage)
            
            messageBubbleTopToImage?.isActive = true
            //messageTextbottomToTime?.isActive = false
            //messageTextBottom?.isActive = true

            setMessageWithBackground()
            
            //messageImage
            messageImageBottomToBubbleView?.isActive = true

        }
        
        else if let videoObject = message.videoMessage, let textMessage = message.textMessage {
            
            messageImage.load(urlString: videoObject.videoPlaceHolderUrl)
            videoOrPhoto(message: message)
//            setImageSize()

            messageTextLabel.text = textMessage

            messageBubbleTopToImage?.isActive = true

            messageImageBottomToTextMessage?.isActive = true


            setMessageTimeDefault()
        }
        
        else if let videoObject = message.videoMessage {
            
            messageImage.load(urlString: videoObject.videoPlaceHolderUrl)
            videoOrPhoto(message: message)
            
//            setImageSize()

            messageBubbleTopToImage?.isActive = true
            setMessageWithBackground()
            
            messageImageBottomToBubbleView?.isActive = true

        }
        
        else if let location = message.locationMessage, let textMessage = message.textMessage {

            messageTextLabel.text = textMessage

            setMapConstraints()
            messageLocationMapView.setMapLocation(location: location)
            messageLocationMapView.centerMap()

            messageLocationHeightConstraint?.isActive = true
            messageLocationWidthConstraint?.isActive = true

            messageLocationBottomToTextMessage?.isActive = true

            messageTextTopToLocation?.isActive = true

            setMessageTimeDefault()

            messageBubbleTopToMapView?.isActive = true
        }
        
        else if let location = message.locationMessage {
            setMapConstraints()
            
            messageLocationMapView.setMapLocation(location: location)
            messageLocationMapView.centerMap()
            //messageLocationMapView.setMapLocation(location: location)

            messageBubbleTopToMapView?.isActive = true
            messageLocationHeightConstraint?.isActive = true
            messageLocationWidthConstraint?.isActive = true
            messageLocationBottomToBubbleView?.isActive = true
            setMessageWithBackground()

        }
        
        else if let textMessage  = message.textMessage {

            messageTextLabel.text = textMessage

            messageBubbleTopToTextMessage?.isActive = true
            
            //messageTextBottom?.isActive = true
            setMessageTimeDefault()

            messageTextDefaultTop?.isActive = true
        }


    }






    func setMessageTimeDefault() {
        messageTimeBackground.alpha = 0
        if isAuth {
            messageTime.textColor = .white
            messageTime.alpha = 0.68
        } else {
            messageTime.textColor = .lightGray
            messageTime.alpha = 1
        }
    }


    func setMessageWithBackground() {
        messageTimeBackground.alpha = 0.3
        messageTime.alpha = 1
        messageTime.textColor = .white
    }
    
    func onClick() {
        
    }


}
