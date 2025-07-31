//
//  messageroom+UI.swift
//  Swift_UIKit_messageApp
//
//  Created by Al-Tameemi Hayder on 28.6.2023.
//

import UIKit

extension ChatroomCell {
    
    func configureUI() {
        
        addSubview(bubbleView)
        contentView.addSubview(messageImage)
        addSubview(messageImage)
//        addSubview(messageLocationMapView!)
        addSubview(messageTimeBackground)
        addSubview(messageTime)
        addSubview(messageTextLabel)
        
        bubbleView.layer.zPosition = 0
        messageImage.layer.zPosition = 1
        
        messageTimeBackground.layer.zPosition = 2
        messageTime.layer.zPosition = 3
        
        bubbleView.isUserInteractionEnabled = false
        messageTime.isUserInteractionEnabled = false
        messageTimeBackground.isUserInteractionEnabled = false
        
        
        
        
        //MessageTime
        configureMessageTime()
        
        //messageText
        configureMessageText()
        
        //messageImage
        configureMessageImage()
        
        //messageBubble
        configureMessageBubble()
        
      }
    
    
    func configureMessageTime() {
        
        messageTime.textAlignment = .right
        
        let messageTimeLeadingConstraint = messageTime.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 13)
        let messageTimeTrailingConstraint = messageTime.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -13)
        
        messageTimeLeadingConstraint.priority = .defaultLow
        messageTimeTrailingConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            messageTimeBackground.leadingAnchor.constraint(equalTo: messageTime.leadingAnchor, constant: -2),
            
            messageTimeBackground.trailingAnchor.constraint(equalTo: messageTime.trailingAnchor, constant: 2),
            //messageTimeBackground.topAnchor.constraint(equalTo: messageTime.topAnchor, constant: 25),
            messageTimeBackground.topAnchor.constraint(equalTo: messageTime.topAnchor, constant: -2),
            //messageTimeBackground.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor,constant: -10)
            messageTimeBackground.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor, constant: 2),
            
            //messageTime.topAnchor.conƒstraint(equalTo: messageTextLabel.bottomAnchor, constant: 5),
            messageTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.5),
            messageTimeLeadingConstraint,
            messageTimeTrailingConstraint,
        ])
        

    }
    
    
    func configureMessageBubble() {
        
        
        let eighty_percent = CGFloat(bounds.width * 1.1)
        
        
        
        NSLayoutConstraint.activate([
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: eighty_percent),
            
            //bubbleView.topAnchor.constraint(equalTo: messageTextLabel.topAnchor, constant: -10),
            bubbleView.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor, constant: 10),
        ])
        
        //messageBubbleLeadingToMessage = bubbleView.leadingAnchor.constraint(equalTo: messageTextLabel.leadingAnchor, constant: -10)
        //messageBubbleTrailingToMessage = bubbleView.trailingAnchor.constraint(equalTo: messageTextLabel.trailingAnchor, constant: 10)
        //messageBubbleLeadingToTime = bubbleView.leadingAnchor.constraint(equalTo: messageTime.leadingAnchor, constant: -10)
        
        messageBubbleTrailingToTime = bubbleView.trailingAnchor.constraint(equalTo: messageTime.trailingAnchor, constant: 10)
        messageBubbleTopToTextMessage =
        bubbleView.topAnchor.constraint(equalTo: messageTextLabel.topAnchor, constant: -10)
        
        messageBubbleTopToImage =
        bubbleView.topAnchor.constraint(equalTo: messageImage.topAnchor, constant: -2)
    }
    
    
    func configureMessageText() {
        
        NSLayoutConstraint.activate([
            //messageTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            //messageTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            messageTextLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 13),
            messageTextLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -13),
            messageTextLabel.bottomAnchor.constraint(equalTo: messageTime.topAnchor, constant: -2.5),
            //messageTextLabel.widthAnchor.constraint(lessThanOrEqualToConstant: eighty_percent),
            ])
        
            messageTextLeading = messageTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22)
            messageTextTrailing = messageTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22)
            messageTextDefaultTop = messageTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13)
            messageTextbottomToTime = messageTextLabel.bottomAnchor.constraint(equalTo: messageTime.topAnchor, constant: -2.5)
            messageTextTopToLocation = messageTextLabel.bottomAnchor.constraint(equalTo: messageTime.topAnchor, constant: -2.5)
    }
    
    
   
    
}








