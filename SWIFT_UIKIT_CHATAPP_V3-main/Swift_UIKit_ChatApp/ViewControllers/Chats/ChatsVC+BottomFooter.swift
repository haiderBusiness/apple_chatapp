//
//  BottomFooter.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 10.6.2023.
//

import UIKit


extension ChatsVC {
    
    func checkForUnreadMessages() {

            self.hasUnread = chatrooms.contains { chatRoom in
            chatRoom.unreadCount > 0 || chatRoom.markUnRead
            }
    }
    
    func createBottomFooter() {
        self.view.addSubview(self.bottomFooterView)
        bottomFooterView.backgroundColor = .systemGray6
        bottomFooterView.translatesAutoresizingMaskIntoConstraints = false
        
        //self.view.safeAreaLayoutGuide.bottomAnchor
        bottomFooterView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        bottomFooterView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        self.bottomFooterConstraint = bottomFooterView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 100)
        //bottomFooterView.alpha = 0
        bottomFooterConstraint.isActive = true
        
        configureBottomFooter()
    }
    
    
    func configureBottomFooter() {
        checkForUnreadMessages()
        createReadAllButton()
        createArchiveButton()
        createDeleteButton()
    }
    
    
    func createReadAllButton() {
        bottomFooterView.addSubview(readAllButton)
        readAllButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let isSelectedItemHasUnreadValue = self.selectedIndexPaths.contains { indexPath in
            chatrooms[indexPath.row].markUnRead || chatrooms[indexPath.row].unreadCount > 0
            }
        

        if !hasUnread {
            readAllButton.setTitleColor(.systemGray, for: .normal)
        } else if self.selectedIndexPaths.count > 0 && hasUnread && isSelectedItemHasUnreadValue {
            readAllButton.setTitleColor(AppTheme.primaryColor, for: .normal)
        } else if !isSelectedItemHasUnreadValue {
            readAllButton.setTitleColor(.systemGray, for: .normal)
        }
        
        if hasUnread && self.selectedIndexPaths.count < 1 {
            readAllButton.setTitle(Language.read_all, for: .normal)
            readAllButton.setTitleColor(AppTheme.primaryColor, for: .normal)
        } else {
            readAllButton.setTitle(Language.read, for: .normal)
        }
        
        
        readAllButton.translatesAutoresizingMaskIntoConstraints = false
        readAllButton.leadingAnchor.constraint(equalTo: bottomFooterView.leadingAnchor, constant: 18).isActive = true
        readAllButton.topAnchor.constraint(equalTo: bottomFooterView.topAnchor, constant: 6).isActive = true
        
        
        readAllButton.addTarget(self, action: #selector(onReadAllPress), for: .touchUpInside)
    }
    
    
    
    
    @objc func onReadAllPress() {
        
        var chatroomsToUpdate: [ChatRoom] = []
        
        if(self.selectedIndexPaths.count > 0) {
            self.tableView.beginUpdates()
            // DataStore.shared.chatrooms.remove(at: indexPath.row)
            for index in self.selectedIndexPaths.sorted(by: >) {
                self.chatrooms[index.row].unreadCount = 0
                self.chatrooms[index.row].markUnRead = false
                self.chatrooms[index.row].selected = false
                chatroomsToUpdate.append(self.chatrooms[index.row])
            }
            tableView.reloadRows(at: selectedIndexPaths, with: .fade)
            self.tableView.endUpdates()
            
        } else if hasUnread {
            for(index, chatroom) in chatrooms.enumerated() {
                if(chatroom.markUnRead) {
                    chatrooms[index].markUnRead = false
                    chatrooms[index].selected = false;
                    chatroomsToUpdate.append(chatrooms[index])
                } else if(chatroom.unreadCount > 0) {
                    chatrooms[index].unreadCount = 0
                    chatrooms[index].selected = false
                    chatroomsToUpdate.append(chatrooms[index])
                }
            }
            self.tableView.reloadData()
        }
            self.hideOrUnhideSelection()
        
        // update chatrooms in database on disk
        self.updateChatsInDatabaseOnDisk(chatrooms: chatroomsToUpdate, archivedChatrooms: nil)
        
    }
    
    
    func createArchiveButton() {
        bottomFooterView.addSubview(archiveButton)
        
        archiveButton.setTitle(Language.archive, for: .normal)
        
        archiveButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        
        if self.selectedIndexPaths.count > 0 {
            archiveButton.setTitleColor(AppTheme.primaryColor, for: .normal)
        } else {
            archiveButton.setTitleColor(.systemGray, for: .normal)
        }
        
        
        archiveButton.translatesAutoresizingMaskIntoConstraints = false
        archiveButton.centerXAnchor.constraint(equalTo: bottomFooterView.centerXAnchor).isActive = true
        archiveButton.topAnchor.constraint(equalTo: bottomFooterView.topAnchor, constant: 6).isActive = true
        
        
        
        archiveButton.addTarget(self, action: #selector(onArchivePress), for: .touchUpInside)
    }
    
    
    @objc func onArchivePress() {
        if(self.selectedIndexPaths.count > 0) {
            
            var chatsToArchive: [ChatRoom] = []
            
            self.tableView.beginUpdates()
            // DataStore.shared.chatrooms.remove(at: indexPath.row)
            for index in self.selectedIndexPaths.sorted(by: >) {
                var itemToAdd: ChatRoom = self.chatrooms[index.row];
                itemToAdd.archived = true;
                itemToAdd.selected = false;
//                self.archivedChatrooms.append(itemToAdd);
                
                //update selected chats:
                chatsToArchive.append(itemToAdd)
                self.chatrooms.remove(at: index.row)
                
            }
            self.tableView.deleteRows(at: self.selectedIndexPaths, with: .fade)
            
            self.tableView.endUpdates()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.configureTableHeader()
                self.hideOrUnhideSelection()
            }
            self.showArchivedChatsButton = true
            // remove from chats table in database on disk
            deleteChatroomsInDatabaseOnDisk(fileName: fileName, folderName: diskPath, chatroomsToUpdate: chatsToArchive, tableName: DataStore.shared.chatsTable)
            // add it to archived table in database on disk
            self.updateChatsInDatabaseOnDisk(chatrooms: nil, archivedChatrooms: chatsToArchive)
        }
        
        
    }
    
    
    func createDeleteButton() {
        bottomFooterView.addSubview(deleteButton)
        
        deleteButton.setTitle(Language.delete, for: .normal)
        
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        
        if self.selectedIndexPaths.count > 0 {
            deleteButton.setTitleColor(.red, for: .normal)
            deleteButton.addTarget(self, action: #selector(onDeletePress), for: .touchUpInside)
        } else {
            deleteButton.setTitleColor(.systemGray, for: .normal)
        }
        
        
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.trailingAnchor.constraint(equalTo: bottomFooterView.trailingAnchor, constant: -18).isActive = true
        deleteButton.topAnchor.constraint(equalTo: bottomFooterView.topAnchor, constant: 6).isActive = true
        
 
       
    }
    
    @objc func onDeletePress() {
        if(self.selectedIndexPaths.count > 0) {
        bottomFooterActionSheet()
        }
    }
    
    
    func bottomFooterActionSheet() {
       
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let singleChat = Language.delete + " " + String(selectedIndexPaths.count) + " " + Language.chat
        let multipleChats = Language.delete + " " + String(selectedIndexPaths.count) + " " + Language.chats
        let deleteText = selectedIndexPaths.count > 1 ? multipleChats : singleChat

        let action1 = UIAlertAction(title: deleteText, style: .destructive) { [weak self] _ in
            guard let self = self else {return}
            self.tableView.beginUpdates()
            // DataStore.shared.chatrooms.remove(at: indexPath.row)
            for index in self.selectedIndexPaths.sorted(by: >) {
                self.chatrooms.remove(at: index.row)
            }
            self.tableView.deleteRows(at: self.selectedIndexPaths, with: .fade)
            self.tableView.endUpdates()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.hideOrUnhideSelection()
            }
            
            // delete chats from database on disk
            deleteChatroomsInDatabaseOnDisk(fileName: self.fileName, folderName: self.diskPath, chatroomsToUpdate: self.selectedChats, tableName: DataStore.shared.chatsTable)
        }
       
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            // Handle Cancel action
        }

        alertController.addAction(action1)
        //alertController.addAction(action2)
        alertController.addAction(cancelAction)

        if let popoverPresentationController = alertController.popoverPresentationController {
            // Set the source view or bar button item to anchor the action sheet on iPad
            popoverPresentationController.sourceView = view // Replace "view" with your desired source view
            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = [] // Remove the arrow on iPad
        }

        present(alertController, animated: true, completion: nil)
    }


    
    
}
