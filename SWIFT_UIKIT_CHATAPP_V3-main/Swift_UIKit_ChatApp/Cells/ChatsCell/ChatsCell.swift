//
//  ChatsItem.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 30.5.2023.
//

import UIKit
import MapKit

class ChatsCell: UITableViewCell {
    
    
    var chatImageView: ImageViewPro = {
        let chatImageView = ImageViewPro();
        chatImageView.layer.cornerRadius = 20;
        chatImageView.clipsToBounds = true;
        chatImageView.translatesAutoresizingMaskIntoConstraints = false;
        return chatImageView
    }();
    
    
    
    var chatTitle: UILabel = {
        var chatTitle = UILabel()
        chatTitle.translatesAutoresizingMaskIntoConstraints = false;
        chatTitle.numberOfLines = 1;
//        chatTitle.adjustsFontSizeToFitWidth = true;
//        chatTitle.minimumScaleFactor = 0.7;
        let font = UIFont.systemFont(ofSize: 17);
        let scaledFont = UIFontMetrics.default.scaledFont(for: font);
        chatTitle.font = scaledFont;
        
        return chatTitle
    }();
    
    
    
    var chatMessage: UILabel = {
        
        var chatMessage = UILabel()
        chatMessage.translatesAutoresizingMaskIntoConstraints = false;
        chatMessage.numberOfLines = 2;
        //chatMessage.adjustsFontSizeToFitWidth = true;
        //chatMessage.minimumScaleFactor = 0.8;
        chatMessage.textColor = .systemGray;
        
        let font = UIFont.systemFont(ofSize: 15)
        let scaledFont = UIFontMetrics.default.scaledFont(for: font)
        chatMessage.font = scaledFont
        
        return chatMessage
        
    }();
    

    var chatDate: UILabel = {
        var chatDate = UILabel();
        chatDate.translatesAutoresizingMaskIntoConstraints = false;
        chatDate.numberOfLines                             = 1;
        chatDate.textColor                                 = .systemGray;
        chatDate.adjustsFontSizeToFitWidth                 = true;
        chatDate.minimumScaleFactor                        = 0.9;
        let font = UIFont.systemFont(ofSize: 13)
        let scaledFont = UIFontMetrics.default.scaledFont(for: font)
        chatDate.font = scaledFont
        
        return chatDate
    }();
    
    
    let countView: UIView = {
        var labelView = UILabel()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.backgroundColor = AppTheme.primaryColor
        labelView.layer.cornerRadius = 9.5;
        labelView.layer.masksToBounds = true
        return labelView
    }();
    
    
    var chatUnreadMessages: UILabel={
        var chatUnReadMessages = UILabel()
        chatUnReadMessages.translatesAutoresizingMaskIntoConstraints = false;
        chatUnReadMessages.numberOfLines = 1;
        chatUnReadMessages.textColor = .white;
        let font = UIFont.systemFont(ofSize: 11.5)
        let scaledFont = UIFontMetrics.default.scaledFont(for: font)
        chatUnReadMessages.font = scaledFont
        chatUnReadMessages.textAlignment = .center
        return chatUnReadMessages
    }();
    
    

    var unreadMark: UIView={
        var unreadMark = UIView()
        unreadMark.translatesAutoresizingMaskIntoConstraints = false;
        unreadMark.backgroundColor = .systemBlue
        unreadMark.layer.cornerRadius = 9;
        unreadMark.layer.masksToBounds = true
        return unreadMark
        
    }();
    
    //private let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .ultraLight, scale: .medium)
    
    var pinMark: UIImageView = {
        var pinMark = UIImageView()
        pinMark.translatesAutoresizingMaskIntoConstraints = false;
        pinMark.image = UIImage(systemName: "pin.fill")
        pinMark.tintColor = .systemGray4
        return pinMark
    }();
    
    
    var muteMark: UIImageView = {
        var muteMark = UIImageView()
        muteMark.translatesAutoresizingMaskIntoConstraints = false;
        muteMark.image = UIImage(systemName: "speaker.slash.fill")
        muteMark.tintColor = AppTheme.sucsessColor
        return muteMark
    }();
    
    
    var appName: String!
    var diskPath: String!
    var fileName: String!
    var deviceId: String!
    
    
    
//    let selectionIcon: ImageViewPro = {
//        var selectionIcon = ImageViewPro()
//        selectionIcon.translatesAutoresizingMaskIntoConstraints = false
//        selectionIcon.layer.cornerRadius = 12;
//        selectionIcon.layer.masksToBounds = true
//        selectionIcon.tintColor = .systemGray3
//        selectionIcon.image = UIImage(systemName: "circle")
//        return selectionIcon
//    }();
    
    
    
    
    
