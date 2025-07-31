//
//  AddNewChatCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 12.6.2023.
//

import UIKit

class AddNewChatCell: UITableViewCell {

    var userImageView: ImageViewPro = {
        let userImageView = ImageViewPro();
        userImageView.layer.cornerRadius = 15.2;
        userImageView.clipsToBounds = true;
        userImageView.translatesAutoresizingMaskIntoConstraints = false;
        return userImageView
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
        lastSeenLabel.textColor                                 = .systemGray2;
        lastSeenLabel.adjustsFontSizeToFitWidth                 = true;
        lastSeenLabel.minimumScaleFactor                        = 0.9;
        let font = UIFont.systemFont(ofSize: 14.2)
        let scaledFont = UIFontMetrics.default.scaledFont(for: font)
        lastSeenLabel.font = scaledFont
        
        return lastSeenLabel
    }();
    
    
    var separator = UIView()
    
    
    
    
    //chatImage
    var userImageViewLeadingToSeclectionIcon:        NSLayoutConstraint!;
    var userImageViewLeadingToDefault:               NSLayoutConstraint!;

    
    //labelView   costraint
    var labelViewMinWidthConstraint:                 NSLayoutConstraint!;
    var labelViewMinHeightConstraint:                NSLayoutConstraint!;
    
    
    var selectionWidthConstraint:                    NSLayoutConstraint!;
    
    
    var separatorHeightConstraint: NSLayoutConstraint!;
    var HeaderSeparatorHeightConstraint: NSLayoutConstraint!;
    
    
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
        ])
        separatorHeightConstraint = separator.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        separatorHeightConstraint.isActive = true
    }
    
//    func configureHeaderSeparator() {
//        let headerSeparator = UIView()
//        addSubview(headerSeparator)
//        headerSeparator.translatesAutoresizingMaskIntoConstraints = false;
//        headerSeparator.backgroundColor = .systemGray5
//
//        NSLayoutConstraint.activate([
//            headerSeparator.topAnchor.constraint(equalTo:topAnchor),
//            headerSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
//            headerSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
//        ])
//
//        HeaderSeparatorHeightConstraint =  headerSeparator.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
//        HeaderSeparatorHeightConstraint.isActive =  true
//    }

    
    
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
        
        selectionWidthConstraint = selectionIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -25)
        selectionWidthConstraint.isActive = true
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
            userImageView.widthAnchor.constraint(equalToConstant: 42),
            userImageView.heightAnchor.constraint(equalToConstant: 42),
            //userImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            userImageView.leadingAnchor.constraint(equalTo: selectionIcon.trailingAnchor,constant: 12),
            
            //chatTitle
            userName.topAnchor.constraint(equalTo: userImageView.topAnchor),
            userName.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),
            
            //chatDate
            lastSeenLabel.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 0),
            lastSeenLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),
        ]);
        
//        configureHeaderSeparator()
        configureSeparator()
        
        //selection
        
        
        
        
        
        //ImageView
        //userImageViewLeadingToSeclectionIcon = userImageView.leadingAnchor.constraint(equalTo: selectionIcon.trailingAnchor, constant: 12);
        //userImageViewLeadingToDefault = userImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12);
        
    }
    
    

    
    func set(user: User, isSelecting: Bool) {
        
        if let lastSeenDate = user.lastOnlineAt {
            lastSeenLabel.text = getLastSeenDate(received_date: lastSeenDate)
        }
       
        
        
        if isSelecting {
            selectionIcon.alpha = 1
            self.selectionWidthConstraint.constant = 25
        } else {
            selectionIcon.alpha = 0
            self.selectionWidthConstraint.constant = -25
        }
        
      
        
        if user.isSelected {
            selectionIcon.tintColor = AppTheme.primaryColor
            selectionIcon.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            selectionIcon.tintColor = .systemGray3
            selectionIcon.image = UIImage(systemName: "circle")
        }
        
        
        
        
        //self.configureMarksConstraints(chat: user)
        
        if let userImageData = user.avatar {
//            userImageView.load(urlString: photoUrl)
            let placeHolderUrl = userImageData.placeHolderUrl
            let imageUrl = userImageData.photoUrl
            
            var fileName = placeHolderUrl.replacingOccurrences(of: "https://", with: "")
            fileName = fileName.replacingOccurrences(of: "http://", with: "")
        
            userImageView.showPlaceHolderWhileDonwloadingImage(originalImageUrl: imageUrl, placeHolderUrl: placeHolderUrl , savePlaceHolder: true,folderName: diskPath)
            
        } else {
            userImageView.image = Empty.image
        }
       
        userName.text = user.firstName
    }
    
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
