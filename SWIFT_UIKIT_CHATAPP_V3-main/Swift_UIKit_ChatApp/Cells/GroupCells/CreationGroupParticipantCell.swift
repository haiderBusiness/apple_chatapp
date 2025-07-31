//
//  CreationGroupParticipantCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 19.6.2023.
//

import UIKit

class CreationGroupParticipantCell: UITableViewCell {
    
    
    var removeButtonAction: (() -> Void) = {}
    

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
    
    
    let removeImageContainer = HighlightedButton();
    
    
    
    var mainView: UIView = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        //mainView.unhighlightedColor = .systemBackground
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        return mainView
    }()
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
        selectionStyle = .none
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
        mainView.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false;
        separator.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            separator.topAnchor.constraint(equalTo:mainView.topAnchor),
            separator.leadingAnchor.constraint(equalTo: leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
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
        contentView.addSubview(mainView)
        
    
        mainView.addSubview(removeImageContainer)
        mainView.backgroundColor = .systemBackground
        
        removeImageContainer.translatesAutoresizingMaskIntoConstraints = false
        removeImageContainer.backgroundColor = .systemRed
        removeImageContainer.unhighlightedColor = .systemRed
        removeImageContainer.layer.cornerRadius = 25 * 0.45
        removeImageContainer.clipsToBounds = true
        
        
        let removeIcon = ImageViewPro()
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 10, weight: .bold)
        let image = UIImage(systemName: "xmark")
        removeIcon.image = image
        removeIcon.preferredSymbolConfiguration = symbolConfiguration
        removeIcon.tintColor = .white
        removeIcon.translatesAutoresizingMaskIntoConstraints = false
        removeImageContainer.addSubview(removeIcon)
        //selectionIcon.image = UIImage(systemName: "circle")
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            removeImageContainer.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15),
            removeImageContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 25),
            removeImageContainer.heightAnchor.constraint(lessThanOrEqualToConstant: 25),
            removeImageContainer.widthAnchor.constraint(greaterThanOrEqualToConstant: 25),
            removeImageContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 25),
            removeImageContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            removeIcon.centerXAnchor.constraint(equalTo: removeImageContainer.centerXAnchor),
            removeIcon.centerYAnchor.constraint(equalTo: removeImageContainer.centerYAnchor),
        ])
        
        removeIcon.isUserInteractionEnabled = false
        
        
        
//        selectionWidthConstraint = removeImageContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25)
//        selectionWidthConstraint.isActive = true
        removeImageContainer.alpha = 1
    }
    
    @objc func onRemovePress() {
        
        print("pressed")
        removeButtonAction()
    }
    
    func configureUI() {
        
        mainView.addSubview(userImageView);
        mainView.addSubview(userName);
        mainView.addSubview(lastSeenLabel);
        //addSubview(selectionIcon)
        
        NSLayoutConstraint.activate([
            
            //selectionCircle
            
            
            //imageView
            userImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            userImageView.widthAnchor.constraint(equalToConstant: 38),
            userImageView.heightAnchor.constraint(equalToConstant: 38),
            //chatImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            userImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,constant: 15),
            
            //chatTitle
            userName.topAnchor.constraint(equalTo: userImageView.topAnchor),
            userName.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),
            
            //chatDate
            lastSeenLabel.bottomAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: -2),
            lastSeenLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 12),
        ]);
        
        mainView.bringSubviewToFront(removeImageContainer)
        removeImageContainer.addTarget(self, action: #selector(onRemovePress), for: .touchUpInside)
        
        lastSeenLabel.isUserInteractionEnabled = false
        userName.isUserInteractionEnabled = false
        
        userImageView.isUserInteractionEnabled = false
        mainView.isUserInteractionEnabled = true
        removeImageContainer.isUserInteractionEnabled = true
    }
    
    

    
    func set(user: User) {
        
        if let lastSeenDate = user.lastOnlineAt {
            lastSeenLabel.text = getLastSeenDate(received_date: lastSeenDate)
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
