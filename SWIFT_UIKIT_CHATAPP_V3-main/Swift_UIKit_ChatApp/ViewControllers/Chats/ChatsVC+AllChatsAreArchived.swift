//
//  AllChatsAreArchived.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 12.6.2023.
//

import UIKit

extension ChatsVC {
    
    func showAllChatsAreArchivedMessage() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.navigationItem.searchController = nil
            let customAddChatNav = UIBarButtonItem(customView: self.addChatButtonView)
            self.navigationItem.rightBarButtonItems = [customAddChatNav]
            self.tableView.isScrollEnabled = false
            
            let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
            let messageLabel = UILabel()
            emptyView.addSubview(messageLabel)
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            //messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor, constant: 20).isActive = true
            messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 20).isActive = true
            messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -20).isActive = true
            messageLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -50).isActive = true
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = UIImage(systemName:"square.and.pencil")
            // Set bound to reposition
            let imageOffsetY: CGFloat = -5.0
            imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
            // Create string with attachment
            let attachmentString = NSAttributedString(attachment: imageAttachment)
            // Initialize mutable string
            let completeText = NSMutableAttributedString(string: Language.all_of_your_chats_are_archived_tap_the + " ")
            // Add image to mutable string
            completeText.append(attachmentString)
            // Add your text to mutable string
            let textAfterIcon = NSAttributedString(string: " " + Language.icon_to_start_a_new_chat)
            completeText.append(textAfterIcon)
            messageLabel.textAlignment = .center
            messageLabel.numberOfLines = 0
            messageLabel.font = UIFont.systemFont(ofSize: 17)
            messageLabel.sizeToFit()
            messageLabel.attributedText = completeText
            
            // button under
            let archivedButton = HighlightedButton()
            archivedButton.unhighlightedColor = .systemBackground
            emptyView.addSubview(archivedButton)
            archivedButton.translatesAutoresizingMaskIntoConstraints = false
            archivedButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15).isActive = true
            archivedButton.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor).isActive = true
            archivedButton.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor).isActive = true
            archivedButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
            
            archivedButton.addTarget(self, action: #selector(self.onArchivedChatsPress), for: .touchUpInside)
            self.configureEmptyTopLine(mainView: archivedButton)
            
            archivedButton.setTitle(Language.archived_chats, for: .normal)
            archivedButton.setTitleColor(AppTheme.primaryColor, for: .normal)
            self.configureEmptyBottomLine(mainView: archivedButton)
            
            self.tableView.backgroundView = emptyView
            self.tableView.separatorStyle = .none
//        }
    }
    
    @objc func onArchivedChatsPress() {
        
        if !isSelecting {
            //print("View tapped!")
            // Perform any other actions you want here
            //contentView.backgroundColor = .systemGray4
            self.updateChatsInDatabaseOnDisk(chatrooms: [chatroom], archivedChatrooms: nil)
            let archivedChatsVC = ArchivedChatsVC();
//            archivedChatsVC.archivedChatrooms = archivedChatrooms
            archivedChatsVC.chatrooms = chatrooms;
            archivedChatsVC.delegate = self
            self.navigationController?.pushViewController(archivedChatsVC, animated: true)
        }
    }
    
    
    func configureEmptyTopLine(mainView: UIView) {
        let topLineView = UIView()
        mainView.addSubview(topLineView)
        topLineView.translatesAutoresizingMaskIntoConstraints = false;
        topLineView.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            topLineView.bottomAnchor.constraint(equalTo: mainView.topAnchor),
            topLineView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            topLineView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            topLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func configureEmptyBottomLine(mainView: UIView) {
        let bottomLineView = UIView()
        mainView.addSubview(bottomLineView)
        bottomLineView.translatesAutoresizingMaskIntoConstraints = false;
        bottomLineView.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            bottomLineView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            bottomLineView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            bottomLineView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
