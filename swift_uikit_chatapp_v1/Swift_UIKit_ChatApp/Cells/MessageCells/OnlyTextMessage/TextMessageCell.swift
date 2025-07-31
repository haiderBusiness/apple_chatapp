//
//  CTRMTextMessageCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 14.7.2023.
//

import UIKit

class TextMessageCell: CoreMessageCell {
    
    static let identifier = "TextMessageCell"

    var messageBubbleLeading: NSLayoutConstraint?
    var messageBubbleTrailing: NSLayoutConstraint?
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
        selectionStyle = .none
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        configureUI();
        //layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageTime.text = nil
        messageTextLabel.text = nil
        longPressRecognizer?.isEnabled = false
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isAuth {
            messageTextLabel.textColor = .white
            bubbleView.backgroundColor = AppTheme.sucsessColor
            messageBubbleTrailing?.isActive = true
            messageBubbleLeading?.isActive = false

            messageTime.textColor = .white
            messageTime.alpha = 0.68

        } else {
            messageTextLabel.textColor = .label
            bubbleView.backgroundColor = .systemGray6
            messageBubbleLeading?.isActive = true
            messageBubbleTrailing?.isActive = false
            
            messageTime.textColor = .lightGray
            messageTime.alpha = 1
        }
        
    }
    
    
    
    
    func configure(message: Message, isSelecting: Bool) {
        
        isAuth = message.senderId == DataStore.shared.user.id ? true : false
        messageTime.text = getTimeStampTime(date: message.createdAt)
        
        messageTextLabel.text = message.textMessage!
    }
    
    
    func configureUI() {
        
        contentView.addSubview(mainView)
        addSubview(mainView)
        
        mainView.addSubview(bubbleView)
        mainView.addSubview(messageTime)
        mainView.addSubview(messageTextLabel)
        
//        bubbleView.layer.zPosition = 0
//        messageTime.layer.zPosition = 3
        
        bubbleView.isUserInteractionEnabled = false
        messageTime.isUserInteractionEnabled = false
        
        // mainView
        configureMainView()
 
        //MessageTime
        configureMessageTime()
        
        //messageText
        configureMessageText()
        
        //messageBubble
        configureMessageBubble()
      }
    
    func configureMainView() {
        NSLayoutConstraint.activate([
            //mainView.widthAnchor.constraint(equalToConstant: 0),
            mainView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor),
            mainView.topAnchor.constraint(equalTo: bubbleView.topAnchor),
        ])
    }
    
    
    
    func configureMessageTime() {
        
        messageTime.textAlignment = .right
        
        let messageTimeLeadingConstraint = messageTime.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 13)
        let messageTimeTrailingConstraint = messageTime.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -13)
        
        messageTimeLeadingConstraint.priority = .defaultLow
        messageTimeTrailingConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            //messageTime.topAnchor.conƒstraint(equalTo: messageTextLabel.bottomAnchor, constant: 5),
            messageTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
//            messageTimeLeadingConstraint,
            messageTimeTrailingConstraint,
        ])
    }
    
    
    func configureMessageText() {
        
        NSLayoutConstraint.activate([
            //messageTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            //messageTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            
            messageTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            messageTextLabel.bottomAnchor.constraint(equalTo: messageTime.topAnchor, constant: -2.5),
            messageTextLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 13),
            messageTextLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -13),
           
            //messageTextLabel.widthAnchor.constraint(lessThanOrEqualToConstant: eighty_percent),
            ])
        
            
    }
    
    
    
    
    func configureMessageBubble() {
        
        let screenWidth = UIScreen.main.bounds
        let eighty_percent = CGFloat(screenWidth.width * 0.8)
        NSLayoutConstraint.activate([
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: eighty_percent),
            //bubbleView.widthAnchor.constraint(equalToConstant: 0),
            bubbleView.topAnchor.constraint(equalTo: messageTextLabel.topAnchor, constant: -5),
            bubbleView.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor, constant: 5),
           
        ])
        
        messageBubbleLeading = bubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        messageBubbleTrailing = bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
