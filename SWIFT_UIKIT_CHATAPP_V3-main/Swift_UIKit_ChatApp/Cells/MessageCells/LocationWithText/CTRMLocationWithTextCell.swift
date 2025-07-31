//
//  CTRMLocationWithTextCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 15.7.2023.
//


import UIKit

//let mapView = MapView()

class CTRMLocationWithTextCell: CoreMessageCell {
    
    static let identifier = "CTRMLocationWithTextCell"
    
    

    
    
    var messageLocationMapView : MapView!
    
    
    
    
    var messageBubbleLeading: NSLayoutConstraint?
    var messageBubbleTrailing: NSLayoutConstraint?
    var messageImageBottomToBubbleView: NSLayoutConstraint?
    var messageImageWidthConstraint: NSLayoutConstraint?
    var messageImageHeightConstraint: NSLayoutConstraint?
    

    
    
    
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
        selectionStyle = .none
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        messageLocationMapView = MapViewManager.shared.getMapView() as? MapView
        configureUI();
        //layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageTime.text = nil
        
        messageTextLabel.text = nil
        longPressRecognizer?.isEnabled = false
        
//        messageBubbleLeading?.isActive = false
//        messageBubbleTrailing?.isActive = false
//        messageImageBottomToBubbleView?.isActive = false
//        messageImageWidthConstraint?.isActive = false
//        messageImageHeightConstraint?.isActive = false
//
//        messageBubbleLeading = nil
//        messageBubbleTrailing = nil
//        messageImageBottomToBubbleView = nil
//        messageImageWidthConstraint = nil
//        messageImageHeightConstraint = nil
        
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
        
        messageLocationMapView.setMapLocation(location: message.locationMessage!)
        messageLocationMapView.centerMap()
        
        
        //messageMapView
        configureMessageMapView()
        
        
    }
    
    
    func configureUI() {
        
        contentView.addSubview(mainView)
        addSubview(mainView)
        
        mainView.addSubview(bubbleView)
//        addSubview(messageLocationMapView!)
        mainView.addSubview(messageTime)
        mainView.addSubview(messageTextLabel)
        
        
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
            messageTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.5),
            messageTimeLeadingConstraint,
            messageTimeTrailingConstraint,
        ])
    }

    
    func configureMessageBubble() {
        
        let screenWidth = UIScreen.main.bounds
        let eighty_percent = CGFloat(screenWidth.width * 0.8)
        NSLayoutConstraint.activate([
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: eighty_percent),
            //bubbleView.widthAnchor.constraint(equalToConstant: 0),
            bubbleView.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor, constant: 10),
            
        ])
        
        messageBubbleLeading = bubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        messageBubbleTrailing = bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        
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
        
            
    }
    
    
    
    func configureMessageMapView() {
        mainView.addSubview(messageLocationMapView)
        
        
        messageLocationMapView.layer.cornerRadius = 12
        messageLocationMapView.clipsToBounds = true
        messageLocationMapView.layer.zPosition = 1
        messageLocationMapView.isUserInteractionEnabled = false
        messageLocationMapView.translatesAutoresizingMaskIntoConstraints = false
       
        
        NSLayoutConstraint.activate([
            messageTextLabel.topAnchor.constraint(equalTo: messageLocationMapView.bottomAnchor, constant: 13),
            bubbleView.topAnchor.constraint(equalTo: messageLocationMapView.topAnchor, constant: -2),
            messageLocationMapView.topAnchor.constraint(equalTo: topAnchor, constant: 8),

            // TODO: commented
//            messageLocationMapView.bottomAnchor.constraint(equalTo: messageTextLabel.topAnchor, constant: -5),
            
            messageLocationMapView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 2),
            messageLocationMapView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -2),
            messageLocationMapView.heightAnchor.constraint(equalToConstant: 180),
            messageLocationMapView.widthAnchor.constraint(equalToConstant:  300),
//           bubbleView.topAnchor.constraint(equalTo: messageLocationMapView.topAnchor, constant: -2),
           
           //mapView.heightAnchor.constraint(lessThanOrEqualToConstant: 400),
        ])
        
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
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



