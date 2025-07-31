//
//  ActionsSetup.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 9.6.2023.
//

import UIKit

extension ChatsVC {
    
    
//    func sortChatRooms() {
//        self.chatrooms.sort { (room1, room2) in
//            if room1.pinned && !room2.pinned {
//                return true
//            } else if !room1.pinned && room2.pinned {
//                return false
//            } else {
//                return room1.date > room2.date
//            }
//        }
//    }
    
    
    func updateElementInCell(at indexPath: IndexPath) {
        let userId = chatrooms[indexPath.row].usersIds.first(where: {$0 != DataStore.shared.user.id})
        let user = DataStore.shared.users.first(where: {$0.id == userId})
        
        // Update the specific element in the cell
        if let cell = tableView.cellForRow(at: indexPath) as? ChatsCell, let userData = user {
            // Update the desired element in the cell
            cell.set(chat: self.chatrooms[indexPath.row], user: userData, isSelecting: false)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)

        
    }
    
    
    func markUnread(indexPath: IndexPath) {
        
        tableView.beginUpdates()
        
        
        let itemToUpdate = self.chatrooms[indexPath.row]
        
        if itemToUpdate.unreadCount > 0 {
            chatrooms[indexPath.row].unreadCount = 0
            updateElementInCell(at: indexPath)
        } else if itemToUpdate.markUnRead == false {
            self.chatrooms[indexPath.row].markUnRead = true;
            updateElementInCell(at: indexPath)
        } else {
            self.chatrooms[indexPath.row].markUnRead = false;
            updateElementInCell(at: indexPath)
            
        }
        
        tableView.endUpdates()
        // update chatroom
        self.updateChatsInDatabaseOnDisk(chatrooms: [self.chatrooms[indexPath.row]], archivedChatrooms: nil)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//            self.tableView.beginUpdates()
//            self.tableView.reloadRows(at: [indexPath], with: .automatic)
//            self.tableView.endUpdates()
//        }

    }
    
    
    func muteChat(indexPath: IndexPath) {
        tableView.beginUpdates()
        if self.chatrooms[indexPath.row].muted == false {
            self.chatrooms[indexPath.row].muted = true
            updateElementInCell(at: indexPath)
        } else {
            self.chatrooms[indexPath.row].muted = false
            updateElementInCell(at: indexPath)
            
        }
        tableView.endUpdates()
        self.updateChatsInDatabaseOnDisk(chatrooms: [self.chatrooms[indexPath.row]], archivedChatrooms: nil)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//            self.tableView.beginUpdates()
//            self.tableView.reloadRows(at: [indexPath], with: .automatic)
//            self.tableView.endUpdates()
//        }

    }
}

extension ChatsVC {
    func addToArchived(indexPath: IndexPath) {
        self.tableView.beginUpdates()
        
        //DataStore.shared.chatrooms.remove(at: indexPath.row)
        var itemToAdd: ChatRoom = self.chatrooms[indexPath.row];
        itemToAdd.archived = true;
        
//        self.archivedChatrooms.append(itemToAdd);
        self.showArchivedChatsButton = true
        
        self.chatrooms.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        //DataStore.shared.archivedChatrooms.append(itemToAdd);
        
        self.configureTableHeader()
        self.tableView.endUpdates()
        
        deleteChatroomsInDatabaseOnDisk(fileName: fileName, folderName: diskPath, chatroomsToUpdate: [itemToAdd], tableName: DataStore.shared.chatsTable)
        self.updateChatsInDatabaseOnDisk(chatrooms: nil, archivedChatrooms: [itemToAdd])
    }
    
}



extension ChatsVC {
    
