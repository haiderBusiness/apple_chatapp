//
//  NewChatAdded.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 20.6.2023.
//

import UIKit




// update data
extension ChatsVC: UpdateArchivedChatsDelegate {
    func updateArchivedChats(updatedChatrooms: [ChatRoom], updatedArchivedChatrooms: [ChatRoom]) {
        self.dismiss(animated: true);
        self.chatrooms = updatedChatrooms
        self.sortChatrooms()
//        self.archivedChatrooms = updatedArchivedChatrooms;
        self.tableView.reloadData();
        self.configureTableHeader();
        //update chats to disk
        self.updateChatsInDatabaseOnDisk(chatrooms: updatedChatrooms, archivedChatrooms: nil)
        //print("Data updated successfully: ", self.archivedChatrooms)
    }
    
}


extension ChatsVC: NewChatAddedProtocol {
    
    func updateTableAndSource(newChat: ChatRoom) {
        if pinnedChatsNumber > 0 {
            let indexPath = IndexPath(row: pinnedChatsNumber, section: 0)
            tableView.beginUpdates()
            self.chatrooms.insert(newChat, at: pinnedChatsNumber)
            self.tableView.insertRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        } else {
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.beginUpdates()
            self.chatrooms.insert(newChat, at: 0)
            self.tableView.insertRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
        
        
        //update chats to disk
        saveChatroomsToDatabaseOnDisk(fileName: fileName, folderName: diskPath, chatrooms: [newChat], tableName: DataStore.shared.chatsTable)
    }
    
    func newChatAdded(newChat: ChatRoom) {
        //print("new chat message: ", newChat.lastMessage)
        if self.chatrooms.count > 0 {
            
            updateTableAndSource(newChat: newChat)
        } else {
            show_table_search_header_footer_largeTitle()
            updateTableAndSource(newChat: newChat)
        }
//        sortChatrooms()
//        self.tableView.reloadData()
        //print("new chat room added successfully")
    }
    
    
}


// navigate to new chatroom
extension ChatsVC: NavigateToNewChatroomDelegate {
    
    func foundChatRoom(otherUser: User?) -> ChatRoom? {
        let foundChatroom = chatrooms.first(where: { chatroom in
            chatroom.usersIds.contains(otherUser?.id ?? "") && chatroom.name == nil
        })
        
        return foundChatroom
    }
    
    func navigateToNewChatroom(userData: User?, Chatroom: ChatRoom?) {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: Language.back, style: .plain, target: nil, action: nil)
        let chatroomVC = ChatroomVC()
        chatroomVC.receivedUser = userData
        chatroomVC.chatroom = foundChatRoom(otherUser: userData)
        chatroomVC.addNewChatroomDelegate = self
        chatroomVC.updateCurrentChatroom = self
        self.dismiss(animated: true);
        self.navigationController?.pushViewController(chatroomVC, animated: true)
    }
}


// update chat room
extension ChatsVC: UpdateChatroom {
    func updatedChatroom(chatroom: ChatRoom) {
        let foundIndex = self.chatrooms.firstIndex(where: {$0.id == chatroom.id})
        if let index = foundIndex {
            self.chatrooms[index] = chatroom
            let indexPath = IndexPath(row: index, section: 0)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
            //update chats to disk
            self.updateChatsInDatabaseOnDisk(chatrooms: [chatroom], archivedChatrooms: nil)
        }
        
    }
    
}
