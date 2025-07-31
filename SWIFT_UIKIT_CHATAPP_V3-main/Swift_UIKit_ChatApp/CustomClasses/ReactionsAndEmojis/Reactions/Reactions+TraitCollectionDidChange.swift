//
//  Reactions+t.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 7.11.2023.
//

import UIKit

extension ChatroomReactionView {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Update the map style when the system theme changes
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            if traitCollection.userInterfaceStyle == .dark {
                
                
                
                
                mainView.backgroundColor = .systemGray5.withAlphaComponent(0.6)
                firstBubbleView.backgroundColor = .systemGray5.withAlphaComponent(0.6)
                secondBubbleView.backgroundColor = .systemGray5.withAlphaComponent(0.6)
                
                blur.effect = UIBlurEffect(style: .dark)
                firstBubbleBlur.effect = UIBlurEffect(style: .dark)
                secondBubbleBlur.effect = UIBlurEffect(style: .dark)
                
                for reactionCell in reactionCells {
                    reactionCell.blur.effect = UIBlurEffect(style: .dark)
                    
                    
//                    reactionCell.reactionButton.highlightedColor = .white.withAlphaComponent(0.2)
                    
                    if !reactionCell.actionItems.selected {
                        reactionCell.reactionButton.backgroundColor = .clear
                    } else {
                        reactionCell.reactionButton.backgroundColor = .white.withAlphaComponent(0.2)
                    }
                    
                    
                    if reactionCell.actionItems.attributes == .extra {
//                        reactionCell.reactionButton.highlightedColor = .white.withAlphaComponent(0.2)
//
//                        reactionCell.reactionButton.unhighlightedColor =  .white.withAlphaComponent(0.15)
                        reactionCell.reactionButton.backgroundColor =  .white.withAlphaComponent(0.15)
                        
                    }
                }

            } else {
                
                firstBubbleView.backgroundColor = .white.withAlphaComponent(0.8)
                secondBubbleView.backgroundColor = .white.withAlphaComponent(0.8)
                mainView.backgroundColor = .white.withAlphaComponent(0.8)
                
                blur.effect = UIBlurEffect(style: .light)
                firstBubbleBlur.effect = UIBlurEffect(style: .light)
                secondBubbleBlur.effect = UIBlurEffect(style: .light)
                
                for reactionCell in reactionCells {
                    reactionCell.blur.effect = UIBlurEffect(style: .light)
                    
                    
                    
//                    reactionCell.reactionButton.highlightedColor = .black.withAlphaComponent(0.2)
                    
                    if !reactionCell.actionItems.selected {
                        reactionCell.reactionButton.backgroundColor = .clear
                    } else {
                        reactionCell.reactionButton.backgroundColor = .black.withAlphaComponent(0.2)
                    }
                    
                    
                    if reactionCell.actionItems.attributes == .extra  {
//                        reactionCell.reactionButton.highlightedColor = .black.withAlphaComponent(0.2)
//
//                        reactionCell.reactionButton.unhighlightedColor = .black.withAlphaComponent(0.15)
                        reactionCell.reactionButton.backgroundColor = .black.withAlphaComponent(0.15)
                        
                    }
                }
            }
        }
        
    }
}
