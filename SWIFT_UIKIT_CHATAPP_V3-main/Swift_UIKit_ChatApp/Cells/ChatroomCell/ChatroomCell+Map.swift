//
//  ChatroomCell+Map.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 4.7.2023.
//

import UIKit

extension ChatroomCell {

    
     func setMapConstraints() {
         addSubview(messageLocationMapView)
         
        
         messageLocationMapView.layer.cornerRadius = 12
         messageLocationMapView.clipsToBounds = true
         messageLocationMapView.layer.zPosition = 1
         messageLocationMapView.isUserInteractionEnabled = false
         messageLocationMapView.translatesAutoresizingMaskIntoConstraints = false
        
         
         NSLayoutConstraint.activate([
            messageLocationMapView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            messageLocationMapView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 2),
            messageLocationMapView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -2),
            
            //mapView.heightAnchor.constraint(lessThanOrEqualToConstant: 400),
         ])
         
         // messageBubble
         messageBubbleTopToMapView = bubbleView.topAnchor.constraint(equalTo: messageLocationMapView.topAnchor, constant: -2);
         //messageLocaiton
         messageLocationHeightConstraint = messageLocationMapView.heightAnchor.constraint(equalToConstant: 180)
         messageLocationWidthConstraint = messageLocationMapView.widthAnchor.constraint(equalToConstant:  300)

         
         messageLocationLeading = messageLocationMapView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 2)
         messageLocationTrailing = messageLocationMapView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -2)
         
         messageLocationBottomToBubbleView = messageLocationMapView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -2)

         messageLocationBottomToTextMessage = messageLocationMapView.bottomAnchor.constraint(equalTo: messageTextLabel.topAnchor, constant: -5);
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Update the map style when the system theme changes
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            setMapStyle()
        }
    }
    
    private func setMapStyle() {
        if traitCollection.userInterfaceStyle == .dark {
            // Set dark style if system theme is dark
            messageLocationMapView.overrideUserInterfaceStyle = .dark
        } else {
            // Set light style if system theme is light
            messageLocationMapView.overrideUserInterfaceStyle = .light
        }
    }
    
}
