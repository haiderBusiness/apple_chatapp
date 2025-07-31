//
//  Reactions+ConfigureReactionsButtons.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 7.11.2023.
//

import UIKit

extension ChatroomReactionView {
    
    func configureReactionButtons() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        var previousReactionButton: UIButton?
            print("here we are ")
        
        let style = window.traitCollection.userInterfaceStyle
        
        blur = AddBlur(toView: mainView, blurStyle: style == .light ? .light : .dark)
        mainView.addSubview(blur)

        blur.isUserInteractionEnabled = false
        blur.layer.zPosition = 0
        
        firstBubbleBlur = AddBlur(toView: firstBubbleView, blurStyle: style == .light ? .light : .dark)
        firstBubbleBlur.isUserInteractionEnabled = false
        
        
        secondBubbleBlur = AddBlur(toView: secondBubbleView, blurStyle: style == .light ? .light : .dark)
        secondBubbleBlur.isUserInteractionEnabled = false
        
        
        if style == .dark {
            mainView.backgroundColor = .systemGray5.withAlphaComponent(0.6)
            firstBubbleView.backgroundColor = .systemGray5.withAlphaComponent(0.6)
            secondBubbleView.backgroundColor = .systemGray5.withAlphaComponent(0.6)
//            mainView.backgroundColor = .clear
        } else {
//            mainView.backgroundColor = .clear
            mainView.backgroundColor = .white.withAlphaComponent(0.8)
            firstBubbleView.backgroundColor = .white.withAlphaComponent(0.8)
            secondBubbleView.backgroundColor = .white.withAlphaComponent(0.8)
        }
        
        
        var type1 = false
        