    //chatImage
    var chatImageViewLeadingToSeclectionIcon:        NSLayoutConstraint!;
    var chatImageViewLeadingToDefault:               NSLayoutConstraint!;
    
    //chatMessage costraint
    var messageTrailingConstraintDefault:            NSLayoutConstraint!;
    var messageTrailingConstraintToCountView:        NSLayoutConstraint!;
    var messageTrailingToMuteMarkConstraint:         NSLayoutConstraint!;
    var messageTrailingToPinMarkConstraint:          NSLayoutConstraint!;
    var messageTrailingToUnreadMark:                 NSLayoutConstraint!;
    
    
    //labelView   costraint
    var labelViewMinWidthConstraint:                 NSLayoutConstraint!;
    var labelViewMinHeightConstraint:                NSLayoutConstraint!;
    
    //unreadMark  costraint
    var unreadMarkMinWidthConstraint:                NSLayoutConstraint!;
    var unreadMarkMinHeightConstraint:               NSLayoutConstraint!;
    
    //pinMark     costraint
    var pinMarkMinWidthConstraint:                   NSLayoutConstraint!;
    var pinMarkMinHeightConstraint:                  NSLayoutConstraint!;
    var pinMarkTrailingDefaultConstraint:            NSLayoutConstraint!;
    var pinMarkTrailingToUnreadMarkConstraint:       NSLayoutConstraint!;
    var pinMarkTrailingToUnreadMessagesConstraint:   NSLayoutConstraint!;
    
    //muteMark     costraint
    var muteMarkMinWidthConstraint:                  NSLayoutConstraint!;
    var muteMarkMinHeightConstraint:                 NSLayoutConstraint!;
    var muteMarkTrailingDefaultConstraint:           NSLayoutConstraint!;
    var muteMarkTrailingToUnreadMarkConstraint:      NSLayoutConstraint!;
    var muteMarkTrailingToUnreadMessagesConstraint:  NSLayoutConstraint!;
    var muteMarkTrailingToPinMarkConstraint:         NSLayoutConstraint!;
    
    var selectionLeadingConstraint:                    NSLayoutConstraint!;
    
    
    var isFirstLoad = true;
    var ISselected = false;
    
    
    var selectionIcon = UIImageView();
    
    
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
        selectionStyle = .default
    }
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        configureSelection();
        configureUI();
        
        appName = DataStore.shared.appName
        deviceId = DataStore.shared.deviceUniqueIdentifier
