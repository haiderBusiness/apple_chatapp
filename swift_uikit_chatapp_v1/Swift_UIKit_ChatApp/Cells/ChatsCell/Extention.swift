//
//  Extention.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 9.6.2023.
//

import UIKit


extension ChatsCell {
    
    func configureMarksConstraints(chat: ChatRoom)  {
        
        
        if chat.unreadCount > 0 { // if there is unread messages
            
            //chatMessageTrailing
            messageTrailingConstraintDefault.isActive = false;
            messageTrailingConstraintToCountView.isActive = true;
            
            //labelViewMin
            labelViewMinWidthConstraint.isActive = true
            labelViewMinHeightConstraint.isActive = true
            
            //chatUnreadMessages
            chatUnreadMessages.text = "\(chat.unreadCount)"
        } else {
            //chatMessageTrailing
            messageTrailingConstraintDefault.isActive = false;
            messageTrailingConstraintToCountView.isActive = false;
            
            //labelViewMin
            labelViewMinWidthConstraint.isActive = false;
            labelViewMinHeightConstraint.isActive = false;
            
            //chatUnreadMessages
            chatUnreadMessages.text = ""
        }
        
        
        
        
        
        //chatMessage
        if chat.muted && chat.unreadCount > 0 {
            messageTrailingToUnreadMark.isActive = false
            messageTrailingConstraintDefault.isActive = false;
            messageTrailingConstraintToCountView.isActive = false;
            messageTrailingToMuteMarkConstraint.isActive = true;
            messageTrailingToPinMarkConstraint.isActive = false;
        } else if chat.muted && chat.markUnRead {
            messageTrailingToUnreadMark.isActive = false
            messageTrailingConstraintDefault.isActive = false;
            messageTrailingConstraintToCountView.isActive = false;
            messageTrailingToMuteMarkConstraint.isActive = true;
            messageTrailingToPinMarkConstraint.isActive = false;
        } else if chat.muted && chat.pinned {
            messageTrailingToUnreadMark.isActive = false
            messageTrailingConstraintDefault.isActive = false;
            messageTrailingConstraintToCountView.isActive = false;
            messageTrailingToMuteMarkConstraint.isActive = true;
            messageTrailingToPinMarkConstraint.isActive = false;
        } else if chat.pinned && chat.unreadCount > 0 {
            messageTrailingToUnreadMark.isActive = false
            messageTrailingConstraintDefault.isActive = false;
            messageTrailingConstraintToCountView.isActive = false;
            messageTrailingToMuteMarkConstraint.isActive = false;
            messageTrailingToPinMarkConstraint.isActive = true
        } else if chat.pinned && chat.markUnRead {
            messageTrailingToUnreadMark.isActive = false
            messageTrailingConstraintDefault.isActive = false;
            messageTrailingConstraintToCountView.isActive = false;
            messageTrailingToMuteMarkConstraint.isActive = false;
            messageTrailingToPinMarkConstraint.isActive = true;
        } else if chat.muted {
            messageTrailingToUnreadMark.isActive = false
            messageTrailingConstraintDefault.isActive = false;
            messageTrailingConstraintToCountView.isActive = false;
            messageTrailingToMuteMarkConstraint.isActive = true;
            messageTrailingToPinMarkConstraint.isActive = false;
        } else if chat.pinned {
            messageTrailingToUnreadMark.isActive = false
            messageTrailingConstraintDefault.isActive = false;
            messageTrailingConstraintToCountView.isActive = false;
            messageTrailingToMuteMarkConstraint.isActive = false;
            messageTrailingToPinMarkConstraint.isActive = true;
        } else if chat.markUnRead {
            messageTrailingToUnreadMark.isActive = true
            messageTrailingConstraintDefault.isActive = false;
            messageTrailingConstraintToCountView.isActive = false;
            messageTrailingToMuteMarkConstraint.isActive = false;
            messageTrailingToPinMarkConstraint.isActive = false;
        } else if chat.unreadCount > 0 {
            messageTrailingToUnreadMark.isActive = false
            messageTrailingConstraintDefault.isActive = false;
            messageTrailingConstraintToCountView.isActive = true;
            messageTrailingToMuteMarkConstraint.isActive = false;
            messageTrailingToPinMarkConstraint.isActive = false;
        } else {
            messageTrailingConstraintDefault.isActive = true;
            messageTrailingToMuteMarkConstraint.isActive = false
            messageTrailingToPinMarkConstraint.isActive = false
        }
        
        
        
        //chatMark
        if chat.markUnRead {
            unreadMarkMinWidthConstraint.isActive = true
            unreadMarkMinHeightConstraint.isActive = true
        } else {
            unreadMarkMinWidthConstraint.isActive = false
            unreadMarkMinHeightConstraint.isActive = false
        }
        
        
        
        
        
        //pinMark
        if chat.pinned && chat.unreadCount > 0 {
            pinMark.alpha = 1
            pinMarkTrailingToUnreadMessagesConstraint.isActive = true
            pinMarkTrailingDefaultConstraint.isActive = false
            pinMarkTrailingToUnreadMarkConstraint.isActive = false
            pinMarkMinWidthConstraint.isActive = true
            pinMarkMinHeightConstraint.isActive = true
        } else if chat.pinned && chat.markUnRead {
            pinMark.alpha = 1
            pinMarkTrailingToUnreadMessagesConstraint.isActive = false
            pinMarkTrailingToUnreadMarkConstraint.isActive = true
            pinMarkTrailingDefaultConstraint.isActive = false
            pinMarkMinWidthConstraint.isActive = true
            pinMarkMinHeightConstraint.isActive = true
            
        } else if chat.pinned {
            pinMark.alpha = 1
            pinMarkTrailingToUnreadMarkConstraint.isActive = false
            pinMarkTrailingToUnreadMessagesConstraint.isActive = false
            pinMarkTrailingDefaultConstraint.isActive = true
            pinMarkMinWidthConstraint.isActive = true
            pinMarkMinHeightConstraint.isActive = true
        } else {
            pinMark.alpha = 0
            pinMarkTrailingDefaultConstraint.isActive = false
            pinMarkTrailingToUnreadMarkConstraint.isActive = false
            pinMarkTrailingToUnreadMessagesConstraint.isActive = true
            pinMarkMinWidthConstraint.isActive = false
            pinMarkMinHeightConstraint.isActive = false
        }
        
        
        
        
        
        
        //muteMark
        if chat.muted && chat.pinned {
            muteMark.alpha = 1
            muteMarkTrailingToPinMarkConstraint.isActive = true
            muteMarkTrailingDefaultConstraint.isActive = false
            muteMarkTrailingToUnreadMarkConstraint.isActive = false
            muteMarkTrailingToUnreadMessagesConstraint.isActive = false
            muteMarkMinWidthConstraint.isActive = true
            muteMarkMinHeightConstraint.isActive = true
        } else if chat.muted && chat.unreadCount > 0 {
            muteMark.alpha = 1
            muteMarkTrailingToPinMarkConstraint.isActive = false
            muteMarkTrailingToUnreadMessagesConstraint.isActive = true
            muteMarkTrailingToUnreadMarkConstraint.isActive = false
            muteMarkTrailingDefaultConstraint.isActive = false
            muteMarkMinWidthConstraint.isActive = true
            muteMarkMinHeightConstraint.isActive = true
            
        } else if chat.muted && chat.markUnRead {
            muteMark.alpha = 1
            muteMarkTrailingToPinMarkConstraint.isActive = false
            muteMarkTrailingToUnreadMessagesConstraint.isActive = false
            muteMarkTrailingToUnreadMarkConstraint.isActive = true
            muteMarkTrailingDefaultConstraint.isActive = false
            muteMarkMinWidthConstraint.isActive = true
            muteMarkMinHeightConstraint.isActive = true
        } else if chat.muted {
            muteMark.alpha = 1
            muteMarkTrailingToPinMarkConstraint.isActive = false
            muteMarkTrailingToUnreadMessagesConstraint.isActive = false
            muteMarkTrailingToUnreadMarkConstraint.isActive = false
            muteMarkTrailingDefaultConstraint.isActive = true
            muteMarkMinWidthConstraint.isActive = true
            muteMarkMinHeightConstraint.isActive = true
            
        } else {
            muteMark.alpha = 0
            muteMarkTrailingToPinMarkConstraint.isActive = false
            muteMarkTrailingToUnreadMessagesConstraint.isActive = false
            muteMarkTrailingToUnreadMarkConstraint.isActive = false
            muteMarkTrailingDefaultConstraint.isActive = false
            muteMarkMinWidthConstraint.isActive = false
            muteMarkMinHeightConstraint.isActive = false
        }
    }
}
