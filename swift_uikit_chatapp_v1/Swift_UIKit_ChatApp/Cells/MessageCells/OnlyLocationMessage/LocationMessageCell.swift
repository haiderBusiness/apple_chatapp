//
//  CTRMLocationMessageCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 14.7.2023.
//

import UIKit



class LocationMessageCell: CoreMessageCell {
    
    static let identifier = "LocationMessageCell"
    
//    var messageLocationMapView : MapView!
    var messageLocationMapView = MapView()
    

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
//        messageLocationMapView = MapView()
//        messageLocationMapView = MapViewManager.shared.getMapView() as? MapView
        configureUI();
//        print("location messageBubble leading: ", messageBubbleLeading ?? "nil")
//        print("location messageBubble leading: ", messageBubbleTrailing ?? "nil")
        
        //layoutIfNeeded()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageTime.text = nil
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
            bubbleView.backgroundColor = AppTheme.sucsessColor
            messageBubbleTrailing?.isActive = true
            messageBubbleLeading?.isActive = false

        } else {
            bubbleView.backgroundColor = .systemGray6
            messageBubbleLeading?.isActive = true
            messageBubbleTrailing?.isActive = false
        }
        
    }
    
    
    func configure(message: Message, isSelecting: Bool) {
        
        isAuth = message.senderId == DataStore.shared.user.id ? true : false
        messageTime.text = getTimeStampTime(date: message.createdAt)
        
        
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
        
       
        mainView.addSubview(messageTimeBackground)
        mainView.addSubview(messageTime)
        mainView.addSubview(checkmarkImageView)
        
        bubbleView.layer.zPosition = 0
        messageLocationMapView.layer.zPosition = 1
        
        messageTimeBackground.layer.zPosition = 2
        messageTime.layer.zPosition = 3
        checkmarkImageView.layer.zPosition = 4
        
        
        bubbleView.isUserInteractionEnabled = false
        messageTime.isUserInteractionEnabled = false
        messageTimeBackground.isUserInteractionEnabled = false
        
        // mainView
        configureMainView()
 
        //MessageTime
        configureMessageTime()
        
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
    
    func configureMessageMapView() {
        mainView.addSubview(messageLocationMapView)
        
       
        messageLocationMapView.layer.cornerRadius = 12
        messageLocationMapView.clipsToBounds = true
        messageLocationMapView.layer.zPosition = 1
        messageLocationMapView.isUserInteractionEnabled = false
        messageLocationMapView.translatesAutoresizingMaskIntoConstraints = false
       
        
        NSLayoutConstraint.activate([
           bubbleView.topAnchor.constraint(equalTo: messageLocationMapView.topAnchor, constant: -2),
           messageLocationMapView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
           messageLocationMapView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -2),
           messageLocationMapView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 2),
           messageLocationMapView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -2),
           messageLocationMapView.heightAnchor.constraint(equalToConstant: 180),
           messageLocationMapView.widthAnchor.constraint(equalToConstant:  300),
//           bubbleView.topAnchor.constraint(equalTo: messageLocationMapView.topAnchor, constant: -2),
           
           //mapView.heightAnchor.constraint(lessThanOrEqualToConstant: 400),
        ])
        
   }
    
    func configureMessageBubble() {
        
        let screenWidth = UIScreen.main.bounds
        let eighty_percent = CGFloat(screenWidth.width * 0.8)
        NSLayoutConstraint.activate([
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: eighty_percent),
            //bubbleView.widthAnchor.constraint(equalToConstant: 0),
            bubbleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
        ])
        
        messageBubbleLeading = bubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        messageBubbleTrailing = bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        
    }
    
    
    func configureMessageTime() {
        
        messageTimeBackground.alpha = 0.3
        messageTime.alpha = 1
        messageTime.textColor = .white
        
        messageTime.textAlignment = .right
        
        let messageTimeLeadingConstraint = messageTime.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 13)
        let messageTimeTrailingConstraint = messageTime.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -13)
        
        messageTimeLeadingConstraint.priority = .defaultLow
        messageTimeTrailingConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            messageTimeBackground.leadingAnchor.constraint(equalTo: checkmarkImageView.leadingAnchor, constant: -2),
            
            messageTimeBackground.trailingAnchor.constraint(equalTo: messageTime.trailingAnchor, constant: 2),
            //messageTimeBackground.topAnchor.constraint(equalTo: messageTime.topAnchor, constant: 25),
            messageTimeBackground.topAnchor.constraint(equalTo: messageTime.topAnchor, constant: -2),
            //messageTimeBackground.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor,constant: -10)
            messageTimeBackground.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor, constant: 2),
            
            //messageTime.topAnchor.conƒstraint(equalTo: messageTextLabel.bottomAnchor, constant: 5),
            messageTime.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -10),
//            messageTimeLeadingConstraint,
            messageTimeTrailingConstraint,
        ])
        
        
        configureCheckmark()
    }
    
    func configureCheckmark() {
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        checkmarkImageView.tintColor = .white
        
        
        NSLayoutConstraint.activate([
            //messageTime.topAnchor.conƒstraint(equalTo: messageTextLabel.bottomAnchor, constant: 5),
            checkmarkImageView.centerYAnchor.constraint(equalTo: messageTime.centerYAnchor),
            checkmarkImageView.trailingAnchor.constraint(equalTo: messageTime.leadingAnchor, constant: -5),
            checkmarkImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 15),
            checkmarkImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),
            checkmarkImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 15),
            checkmarkImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 15),
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