    func showActionSheet(indexPath: IndexPath) {
        
        let userId = chatrooms[indexPath.row].usersIds.first(where: {$0 != DataStore.shared.user.id})
        let user = DataStore.shared.users.first(where: {$0.id == userId})
        var name: String!
        
        if let user_first_name = user?.firstName {
            name = user_first_name
        }
        
        let alertController = CustomAllertController(title: Language.delete_chat_with + " " + name, message: nil, preferredStyle: .actionSheet)
        
        if let imageData = user?.avatar {

//                    let placeHolderUrl = imageData.placeHolderUrl
                    let imageUrl = imageData.photoUrl
//                    let photoDeviceId = imageData.savedOnDeviceId
//
//                    var fileName = placeHolderUrl.replacingOccurrences(of: "https://", with: "")
//                    fileName = fileName.replacingOccurrences(of: "http://", with: "")
                
//
//                    if deviceId == photoDeviceId {
//                        chatImageView.LoadSaveDisplayImage(originalImageUrl: imageUrl, placeHolderUrl: placeHolderUrl , savePlaceHolder: false,folderName: diskPath)
//                    } else {
//                        chatImageView.LoadSaveDisplayImage(originalImageUrl: imageUrl, placeHolderUrl: placeHolderUrl , savePlaceHolder: true,folderName: diskPath)
//                    }
//
//                } else {
//                        chatImageView.image = Empty.image
//                }
            alertController.setTitleImage(image: nil, imageUrl: imageUrl)
        }
        

        let action1 = UIAlertAction(title: Language.delete_chat, style: .destructive) { _ in
            self.tableView.beginUpdates()
            // DataStore.shared.chatrooms.remove(at: indexPath.row)
            let itemToDelete = self.chatrooms.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
            deleteChatroomsInDatabaseOnDisk(fileName: self.fileName, folderName: self.diskPath, chatroomsToUpdate: [itemToDelete], tableName: DataStore.shared.chatsTable)
        }
        let action2 = UIAlertAction(title: Language.archive_chat, style: .default) { _ in
            self.addToArchived(indexPath: indexPath)
            
            // Handle Action 2
        }
        let cancelAction = UIAlertAction(title: Language.cancel, style: .cancel) { _ in
            // Handle Cancel action
        }

        alertController.addAction(action1)
        alertController.addAction(action2)
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


// pin chat room
extension ChatsVC {
    
    func movePinnedCellToTop(cellToPinIndexPath: IndexPath) {
        
        // update chatroom pinIndex
        
        
        
        //self.chatrooms[cellToPinIndexPath.row].pinIndex = 0
        //update chatroom oldIndex
        //self.chatrooms[cellToPinIndexPath.row].oldIndex = cellToPinIndexPath.row
        
        //print("pin to top date:",self.chatrooms[cellToPinIndexPath.row].pinnedAt ?? "nil-date")
        // Move the cell in the data source array
        let pinnedCell = self.chatrooms.remove(at: cellToPinIndexPath.row)
        chatrooms.insert(pinnedCell, at: 0)
        //move the cell in the tableView wihout reloading the tableView
        tableView.moveRow(at: cellToPinIndexPath, to: IndexPath(row: 0, section: 0))
        //tableView.reloadRows(at: [cellToPinIndexPath], with: .automatic)
    }
    


    


    //TODO: Make sure the datasource is sorted well before you edit this!
    func movePinnedCellToOriginalPlace(cellToPinIndexPath: IndexPath) {
        
        let thisChat = self.chatrooms[cellToPinIndexPath.row];
        var pinnedChatRooms = chatrooms.filter { $0.pinned }
        pinnedChatRooms.append(thisChat)
        
        if let findChatLaterThanThis = chatrooms.filter({ !$0.pinned && $0.lastMessageDate < thisChat.lastMessageDate}).min(by: { $0.lastMessageDate > $1.lastMessageDate }) {
            
          
                if let index = chatrooms.firstIndex(where: { $0.id == findChatLaterThanThis.id }) {
//                    print("this chatroom's last message date is later then me: ", chatrooms.first(where: { $0.id == findChatLaterThanThis.id })?.lastMessage ?? "nil")
                    
                    // Chat room found, index is available
                    let pinnedCell = self.chatrooms.remove(at: cellToPinIndexPath.row)
                    chatrooms.insert(pinnedCell, at: index - 1)
                    tableView.moveRow(at: cellToPinIndexPath, to: IndexPath(row: index - 1, section: 0))
                    let currentDate = Date()
                    let timestamp = currentDate.timeIntervalSince1970
                    self.chatrooms[cellToPinIndexPath.row].pinnedAt = timestamp
    //                print("findChatLaterThanThis: ", findChatLaterThanThis.users[1].firstName)
                }
            
        } else if chatrooms.count > pinnedChatRooms.count {
                let pinnedCell = self.chatrooms.remove(at: cellToPinIndexPath.row)
                chatrooms.append(pinnedCell)
                let targetIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
                tableView.moveRow(at:  cellToPinIndexPath, to: targetIndexPath)
    //            tableView.moveRow(at: cellToPinIndexPath, to: IndexPath(row: index - 1, section: 0))
                let currentDate = Date()
                let timestamp = currentDate.timeIntervalSince1970
                self.chatrooms[cellToPinIndexPath.row].pinnedAt = timestamp
            
        } else if !pinnedChatRooms.isEmpty && pinnedChatRooms.count > 1 {
            
                let findOldestPinnedChat: ChatRoom = getOldestPinnedChatRoom(from: pinnedChatRooms)
                //print("before last statment chat is the found chat: \(findOldestPinnedChat.name)")
                
                if let index = chatrooms.firstIndex(where: { $0.id == findOldestPinnedChat.id }) {
                    //print("index:", index)
                    // Chat room found, index is available
                    let pinnedCell = self.chatrooms.remove(at: cellToPinIndexPath.row)
                    chatrooms.insert(pinnedCell, at: index)
                    tableView.moveRow(at: cellToPinIndexPath, to: IndexPath(row: index, section: 0))
                    let currentDate = Date()
                    let timestamp = currentDate.timeIntervalSince1970
                    self.chatrooms[cellToPinIndexPath.row].pinnedAt = timestamp
                }
        }
        
        
    }

    

    
    
    
    func pinChat(indexPath: IndexPath) {
        tableView.beginUpdates()
        
        if self.chatrooms[indexPath.row].pinned == false {
                chatrooms[indexPath.row].pinned = true;
            let currentDate = Date()
            let timestamp = currentDate.timeIntervalSince1970
            chatrooms[indexPath.row].pinnedAt = timestamp
            self.updateElementInCell(at: indexPath)
            // update pinned chats number
            pinnedChatsNumber += 1
            // update chatroom on database before it get removed or moved
            self.updateChatsInDatabaseOnDisk(chatrooms: [self.chatrooms[indexPath.row]], archivedChatrooms: nil)
            self.movePinnedCellToTop(cellToPinIndexPath: indexPath)
        } else {
            self.chatrooms[indexPath.row].pinned = false;
            // update pinned chats number
            pinnedChatsNumber -= 1
            self.updateElementInCell(at: indexPath)
            // update chatroom on database before it get removed or moved
            self.updateChatsInDatabaseOnDisk(chatrooms: [self.chatrooms[indexPath.row]], archivedChatrooms: nil)
            self.movePinnedCellToOriginalPlace(cellToPinIndexPath: indexPath)
        }
        
        tableView.endUpdates()
       
//        tableView.reloadData()
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
        //            self.tableView.beginUpdates()
        //            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        //            self.tableView.endUpdates()
        //        }

    }
    
    
    func getOldestPinnedChatRoom(from pinnedChatRooms: [ChatRoom]) -> ChatRoom! {
        let oldestPinnedChatRoom = pinnedChatRooms.sorted { room1, room2 in
            let pinnedAt1 = room1.pinnedAt
            let pinnedAt2 = room2.pinnedAt
            return pinnedAt1 < pinnedAt2
        }
        
        for _ in pinnedChatRooms {
           // print("last old chat: ", item.name)
        }
        
        

        return oldestPinnedChatRoom.first
    }
    
}






