//
//  SelectingUsersForGroupCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 21.6.2023.
//

import UIKit

class SelectingUsersForGroupCell: UITableViewCell {
    
    var userImageView: ImageViewPro = {
        let chatImageView = ImageViewPro();
        chatImageView.layer.cornerRadius = 15.2;
        chatImageView.clipsToBounds = true;
        chatImageView.translatesAutoresizingMaskIntoConstraints = false;
        return chatImageView
    }();
    
    
    
    var userName: UILabel = {
        var chatTitle = UILabel()
        chatTitle.translatesAutoresizingMaskIntoConstraints = false;
        chatTitle.numberOfLines = 1;
        chatTitle.adjustsFontSizeToFitWidth = true;
        chatTitle.minimumScaleFactor = 0.7;
        let font = UIFont.systemFont(ofSize: 17);
        let scaledFont = UIFontMetrics.default.scaledFont(for: font);
        chatTitle.font = scaledFont;
        
        return chatTitle
    }();
    
    

    var lastSeenLabel: UILabel = {
        var lastSeenLabel = UILabel();
        lastSeenLabel.translatesAutoresizingMaskIntoConstraints = false;
        lastSeenLabel.numberOfLines                             = 1;
        lastSeenLabel.textColor                                 = .systemGray;
        lastSeenLabel.adjustsFontSizeToFitWidth                 = true;
        lastSeenLabel.minimumScaleFactor                        = 0.9;
        let font = UIFont.systemFont(ofSize: 13)
        let scaledFont = UIFontMetrics.default.scaledFont(for: font)
        lastSeenLabel.font = scaledFont
        
        return lastSeenLabel
    }();
    
    
    var separator = UIView()
    
    
    
    
    //chatImage
    var chatImageViewLeadingToSeclectionIcon:        NSLayoutConstraint!;
    var chatImageViewLeadingToDefault:               NSLayoutConstraint!;

    
    //labelView   costraint
    var labelViewMinWidthConstraint:                 NSLayoutConstraint!;
    var labelViewMinHeightConstraint:                NSLayoutConstraint!;
    
    
    var selectionWidthConstraint:                    NSLayoutConstraint!;
    
    
    var isFirstLoad = true;
    var ISselected = false;
    
    
    var selectionIcon = ImageViewPro();
    
    
    
    
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
        selectionStyle = .default
    }
    
    
    var appName: String!
    var diskPath: String!
    var fileName: String!
    var deviceId: String!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
//        configureSeparator()
        configureSelection();
        configureUI();
        appName = DataStore.shared.appName
        deviceId = DataStore.shared.deviceUniqueIdentifier
//        diskPath = appName + "/users/images"
        diskPath = appName + "/images"
    }
    
    func configureSeparator() {
        addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false;
        separator.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo:topAnchor),
            separator.leadingAnchor.constraint(equalTo: userName.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(greaterThanOrEqualToConstant: 0.5)
        ])
    }
    
    func configureHeaderSeparator() {
        addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false;
        separator.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo:topAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: trailingAnchor),
            separator.heightAnchor.constraint(greaterThanOrEqualToConstant: 0.5)
        ])
    }

    
    
    func configureSelection() {
            
        addSubview(selectionIcon)
        selectionIcon.translatesAutoresizingMaskIntoConstraints = false
        selectionIcon.layer.cornerRadius = 12;
        selectionIcon.layer.masksToBounds = true
        selectionIcon.tintColor = .systemGray3
        //selectionIcon.image = UIImage(systemName: "circle")
        
        selectionIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        selectionIcon.widthAnchor.constraint(lessThanOrEqualToConstant: 25).isActive = true
        selectionIcon.heightAnchor.constraint(lessThanOrEqualToConstant: 25).isActive = true
        selectionIcon.widthAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        selectionIcon.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        selectionIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
//        selectionWidthConstraint = selectionIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25)
//        selectionWidthConstraint.isActive = true
    }
    
    
    func configureUI() {
        
        addSubview(userImageView);
        addSubview(userName);
        addSubview(lastSeenLabel);
        //addSubview(selectionIcon)
        
        NSLayoutConstraint.activate([
            
            //selectionCircle
            
            
            //imageView
            userImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 38),
            userImageView.heightAnchor.constraint(equalToConstant: 38),
            //chatImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            userImageView.leadingAnchor.constraint(equalTo: selectionIcon.trailingAnchor,constant: 12),
            
            //chatTitle
            userName.topAnchor.constraint(equalTo: userImageView.topAnchor),
            userName.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),
            
            //chatDate
            lastSeenLabel.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: -2),
            lastSeenLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),
        ]);
        
        
        
        //selection
        
        
        
        
        
        //ImageView
        //chatImageViewLeadingToSeclectionIcon = chatImageView.leadingAnchor.constraint(equalTo: selectionIcon.trailingAnchor, constant: 12);
        //chatImageViewLeadingToDefault = chatImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12);
        
        
    }
    
    

    
    func set(user: User) {
        
        if let lastSeenDate = user.lastOnlineAt {
            lastSeenLabel.text = getLastSeenDate(received_date: lastSeenDate)
        }
       
        
        
//        if isSelecting {
//            selectionIcon.alpha = 1
//            self.selectionWidthConstraint.constant = 25
//        } else {
//            selectionIcon.alpha = 0
//            self.selectionWidthConstraint.constant = -25
//        }
        
      
        
        if user.isSelected {
            selectionIcon.tintColor = AppTheme.primaryColor
            selectionIcon.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            selectionIcon.tintColor = .systemGray3
            selectionIcon.image = UIImage(systemName: "circle")
        }
        
        
        
        
        //self.configureMarksConstraints(chat: user)
        
        if let avatarData = user.avatar {
                let placeHolderUrl = avatarData.placeHolderUrl
                let imageUrl = avatarData.photoUrl

                userImageView.showPlaceHolderWhileDonwloadingImage(originalImageUrl: imageUrl, placeHolderUrl: placeHolderUrl , savePlaceHolder: true,folderName: diskPath)
        } else {
            userImageView.icon()
        }
       
        userName.text = user.firstName
    }
    
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
