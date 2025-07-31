//
//  EmptyMessageView.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 23.7.2023.
//

import UIKit

class EmptyMessageView: UIView {
    
    let messageLabel = UILabel()
    
    var iconName: String?
    
    var wordToColor: String = "" {
        didSet {
            colorSpecificWord()
        }
    }

    var messageText: String = "" {
        didSet {
            messageLabel.text = messageText
        }
    }
    
    var messageTextColor: UIColor = UIColor.clear {
        didSet {
            messageLabel.textColor = messageTextColor
        }
    }
    
    let afterIconText: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        if let iconName = iconName {
            // Create Attachment
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName:iconName)
            // Set bound to reposition
            let imageOffsetY: CGFloat = -5.0
            imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
            // Create string with attachment
            let attachmentString = NSAttributedString(attachment: imageAttachment)
            // Initialize mutable string
            let completeText = NSMutableAttributedString(string: messageText + " ")
            // Add image to mutable string
            completeText.append(attachmentString)
            // Add your text to mutable string
            let textAfterIcon = NSAttributedString(string: " " + afterIconText)
            completeText.append(textAfterIcon)
            messageLabel.textAlignment = .center
            messageLabel.numberOfLines = 0
            messageLabel.font = UIFont.systemFont(ofSize: 17)
            messageLabel.sizeToFit()
            messageLabel.attributedText = completeText
        } else {
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.systemFont(ofSize: 17)
            messageLabel.sizeToFit()
//            messageLabel.text = messageText
            
        }
    }
    
    
    func colorSpecificWord() {
//        let wordToColor = wordToColor

        let attributedString = NSMutableAttributedString(string: messageText)

        // Find the range of the word you want to color
        let range = (messageText as NSString).range(of: wordToColor)

        // Set the color for the word in the attributed string
        attributedString.addAttribute(.foregroundColor, value: AppTheme.primaryColor, range: range)

        messageLabel.attributedText = attributedString
    }

}
