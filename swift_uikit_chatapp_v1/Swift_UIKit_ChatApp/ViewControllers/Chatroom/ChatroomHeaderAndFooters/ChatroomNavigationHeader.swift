//
//  ChatNavigationHeader.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 23.6.2023.
//

import UIKit

extension ChatroomVC {
    
    func configureNavigationView() {
            #if compiler(>=5.1) // ios 13 and above
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = .systemGray6

                // Disable large title display mode
                //navigationController?.navigationBar.prefersLargeTitles = false
                navigationController?.navigationBar.standardAppearance = appearance
                if #available(iOS 15, *) {
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
                }
            #else
            navigationController.navigationBar.barTintColor = .systemBackground
            navigationController.navigationBar.tintColor = .systemBackground
            #endif
        
            //        let stackView = UIStackView()
            //        stackView.axis = .horizontal
            //        stackView.alignment = .center
     
            //print("user first name: ",user.firstName)
            view.addSubview(navigationView)
            navigationView.translatesAutoresizingMaskIntoConstraints = false
            let imageView = ImageViewPro()
            let appName = DataStore.shared.appName
            let diskPath = appName + "/images"
            
            
        
            if let _ = chatroom?.name {
                if let chatroomImageData = chatroom?.image {
                    
                    // show place holder and donwload/load original image from server/disk
                    imageView.showPlaceHolderWhileDonwloadingImage(originalImageUrl: chatroomImageData.photoUrl, placeHolderUrl: chatroomImageData.placeHolderUrl , savePlaceHolder: true,folderName: diskPath)
                    
                    } else {
                        imageView.image = Empty.image
                    }
            }
            else if let userImageData = receivedUser?.avatar {
            
                let placeHolderUrl = userImageData.placeHolderUrl
                let imageUrl = userImageData.photoUrl
                
                
                
//                let diskPath = appName + "/chats/chatsImages"
                imageView.showPlaceHolderWhileDonwloadingImage(originalImageUrl: imageUrl, placeHolderUrl: placeHolderUrl , savePlaceHolder: true,folderName: diskPath)
            } else {
                imageView.image = Empty.image
            }
            
            imageView.contentMode = .scaleAspectFit
            imageView.layer.cornerRadius = 16;
            imageView.clipsToBounds = true
            
            
            
            let titleLabel = UILabel()
            if let chatroomName = chatroom?.name {
                titleLabel.text = chatroomName
            } else if let user = receivedUser {
                titleLabel.text = user.firstName
            }
        
            titleLabel.numberOfLines = 1;
//            titleLabel.adjustsFontSizeToFitWidth = true;
//            titleLabel.minimumScaleFactor = 0.7;
            let titleFont = UIFont.systemFont(ofSize: 17, weight: .semibold);
//            let titleScaledFont = UIFontMetrics.default.scaledFont(for: titleFont);
            titleLabel.font = titleFont;
            
            
            
            
            
            lastSeenLabel.numberOfLines = 1;
//            lastSeenLabel.adjustsFontSizeToFitWidth = true;
//            lastSeenLabel.minimumScaleFactor = 0.7;
            let font = UIFont.systemFont(ofSize: 14);
            lastSeenLabel.textColor  = .systemGray;
            lastSeenLabel.font = font;
            //lastSeenLabel.adjustsFontSizeToFitWidth                 = true;
            //let scaledFont = UIFontMetrics.default.scaledFont(for: font);
            
            
            
            if let _ = chatroom?.name, let unwrapedChatroom = chatroom {
                let number = unwrapedChatroom.usersIds.count
                lastSeenLabel.text = String(number) + " " + Language.members
            }
            else if let lastSeenAt = receivedUser?.lastOnlineAt {
                lastSeenLabel.text = getLastSeenDate(received_date: lastSeenAt)
            }

//            containerView.addSubview(imageView)
            navigationView.addSubview(titleLabel)
            navigationView.addSubview(lastSeenLabel)
            navigationView.backgroundColor = .red

            imageView.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            lastSeenLabel.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
//                imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
//                imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 35),
                imageView.heightAnchor.constraint(equalToConstant: 35),
                
                titleLabel.topAnchor.constraint(equalTo: navigationView.topAnchor, constant: 3),
                titleLabel.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor),
                lastSeenLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
                lastSeenLabel.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: -5),
                lastSeenLabel.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor)
            ])
            
          
            //navigationController?.navigationBar.isTranslucent = false
            
            let rightNavImage = UIBarButtonItem(customView: imageView)
            navigationItem.titleView = navigationView
            navigationItem.rightBarButtonItem = rightNavImage
       
    }
}