//        diskPath = appName + "/chats/chatsImages"
        diskPath = appName + "/images"
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    
    func configureSelection() {
            
        addSubview(selectionIcon)
        selectionIcon.translatesAutoresizingMaskIntoConstraints = false
        selectionIcon.layer.cornerRadius = 12;
        selectionIcon.layer.masksToBounds = true
        selectionIcon.tintColor = .systemGray3
        selectionIcon.image = UIImage(systemName: "circle")
        
//        selectionIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        selectionIcon.widthAnchor.constraint(lessThanOrEqualToConstant: 25).isActive = true
        selectionIcon.heightAnchor.constraint(lessThanOrEqualToConstant: 25).isActive = true
        selectionIcon.widthAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        selectionIcon.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        selectionIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        selectionLeadingConstraint = selectionIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -25)
        selectionLeadingConstraint.isActive = true
    }
    
    
    func configureUI() {
        
        addSubview(chatImageView);
        addSubview(chatTitle);
        addSubview(chatMessage);
        addSubview(countView);
        countView.addSubview(chatUnreadMessages);
        addSubview(chatDate);
        addSubview(unreadMark);
        addSubview(pinMark);
        addSubview(muteMark);
        //addSubview(selectionIcon)
        
        
        configureChatImage()
        
        
        NSLayoutConstraint.activate([
            
            //selectionCircle
            
            
            //chatTitle
            chatTitle.topAnchor.constraint(equalTo: chatImageView.topAnchor),
            chatTitle.leadingAnchor.constraint(equalTo: chatImageView.trailingAnchor, constant: 12),
            
            //chatDate
            chatDate.topAnchor.constraint(equalTo: chatImageView.topAnchor),
            chatDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            //chatMessage
            chatMessage.topAnchor.constraint(equalTo: chatTitle.bottomAnchor, constant: 2.5),
            chatMessage.leadingAnchor.constraint(equalTo: chatImageView.trailingAnchor, constant: 12),
            
            
            //countMessagesView
            countView.topAnchor.constraint(equalTo: chatDate.bottomAnchor, constant: 2.5),
            countView.trailingAnchor.constraint(equalTo: chatDate.trailingAnchor),
            
            //chatUnReadMessages
            chatUnreadMessages.topAnchor.constraint(equalTo: countView.topAnchor),
            chatUnreadMessages.leadingAnchor.constraint(equalTo: countView.leadingAnchor),
            chatUnreadMessages.trailingAnchor.constraint(equalTo: countView.trailingAnchor),
            chatUnreadMessages.bottomAnchor.constraint(equalTo: countView.bottomAnchor),
            
            
            unreadMark.topAnchor.constraint(equalTo: chatDate.bottomAnchor, constant: 2.5),
            unreadMark.trailingAnchor.constraint(equalTo: chatDate.trailingAnchor),
            
            //pinkMark
            pinMark.topAnchor.constraint(equalTo: chatDate.bottomAnchor, constant: 2.5),
            
            //muteMark
            muteMark.topAnchor.constraint(equalTo: chatDate.bottomAnchor, constant: 2.5),
            
  
        ]);
        
        
        
        //selection
        
        
        
        
        
        //ImageView
        //chatImageViewLeadingToSeclectionIcon = chatImageView.leadingAnchor.constraint(equalTo: selectionIcon.trailingAnchor, constant: 12);
        //chatImageViewLeadingToDefault = chatImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12);
        
        
        
        
  
        //chatMessage
        messageTrailingConstraintDefault =  chatMessage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15);
        messageTrailingConstraintToCountView = chatMessage.trailingAnchor.constraint(equalTo: countView.leadingAnchor, constant: -15);
        messageTrailingToMuteMarkConstraint = chatMessage.trailingAnchor.constraint(equalTo: muteMark.leadingAnchor, constant: -2.5)
        messageTrailingToPinMarkConstraint = chatMessage.trailingAnchor.constraint(equalTo: pinMark.leadingAnchor, constant: -2.5)
        messageTrailingToUnreadMark = chatMessage.trailingAnchor.constraint(equalTo: unreadMark.leadingAnchor, constant: -2.5)
        
        //messageTrailingToPinMarkConstraint.priority = .defaultLow
        
        
        
        //unreadMark
        unreadMarkMinWidthConstraint = unreadMark.widthAnchor.constraint(greaterThanOrEqualToConstant: 20)
        unreadMarkMinHeightConstraint = unreadMark.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        unreadMark.widthAnchor.constraint(lessThanOrEqualToConstant: 18).isActive = true
        
        
        //pinkMark
        pinMarkMinWidthConstraint = pinMark.widthAnchor.constraint(greaterThanOrEqualToConstant: 22)
        pinMarkMinHeightConstraint = pinMark.heightAnchor.constraint(greaterThanOrEqualToConstant: 22)
        pinMark.widthAnchor.constraint(lessThanOrEqualToConstant: 18).isActive = true

        pinMarkTrailingDefaultConstraint =  pinMark.trailingAnchor.constraint(equalTo: chatDate.trailingAnchor)
        pinMarkTrailingToUnreadMessagesConstraint = pinMark.trailingAnchor.constraint(equalTo: chatUnreadMessages.leadingAnchor, constant: -2.5)
        pinMarkTrailingToUnreadMarkConstraint = pinMark.trailingAnchor.constraint(equalTo: unreadMark.leadingAnchor, constant: -2.5)
        
    
        //muteMark
        muteMarkMinWidthConstraint = muteMark.widthAnchor.constraint(greaterThanOrEqualToConstant: 22)
        muteMarkMinHeightConstraint = muteMark.heightAnchor.constraint(greaterThanOrEqualToConstant: 22)
        muteMark.widthAnchor.constraint(lessThanOrEqualToConstant: 18).isActive = true
        
        muteMarkTrailingDefaultConstraint =  muteMark.trailingAnchor.constraint(equalTo: chatDate.trailingAnchor)
        muteMarkTrailingToUnreadMessagesConstraint = muteMark.trailingAnchor.constraint(equalTo: chatUnreadMessages.leadingAnchor, constant: -2.5)
        muteMarkTrailingToUnreadMarkConstraint = muteMark.trailingAnchor.constraint(equalTo: unreadMark.leadingAnchor, constant: -2.5)
        
        muteMarkTrailingToPinMarkConstraint = muteMark.trailingAnchor.constraint(equalTo: pinMark.leadingAnchor, constant: -2.5)
        labelViewMinWidthConstraint = countView.widthAnchor.constraint(greaterThanOrEqualToConstant: 22)
        labelViewMinHeightConstraint = countView.heightAnchor.constraint(greaterThanOrEqualToConstant: 22)
        
    }
    
    
    
    func configureChatImage() {
        NSLayoutConstraint.activate([
            //imageView
            chatImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chatImageView.widthAnchor.constraint(equalToConstant: 50),
            chatImageView.heightAnchor.constraint(equalToConstant: 50),
            //chatImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            chatImageView.leadingAnchor.constraint(equalTo: selectionIcon.trailingAnchor,constant: 15),
        ])
    }
    
    

    
    func set(chat: ChatRoom, user: User, isSelecting: Bool) {
        
        chatDate.text = getLastMessageTime(received_timestamp: chat.lastMessageDate)
        
//        print("chat text", chat.lastMessage)
//        chatDate.text = "\(chat.lastMessageDate)"
        
        
        if isSelecting {
            //Animation()
            selectionIcon.alpha = 1
            //chatImageViewLeadingToDefault.isActive = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.selectionLeadingConstraint.constant = 25
                UIView.animate(withDuration: 0.2) {
                    self.layoutIfNeeded()
                }
            }
        } else {
            selectionIcon.alpha = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.selectionLeadingConstraint.constant = -25
                UIView.animate(withDuration: 0.2) {
                    
                    self.layoutIfNeeded()
                }
            }
            //chatImageViewLeadingToSeclectionIcon.isActive = false
            //chatImageViewLeadingToDefault.isActive = true
        }
        
        if chat.selected {
            self.backgroundColor = .systemGray5
            selectionIcon.tintColor = AppTheme.primaryColor
            selectionIcon.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            self.backgroundColor = .systemBackground
            selectionIcon.tintColor = .systemGray3
            selectionIcon.image = UIImage(systemName: "circle")
        }
        
        
        
        
        self.configureMarksConstraints(chat: chat)
        
        chatImageView.tintColor = AppTheme.primaryColor
        
        
        if let _ = chat.name {
            if let chatroomImageData = chat.image {
                    
//                        if let image = chatroomImage as? UIImage {
//                            // It's a UIImage
//                            chatImageView.image = image
//                        } else

                        // It's a String
//                    chatImageView.load(urlString: chatroomImage)
                
                    let placeHolderUrl = chatroomImageData.placeHolderUrl
                    let imageUrl = chatroomImageData.photoUrl

                    chatImageView.showPlaceHolderWhileDonwloadingImage(originalImageUrl: imageUrl, placeHolderUrl: placeHolderUrl , savePlaceHolder: true,folderName: diskPath)
                    
                } else {
                        chatImageView.image = Empty.image
                }
        }
        else if let userImageData = user.avatar {
//            chatImageView.load(urlString: photoUrl)
            let placeHolderUrl = userImageData.placeHolderUrl
            let imageUrl = userImageData.photoUrl
            let photoDeviceId = userImageData.savedOnDeviceId
            
            var fileName = placeHolderUrl.replacingOccurrences(of: "https://", with: "")
            fileName = fileName.replacingOccurrences(of: "http://", with: "")
        
        
            if  deviceId == photoDeviceId {
                chatImageView.LoadSaveDisplayImage(originalImageUrl: imageUrl, placeHolderUrl: placeHolderUrl , savePlaceHolder: false,folderName: diskPath)
            } else {
                chatImageView.showPlaceHolderWhileDonwloadingImage(originalImageUrl: imageUrl, placeHolderUrl: placeHolderUrl , savePlaceHolder: true,folderName: diskPath)
            }
        } else {
            chatImageView.image = Empty.image
        }
            
        if let ChatroomName = chat.name {
            chatTitle.text = ChatroomName
        } else {
            chatTitle.text = user.firstName
        }
           
        chatMessage.text = chat.lastMessage
    }
    
    
    

    
    
    
    func Animation() {
        
    }

    
    
    
    


    
   
    
    

    
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