        for i in 0..<reactionItems.count {
 
            let number = i + 1
            let reactionItem = reactionItems.reversed()[i]
            
            
            let newReactionButton = UIButton()
            newReactionButton.isUserInteractionEnabled = true
            newReactionButton.translatesAutoresizingMaskIntoConstraints = false
            newReactionButton.layer.zPosition = 2
            
            let delay = CGFloat(i) * 0.01
            
           
            if type1 {
                startAnimation(view: newReactionButton, delay: delay, type: 1)
                type1 = false
            } else {
                startAnimation(view: newReactionButton, delay: delay, type: 2)
                type1 = true
            }
            
            
            
            newReactionButton.addTarget(self, action: #selector(press), for: .touchUpInside)
            
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
            
            longPressGesture.minimumPressDuration = 0.3
            
            if reactionItem.attributes != .extra {
                newReactionButton.addGestureRecognizer(longPressGesture)
            }
            
            
            
            
            
            
            // label
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = reactionItem.emojiString
            label.isUserInteractionEnabled = false
            label.font = UIFont.systemFont(ofSize: 32)
            label.layer.zPosition = 1
            
            newReactionButton.addSubview(label)
        
            // imageView
            let imageView = UIImageView()
            imageView.image = reactionItem.image
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = false
            imageView.layer.zPosition = 1
            
            newReactionButton.addSubview(imageView)
            
//            let imageView = UIImageView()
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//            imageView.image = emojiToImage(emoji: reactionItem.emojiString, size: CGSize(width: 30, height: 30))
//            imageView.isUserInteractionEnabled = false
            
//            imageView.tintColor = .label
            
            
//            imageView.layer.zPosition = 1
//            newReactionButton.addSubview(imageView)
            
//            newMenuButton.backgroundColor = .red
        
            
            
            addSubview(newReactionButton)
            
            // other options not first and not last
            if let previousReactionButton = previousReactionButton, i > 0, number != reactionItems.count {
                NSLayoutConstraint.activate([
//                    newReactionButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
//                    newReactionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
                    newReactionButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
                    newReactionButton.trailingAnchor.constraint(equalTo: previousReactionButton.leadingAnchor, constant: -5),
//                    newReactionButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 38),
//                    newReactionButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 38),
//                    newReactionButton.heightAnchor.constraint(lessThanOrEqualToConstant: 38),
//                    newReactionButton.widthAnchor.constraint(lessThanOrEqualToConstant: 38),
                    newReactionButton.heightAnchor.constraint(equalToConstant: 40),
                    newReactionButton.widthAnchor.constraint(equalToConstant: 40)
                ])
                
            }

            
            // last option
            else if number == reactionItems.count {
//                print("here we are2", reactionItem)
                NSLayoutConstraint.activate([
                    newReactionButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
                    newReactionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                    newReactionButton.heightAnchor.constraint(equalToConstant: 40),
                    newReactionButton.widthAnchor.constraint(equalToConstant: 40)
                ])
                
                viewWidth += 5
            }
            
            // first option
            else {
                NSLayoutConstraint.activate([
                    newReactionButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
                    newReactionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
                    newReactionButton.heightAnchor.constraint(equalToConstant: 40),
                    newReactionButton.widthAnchor.constraint(equalToConstant: 40)
                ])
            
            }
            
            self.layoutIfNeeded()
            newReactionButton.layer.cornerRadius = newReactionButton.bounds.width / 2.3
            newReactionButton.clipsToBounds = true
            
            
        
            NSLayoutConstraint.activate([
                label.centerYAnchor.constraint(equalTo: newReactionButton.centerYAnchor),
//                label.centerYAnchor.constraint(equalTo: newMenuButton.centerYAnchor),
                label.centerXAnchor.constraint(equalTo: newReactionButton.centerXAnchor),
                
                imageView.widthAnchor.constraint(equalToConstant: 25),
                imageView.heightAnchor.constraint(equalToConstant: 25),
                imageView.centerYAnchor.constraint(equalTo: newReactionButton.centerYAnchor),
//                label.centerYAnchor.constraint(equalTo: newMenuButton.centerYAnchor),
                imageView.centerXAnchor.constraint(equalTo: newReactionButton.centerXAnchor),
            ])
            
//            newReactionButton.bounds.size.width = 38
//            newReactionButton.bounds.size.height = 38
            
            newReactionButton.layoutIfNeeded()
            
//            print("newReactionButton.constraints",newReactionButton.constraints)
            previousReactionButton = newReactionButton
            

            
            let reactionCell = ReactionCell(id: "\(UUID())", reactionButton: newReactionButton, label: label, imageView: imageView, blur: UIVisualEffectView(), actionItems: reactionItem)
            
            if !reactionItem.selected {
                newReactionButton.backgroundColor = .clear
            }
            else if style == .dark {
                newReactionButton.backgroundColor = .white.withAlphaComponent(0.2)
            } else {
                  newReactionButton.backgroundColor = .black.withAlphaComponent(0.2)
            }
            
            
            
            if reactionItem.attributes == .extra {
//                newReactionButton.highlightedColor = style == .dark ? .white.withAlphaComponent(0.2) : .black.withAlphaComponent(0.2)
//
//                newReactionButton.unhighlightedColor = style == .dark ? .white.withAlphaComponent(0.15) : .black.withAlphaComponent(0.15)
                newReactionButton.backgroundColor = style == .dark ? .white.withAlphaComponent(0.15) : .black.withAlphaComponent(0.15)
                
                label.textColor = .label.withAlphaComponent(0.5)
                
                imageView.tintColor = .white

                newReactionButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
                newReactionButton.widthAnchor.constraint(equalToConstant: 34).isActive = true
                
                imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
                self.layoutIfNeeded()
                newReactionButton.layer.cornerRadius = newReactionButton.bounds.width / 2.3
            }
  
            reactionCells.append(reactionCell)
            
            
            self.layoutIfNeeded()
            viewWidth += reactionItem.customSize > 0 ? CGFloat(reactionItem.customSize) : newReactionButton.frame.width + 5
        }
    }
}
