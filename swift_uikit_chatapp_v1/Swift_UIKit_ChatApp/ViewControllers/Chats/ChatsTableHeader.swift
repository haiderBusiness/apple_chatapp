//
//  TableHeader.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 3.6.2023.
//

import UIKit

class ChatsTableHeader: UITableViewHeaderFooterView, UIGestureRecognizerDelegate {

     static let identifier = ids.table_header;
    
     var delegate : UpdateArchivedChatsDelegate?
     
     var headerImageView = UIView();
    
     var headerImage = ImageViewPro();
    
     var headerTitle = UILabel();
    
     let topLineView = UIView()
    
     let bottomLineView = UIView()
     
     var isSelecting = false
    
     let button = HighlightedButton()
    
     var archivedChatrooms: [ChatRoom] = []
     var chatrooms: [ChatRoom] = []
     var navigation: UINavigationController? = nil
    
     var loadingStatus: ChatsLoadingEnum = .waitingForNetwork
    
     
     
     override init(reuseIdentifier: String?) {
         super.init(reuseIdentifier: reuseIdentifier)
         
        
//         self.backgroundColor = .systemBackground
         
         configureImageView();
         configureImage();
         configureTitle();
         configureBottomLine();
         configureButton();
         
         
     }
    
    func configureButton() {
        self.contentView.addSubview(button)
        
        button.backgroundColor = .systemGray6
        button.unhighlightedColor = .systemGray6
        
        button.translatesAutoresizingMaskIntoConstraints = false;
        button.addTarget(self, action: #selector(onPress), for: .touchUpInside)

        if isSelecting {
            button.isEnabled = false
            button.alpha = 0.3
            
        } else {
            button.alpha = 1
            button.isEnabled = true
        }
        
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            button.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    
    // Action method to be called when the view is tapped
    @objc func onPress() {
        
        if !isSelecting {
            let archivedChatsVC = ArchivedChatsVC();
            archivedChatsVC.archivedChatrooms = archivedChatrooms
            archivedChatsVC.chatrooms = chatrooms;
            archivedChatsVC.delegate = self.delegate
            archivedChatsVC.loadingStatus = self.loadingStatus
            self.navigation?.pushViewController(archivedChatsVC, animated: true)
        }
    }
    
    
     func configureImageView() {
         
         button.addSubview(headerImageView)
         //headerImageView.layer.cornerRadius = 20;
         //headerImageView.clipsToBounds = true;
         headerImageView.translatesAutoresizingMaskIntoConstraints = false;
         headerImageView.backgroundColor = .systemGray3
         
         button.backgroundColor = .systemGray6
         
         
         headerImageView.layer.cornerRadius = 20;
         headerImageView.clipsToBounds = true;
         headerImageView.isUserInteractionEnabled = false
         
         NSLayoutConstraint.activate([
            headerImageView.widthAnchor.constraint(equalToConstant: 40),
            headerImageView.heightAnchor.constraint(equalToConstant: 40),
            headerImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: button.leadingAnchor,constant: 20),
         ]);
         
     }
    
    
    func configureImage() {
        
        headerImageView.addSubview(headerImage)
        //headerImageView.layer.cornerRadius = 20;
        //headerImageView.clipsToBounds = true;
        headerImage.tintColor = .white
        headerImage.translatesAutoresizingMaskIntoConstraints = false;
        headerImage.image = UIImage(systemName: "archivebox.fill")
        
        NSLayoutConstraint.activate([
            headerImage.widthAnchor.constraint(equalToConstant: 25),
            headerImage.heightAnchor.constraint(equalToConstant: 25),
            headerImage.centerXAnchor.constraint(equalTo: headerImageView.centerXAnchor),
            headerImage.centerYAnchor.constraint(equalTo: headerImageView.centerYAnchor),
        ]);
        
    }
     
     func configureTitle() {
         button.addSubview(headerTitle);
         headerTitle.translatesAutoresizingMaskIntoConstraints = false;
         headerTitle.numberOfLines = 1;
         headerTitle.adjustsFontSizeToFitWidth = true;
         headerTitle.minimumScaleFactor = 0.7;
         let font = UIFont.systemFont(ofSize: 17);
         let scaledFont = UIFontMetrics.default.scaledFont(for: font);
         headerTitle.font = scaledFont;
         headerTitle.text = Language.archived_chats
         headerTitle.isUserInteractionEnabled = false;
         
         
         NSLayoutConstraint.activate([
            headerTitle.centerYAnchor.constraint(equalTo: button.centerYAnchor),
             headerTitle.leadingAnchor.constraint(equalTo: headerImageView.trailingAnchor, constant: 12)
         ]);
     }
    
    func configureTopLine() {
        
        contentView.addSubview(topLineView)
        topLineView.translatesAutoresizingMaskIntoConstraints = false;
        topLineView.backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([
            topLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            topLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configureBottomLine() {
        
        contentView.addSubview(bottomLineView)
        bottomLineView.translatesAutoresizingMaskIntoConstraints = false;
        bottomLineView.backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([
            bottomLineView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bottomLineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomLineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    
     
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
         
     }
 }
