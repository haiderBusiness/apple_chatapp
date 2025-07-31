//
//  GroupCollectionCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 15.6.2023.
//

import UIKit

class GroupHeaderCell: UICollectionViewCell {
    
    var removeButtonAction: (() -> Void) = {}
    
    private let userFirstName = UILabel()
    private let userAvatar = ImageViewPro()
    private let mainView = UIView()
    
//    private let removeImage: ImageViewPro = {
//        let removeImage = ImageViewPro()
//        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 15)
//        let image = UIImage(systemName: "xmark.circle.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal).withConfiguration(symbolConfiguration)
//        removeImage.image = image
//        removeImage.translatesAutoresizingMaskIntoConstraints = false
//        return removeImage
//    }()
    var appName: String!
    var diskPath: String!
    var fileName: String!
    var deviceId: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        appName = DataStore.shared.appName
        deviceId = DataStore.shared.deviceUniqueIdentifier
//        diskPath = appName + "/users/images"
        diskPath = appName + "/images"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        //addSubview(mainView)
//        mainView.translatesAutoresizingMaskIntoConstraints = false
////        mainView.backgroundColor = .systemGray6
//        mainView.backgroundColor = .red
//
//        NSLayoutConstraint.activate([
//            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            mainView.topAnchor.constraint(equalTo: topAnchor),
//            mainView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
        // Customize the cell's appearance
        
        
        // Configure image
        userAvatar.layer.cornerRadius = 20;
        userAvatar.clipsToBounds = true;
        userAvatar.translatesAutoresizingMaskIntoConstraints = false;
        addSubview(userAvatar)
        
        
        
        
        // Configure label
        userFirstName.textAlignment = .center
        userFirstName.font = UIFont.systemFont(ofSize: 12, weight: .light)
        userFirstName.numberOfLines = 1
        //userFirstName.adjustsFontSizeToFitWidth = true
        userFirstName.translatesAutoresizingMaskIntoConstraints = false
        addSubview(userFirstName)
        
        
        
        //icon view
        let iconView = UIButton()
        iconView.layer.cornerRadius = 8
        iconView.clipsToBounds = true
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.backgroundColor = .systemRed
        iconView.layer.zPosition = 3
        
        iconView.addTarget(self, action: #selector(onRemovePress), for: .touchUpInside)
        
        addSubview(iconView)
        
        
        //icon
        let removeIcon = ImageViewPro()
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 10, weight: .bold)
        let image = UIImage(systemName: "xmark")
        removeIcon.image = image
        removeIcon.preferredSymbolConfiguration = symbolConfiguration
        removeIcon.tintColor = .white
        removeIcon.translatesAutoresizingMaskIntoConstraints = false
        iconView.addSubview(removeIcon)
        
        // Add constraints for label
        NSLayoutConstraint.activate([
            
            // user image
            userAvatar.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            userAvatar.widthAnchor.constraint(equalToConstant: 50),
            userAvatar.heightAnchor.constraint(equalToConstant: 50),
            userAvatar.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            
            //icon view
            iconView.topAnchor.constraint(equalTo: userAvatar.topAnchor, constant: -7 ),
            iconView.trailingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 7),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            
            
            // icon
            removeIcon.centerXAnchor.constraint(equalTo: iconView.centerXAnchor),
            removeIcon.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            
            
            //text
            userFirstName.leadingAnchor.constraint(equalTo: leadingAnchor),
            userFirstName.trailingAnchor.constraint(equalTo: trailingAnchor),
            userFirstName.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 6),
        ])
    }
    
    
    @objc func onRemovePress() {
        removeButtonAction()
    }
    
    func configure(with user: User) {
        
        // Configure the cell with item's content
        if let avatarData = user.avatar {
                let placeHolderUrl = avatarData.placeHolderUrl
                let imageUrl = avatarData.photoUrl
            
                userAvatar.showPlaceHolderWhileDonwloadingImage(originalImageUrl: imageUrl, placeHolderUrl: placeHolderUrl , savePlaceHolder: true,folderName: diskPath)

        } else {
            userAvatar.image = Empty.image
        }
        
        //text
        userFirstName.text = user.firstName
    }
}





