//
//  messageroom+.swift
//  Swift_UIKit_messageApp
//
//  Created by Al-Tameemi Hayder on 28.6.2023.
//

import UIKit

extension ChatroomCell {
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        

        if isAuth {
            messageTextLabel.textColor = .white
            bubbleView.backgroundColor = AppTheme.sucsessColor
          
            messageTextTrailing?.isActive = true
            messageTextLeading?.isActive = false
            messageImageTrailing?.isActive = true
            messageImageLeading?.isActive = false
            
        } else {
            messageTextLabel.textColor = .label
//            messageTime.textColor = .lightGray
            //messageTextLabel.textColor = .label
            bubbleView.backgroundColor = .systemGray6
            //messageText
            messageTextLeading?.isActive = true
            messageTextTrailing?.isActive = false
            
            //messageImage
            messageImageTrailing?.isActive = false
            messageImageLeading?.isActive = true
        }
        
        
//        if let _ = messageImage.image {
//            
//        } else {
//            messageImageLeading?.isActive = false
//            messageImageTrailing?.isActive = false
//            messageImageBottomToTextMessage?.isActive = false
//            messageImageBottomToBubbleView?.isActive = false
//            messageImageWidthConstraint?.isActive = false
//            messageImageHeightConstraint?.isActive = false
//        }

        
    }
    
    
    
}
