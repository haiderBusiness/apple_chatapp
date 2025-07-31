////
////  messageroom+setup.swift
////  Swift_UIKit_messageApp
////
////  Created by Al-Tameemi Hayder on 28.6.2023.
////
//
//import UIKit
//
//
//
//
//extension ChatroomCell {
//
//    func setup( message:Message, isSelecting: Bool ) {
//
//
//        isAuth = message.senderId == DataStore.shared.user.id ? true : false
//
//        messageTime.text = MessageDateFormator.regulaurTime(date: message.createdAt)
//
////        if let image = message.photoMessage {
////            messageImage.load(urlString: image)
////        }
//
//
//
//
//
//        if let image = message.photoMessage , let textMessage = message.textMessage {
//
//            messageImage.image = UIImage(named: image)
//
//            messageTextLabel.text = textMessage
//
//            messageBubbleTopToImage?.isActive = true
//
//            messageImageBottomToTextMessage?.isActive = true
//
//
//            setMessageTimeDefault()
//
//
//        } else if let image = message.photoMessage {
//
//            messageImage.image = UIImage(named: image)
//
//            messageBubbleTopToImage?.isActive = true
//            //messageTextbottomToTime?.isActive = false
//            //messageTextBottom?.isActive = true
//
//            setMessageWithBackground()
//
//            //messageImage
//            messageImageBottomToBubbleView?.isActive = true
//
//        } else if let _ = message.locationMessage, let textMessage = message.textMessage {
//
//            messageTextLabel.text = textMessage
//
//            setMapConstraints()
//
//            messageLocationHeightConstraint?.isActive = true
//            messageLocationWidthConstraint?.isActive = true
//
//            messageLocationBottomToTextMessage?.isActive = true
//
//            messageTextTopToLocation?.isActive = true
//
//            setMessageTimeDefault()
//
//            messageBubbleTopToMapView?.isActive = true
//
//        } else if let _ = message.locationMessage {
//            setMapConstraints()
//            //messageLocationMapView.setMapLocation(location: location)
//
//            messageBubbleTopToMapView?.isActive = true
//            messageLocationHeightConstraint?.isActive = true
//            messageLocationWidthConstraint?.isActive = true
//            messageLocationBottomToBubbleView?.isActive = true
//
//            print("here time location")
//            setMessageWithBackground()
//
//        } else if let textMessage  = message.textMessage {
//
//            messageTextLabel.text = textMessage
//
//            messageBubbleTopToTextMessage?.isActive = true
//            //messageTextBottom?.isActive = true
//            setMessageTimeDefault()
//
//            messageTextDefaultTop?.isActive = true
//
//        }
//
//
//
////        if let _ = message.textMessage, let _ = message.locationMessage {
////
////
////
////
////        } else if let _ = message.locationMessage {
////
////
////
////        }
////
////
////
////        if let image = message.photoMessage {
////            messageImage.image = UIImage(named: image)
////            //messageBubbleTopToImage?.isActive = true
////        } else {
////            messageImage.image = nil
////           // messageBubbleTopToImage?.isActive = false
////        }
////
////        if let textMessage = message.textMessage {
////
////        } else {
////            messageTextLabel.text = nil
////        }
////
//
//
////        else {
////            messageLocationMapView.unSetMapLocation()
////            messageBubbleTopToMapView?.isActive = false
////            messageLocationHeightConstraint?.isActive = false
////            messageLocationWidthConstraint?.isActive = false
////            messageLocationBottomToBubbleView?.isActive = false
//////            setMessageTimeDefault()
////
////        }
//
//
//
////        layoutIfNeeded()
////
////        let bubleHeight = bubbleView.bounds.height
////        bubbleView.layer.cornerRadius = bubleHeight * 0.45
////        bubbleView.clipsToBounds = true
//
//    }
//
//
//
//
//
//
//    func setMessageTimeDefault() {
//        messageTimeBackground.alpha = 0
//        if isAuth {
//            messageTime.textColor = .white
//            messageTime.alpha = 0.68
//        } else {
//            messageTime.textColor = .lightGray
//            messageTime.alpha = 1
//        }
//    }
//
//
//    func setMessageWithBackground() {
//        messageTimeBackground.alpha = 0.2
//        messageTime.textColor = .red
//        messageTime.alpha = 1
//    }
//
//
//}










//#2


//if let image = message.photoMessage , let textMessage = message.textMessage {
//
//    messageImage.image = UIImage(named: image)
//
//    messageTextLabel.text = textMessage
//
//    messageBubbleTopToImage?.isActive = true
//
//    messageImageBottomToTextMessage?.isActive = true
//
//
//    setMessageTimeDefault()
//
//
//} else if let image = message.photoMessage {
//
//    messageImage.image = UIImage(named: image)
//
//    messageBubbleTopToImage?.isActive = true
//    //messageTextbottomToTime?.isActive = false
//    //messageTextBottom?.isActive = true
//
//    setMessageWithBackground()
//
//    //messageImage
//    messageImageBottomToBubbleView?.isActive = true
//
//}
//else if let _ = message.locationMessage, let textMessage = message.textMessage {
//
//    messageTextLabel.text = textMessage
//
//    setMapConstraints()
//
//    messageLocationHeightConstraint?.isActive = true
//    messageLocationWidthConstraint?.isActive = true
//
//    messageLocationBottomToTextMessage?.isActive = true
//
//    messageTextTopToLocation?.isActive = true
//
//    setMessageTimeDefault()
//
//    messageBubbleTopToMapView?.isActive = true
//
//} else if let _ = message.locationMessage {
//    setMapConstraints()
//    //messageLocationMapView.setMapLocation(location: location)
//
//    messageBubbleTopToMapView?.isActive = true
//    messageLocationHeightConstraint?.isActive = true
//    messageLocationWidthConstraint?.isActive = true
//    messageLocationBottomToBubbleView?.isActive = true
//
//    print("here time location")
//    setMessageWithBackground()
//
//}
//else if let textMessage  = message.textMessage {
//
//    messageTextLabel.text = textMessage
//
//    messageBubbleTopToTextMessage?.isActive = true
//    
//    //messageTextBottom?.isActive = true
//    setMessageTimeDefault()
//
//    messageTextDefaultTop?.isActive = true
//
//}

