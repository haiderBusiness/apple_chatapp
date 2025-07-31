//
//  extiontion.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 4.6.2023.
//





import UIKit

private let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .ultraLight, scale: .medium)



extension ArchivedChatsVC: UITableViewDelegate, UITableViewDataSource {
    

        //MARK: - header view
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                return self.header;
        }
    
        //MARK: - header height
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                return 60;
                
        }
        
        
        // MARK: - cell
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if archivedChatrooms.count == 0 {
                    self.navigationController?.popViewController(animated: true)
              }

            return self.archivedChatrooms.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let userId = archivedChatrooms[indexPath.row].usersIds.first(where: {$0 != DataStore.shared.user.id})
            let user = DataStore.shared.users.first(where: {$0.id == userId})
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ids.chat_room_cell) as! ChatsCell;
            let chat = self.archivedChatrooms[indexPath.row]
            if let userData = user {
                cell.set(chat: chat, user: userData, isSelecting: isSelecting)
                return cell
            } else {
                return UITableViewCell()
            }
                
        }
    
    
    
    
        // MARK: - cell selection
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let chatroomVC = ChatroomVC() // Instantiate the SecondViewController
            let chat = self.archivedChatrooms[indexPath.row]
            
            let userId = chat.usersIds.first(where: {$0 != DataStore.shared.user.id})
            let user = DataStore.shared.users.first(where: {$0.id == userId})
            let cell = tableView.cellForRow(at: indexPath) as! ChatsCell
            
            
            if self.isSelecting && chat.selected == false {
                // add indexPath of this chat to selectedIndexPaths because it has been selected
                self.selectedIndexPaths.insert(indexPath, at: 0)
                // add this chat to selected chats because it has been selected
                self.selectedChats.insert(chat, at: 0)
                self.title = selectedIndexPaths.count > 0 ? (String(selectedIndexPaths.count) + " " + Language.selected) : Language.archived_chats
                self.configureBottomFooter()
                self.archivedChatrooms[indexPath.row].selected = true
                
                if let userData = user {
                    cell.set(chat: self.archivedChatrooms[indexPath.row], user: userData, isSelecting: true)
                }
            } else if self.isSelecting && chat.selected == true {
                // remove this specifc chat from selected chat because it has been unselected
                self.selectedChats.removeAll(where: {$0.id == chat.id})
                // remove this chat's indexPaht from selectedIndexPaths because it has been unselected
                self.selectedIndexPaths.removeAll(where: {$0.row == indexPath.row})
                self.configureBottomFooter()
                self.archivedChatrooms[indexPath.row].selected = false
                if let userData = user {
                    cell.set(chat: self.archivedChatrooms[indexPath.row], user: userData, isSelecting: true)
                }
            } else {
                if let otherUser = user {
                    navigationItem.backBarButtonItem = UIBarButtonItem(title: Language.back, style: .plain, target: nil, action: nil)
                    
                    // Push the SecondViewController onto the navigation stack
                    chatroomVC.receivedUser = otherUser
                    chatroomVC.chatroom = self.archivedChatrooms[indexPath.row]
                    chatroomVC.updateCurrentChatroom = self
                                        tableView.deselectRow(at: indexPath, animated: true)
                    self.navigationController?.pushViewController(chatroomVC, animated: true)
                    chatroomVC.loadingStatus = loadingStatus
                }
                
            }
            
            //print(chat.name)
            
            // deselect cell
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
    
  
    
    
        //MARK: - trailing swipe
    
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let archiveAction = UIContextualAction(style: .normal, title: Language.unarchive) {_,_, completion in
                
                self.removeFromArchived(indexPath: indexPath);
                completion(true)
                //completion(true)
            }
            
            archiveAction.image = UIImage(systemName: IconStrings.archive_fill, withConfiguration: configuration)
            
            
            let deleteAction = UIContextualAction(style: .destructive, title: Language.delete) {_,_, completion in
                
                self.showActionSheet(indexPath: indexPath);
                completion(true)
            }
            
            deleteAction.image = UIImage(systemName: IconStrings.trash_fill, withConfiguration: configuration)
            
            
            let row = archivedChatrooms[indexPath.row]
            
            let muteTitle = row.muted ? Language.unmute : Language.mute
            
            let muteAction = UIContextualAction(style: .destructive, title: muteTitle) {_,_, completion in
                self.muteChat(indexPath: indexPath)
                completion(true)
            }
            
            muteAction.backgroundColor = UIColor(red: 37/255, green: 211/255, blue: 102/255, alpha: 1.0)
            
            muteAction.image = UIImage(systemName:row.muted ? "speaker.wave.2.fill" : "speaker.slash.fill", withConfiguration: configuration)
            
            let swipeConfiguration = UISwipeActionsConfiguration(actions: [archiveAction, deleteAction, muteAction])
            
            swipeConfiguration.performsFirstActionWithFullSwipe = false
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            return swipeConfiguration;
        }
    
    
    
        //MARK: - leading swipe
    
        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let row = archivedChatrooms[indexPath.row]
            //print(row.name, "pinned:", row.pinned, "pinnedAt:", row.pinnedAt)
            
            let firstTitle = row.unreadCount > 0 ? Language.read : (row.markUnRead ? Language.read : Language.unread)
            
            let unreadAction = UIContextualAction(style: .normal, title: firstTitle ) {_,_, completion in
                self.markUnread(indexPath: indexPath);
                completion(true)
            }
            
            unreadAction.image = UIImage(systemName: IconStrings.message_read_unread, withConfiguration: configuration)
            unreadAction.backgroundColor = .systemBlue;
            
            
            let secondTitle = row.pinned ? Language.unpin : Language.pin
            
            let pinAction = UIContextualAction(style: .normal, title: secondTitle) {_,_, completion in
                
                self.pinChat(indexPath: indexPath);
                completion(true)
            }
            
            pinAction.image = UIImage(systemName: row.pinned ? "pin.slash.fill" : "pin.fill", withConfiguration: configuration)

            
            let swipeConfiguration = UISwipeActionsConfiguration(actions: [unreadAction, pinAction])
            
            swipeConfiguration.performsFirstActionWithFullSwipe = false
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            return swipeConfiguration;
        }
    
    
    
    
        //MARK: - make row moveable
    
        func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
                return true
            }
    
}







extension ArchivedChatsVC {
    
    
    func updateElementInCell(at indexPath: IndexPath) {
        
        let userId = self.archivedChatrooms[indexPath.row].usersIds.first(where: {$0 != DataStore.shared.user.id})
        let user = DataStore.shared.users.first(where: {$0.id == userId})
                
        // Update the specific element in the cell
        if let cell = tableView.cellForRow(at: indexPath) as? ChatsCell, let userData = user {
            // Update the desired element in the cell
            cell.set(chat: self.archivedChatrooms[indexPath.row], user: userData, isSelecting: isSelecting)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)

        
        
    }
    
    
    func markUnread(indexPath: IndexPath) {
        
        tableView.beginUpdates()
        
        
        let itemToUpdate = self.archivedChatrooms[indexPath.row]
        
        if itemToUpdate.unreadCount > 0 {
            archivedChatrooms[indexPath.row].unreadCount = 0
            updateElementInCell(at: indexPath)
        } else if itemToUpdate.markUnRead == false {
            self.archivedChatrooms[indexPath.row].markUnRead = true;
            updateElementInCell(at: indexPath)
        } else {
            self.archivedChatrooms[indexPath.row].markUnRead = false;
            updateElementInCell(at: indexPath)
        }
        
        tableView.endUpdates()
        
        // update chatroom on database
        self.updateChatsInDatabaseOnDisk(chatrooms: [self.archivedChatrooms[indexPath.row]])
        
        // update previous chats
        self.delegate?.updateArchivedChats(updatedChatrooms: self.chatrooms, updatedArchivedChatrooms: self.archivedChatrooms)

    }
    
    
    func muteChat(indexPath: IndexPath) {
        tableView.beginUpdates()
        if self.archivedChatrooms[indexPath.row].muted == false {
            self.archivedChatrooms[indexPath.row].muted = true
            updateElementInCell(at: indexPath)
        } else {
            self.archivedChatrooms[indexPath.row].muted = false
            updateElementInCell(at: indexPath)
        }
        tableView.endUpdates()
        
        // update chatroom on database
        self.updateChatsInDatabaseOnDisk(chatrooms: [self.archivedChatrooms[indexPath.row]])
        
        // update previous chats
        self.delegate?.updateArchivedChats(updatedChatrooms: self.chatrooms, updatedArchivedChatrooms: self.archivedChatrooms)

    }
}





// pin chat room
extension ArchivedChatsVC {
    
    func movePinnedCellToTop(cellToPinIndexPath: IndexPath) {
        
        // update chatroom pinIndex
        
        //self.chatrooms[cellToPinIndexPath.row].pinIndex = 0
        //update chatroom oldIndex
        //self.chatrooms[cellToPinIndexPath.row].oldIndex = cellToPinIndexPath.row
        
        //print("pin to top date:",self.chatrooms[cellToPinIndexPath.row].pinnedAt ?? "nil-date")
        // Move the cell in the data source array
        let pinnedCell = self.archivedChatrooms.remove(at: cellToPinIndexPath.row)
        archivedChatrooms.insert(pinnedCell, at: 0)
        //move the cell in the tableView wihout reloading the tableView
        tableView.moveRow(at: cellToPinIndexPath, to: IndexPath(row: 0, section: 0))
        //tableView.reloadRows(at: [cellToPinIndexPath], with: .automatic)
    }
    



    func movePinnedCellToOriginalPlace(cellToPinIndexPath: IndexPath) {
        
        let thisChat = self.archivedChatrooms[cellToPinIndexPath.row];
        var pinnedChatRooms = archivedChatrooms.filter { $0.pinned }
        pinnedChatRooms.append(thisChat)
        
        
//        print("this chat user: ",thisChat.users[1].firstName)
        
        if let findChatLaterThanThis = archivedChatrooms.filter({ !$0.pinned && $0.lastMessageDate < thisChat.lastMessageDate}).min(by: { $0.lastMessageDate > $1.lastMessageDate }) {
                
//                print("findChatLaterThanThis: ", findChatLaterThanThis.users[1].firstName)
                if let index = archivedChatrooms.firstIndex(where: { $0.id == findChatLaterThanThis.id }) {
                    // Chat room found, index is available
                    let pinnedCell = self.archivedChatrooms.remove(at: cellToPinIndexPath.row)
                    archivedChatrooms.insert(pinnedCell, at: index - 1)
                    tableView.moveRow(at: cellToPinIndexPath, to: IndexPath(row: index - 1, section: 0))
                    let currentDate = Date()
                    let timestamp = currentDate.timeIntervalSince1970
                    self.archivedChatrooms[cellToPinIndexPath.row].pinnedAt = timestamp
//                    print("findChatLaterThanThis: ", findChatLaterThanThis.users[1].firstName)
                }
                //print("Chat room with closest date: \(findChatLaterThanThis.name)")
                //print("first statment chat is the found chat: \(findChatLaterThanThis.name)")
        } else if archivedChatrooms.count > pinnedChatRooms.count {
                let pinnedCell = self.archivedChatrooms.remove(at: cellToPinIndexPath.row)
                archivedChatrooms.append(pinnedCell)
                let targetIndexPath = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
                tableView.moveRow(at:  cellToPinIndexPath, to: targetIndexPath)
    //            tableView.moveRow(at: cellToPinIndexPath, to: IndexPath(row: index - 1, section: 0))
                let currentDate = Date()
                let timestamp = currentDate.timeIntervalSince1970
                self.archivedChatrooms[cellToPinIndexPath.row].pinnedAt = timestamp
        
        } else if !pinnedChatRooms.isEmpty && pinnedChatRooms.count > 1 {
            
                let findOldestPinnedChat: ChatRoom = getOldestPinnedChatRoom(from: pinnedChatRooms)
                //print("before last statment chat is the found chat: \(findOldestPinnedChat.name)")
                if let index = archivedChatrooms.firstIndex(where: { $0.id == findOldestPinnedChat.id }) {
                    //print("index:", index)
                    // Chat room found, index is available
                    let pinnedCell = self.archivedChatrooms.remove(at: cellToPinIndexPath.row)
                    archivedChatrooms.insert(pinnedCell, at: index)
                    tableView.moveRow(at: cellToPinIndexPath, to: IndexPath(row: index, section: 0))
                    let currentDate = Date()
                    let timestamp = currentDate.timeIntervalSince1970
                    self.archivedChatrooms[cellToPinIndexPath.row].pinnedAt = timestamp
                }
        }
        
        
    }

    

    
    
    
    func pinChat(indexPath: IndexPath) {
        tableView.beginUpdates()
        
        if self.archivedChatrooms[indexPath.row].pinned == false {
                archivedChatrooms[indexPath.row].pinned = true;
            let currentDate = Date()
            let timestamp = currentDate.timeIntervalSince1970
            archivedChatrooms[indexPath.row].pinnedAt = timestamp
            self.updateElementInCell(at: indexPath)
            // update chatroom on database before it get removed or moved
            self.updateChatsInDatabaseOnDisk(chatrooms: [self.archivedChatrooms[indexPath.row]])
            self.movePinnedCellToTop(cellToPinIndexPath: indexPath)
        } else {
            self.archivedChatrooms[indexPath.row].pinned = false;
            self.updateElementInCell(at: indexPath)
            self.updateChatsInDatabaseOnDisk(chatrooms: [self.archivedChatrooms[indexPath.row]])
            self.movePinnedCellToOriginalPlace(cellToPinIndexPath: indexPath)
        }
        
        
        tableView.endUpdates()
        
        // update previous chats
        self.delegate?.updateArchivedChats(updatedChatrooms: self.chatrooms, updatedArchivedChatrooms: self.archivedChatrooms)
        //tableView.reloadData()
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
            //print("last old chat: ", item.name)
        }
        
        

        return oldestPinnedChatRoom.first
    }
    
}
    
    


extension ArchivedChatsVC {
    
    func removeFromArchived(indexPath: IndexPath) {
        self.tableView.beginUpdates()
        
        var toAppendItem: ChatRoom = archivedChatrooms[indexPath.row];
        toAppendItem.archived = false;
        self.chatrooms.append(toAppendItem)
        //DataStore.shared.chatrooms.append(itemToAdd);
        //update the delegate to update the previous scene
        self.archivedChatrooms.remove(at: indexPath.row)
        
        // add chat to chats database
        saveChatroomsToDatabaseOnDisk(fileName: "chats.db", folderName: diskPath, chatrooms: [toAppendItem], tableName: DataStore.shared.chatsTable)
        
        // delete chat from archived database
        deleteChatroomsInDatabaseOnDisk(fileName: fileName, folderName: diskPath, chatroomsToUpdate: [toAppendItem], tableName: DataStore.shared.archivedChatsTable)
        // update previous controller
        self.delegate?.updateArchivedChats(updatedChatrooms: self.chatrooms, updatedArchivedChatrooms: self.archivedChatrooms)
        //DataStore.shared.archivedChatrooms.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        self.checkIfEmpty()
        self.tableView.endUpdates()
    }
    
    
    func showActionSheet(indexPath: IndexPath) {
        
        let userId = archivedChatrooms[indexPath.row].usersIds.first(where: {$0 != DataStore.shared.user.id})
        let user = DataStore.shared.users.first(where: {$0.id == userId})
        var name: String!
        
        if let firstName = user?.firstName {
            name = firstName
        }
        
        let title = Language.delete_chat_with
        let alertController = UIAlertController(title: title + " " + name, message: nil, preferredStyle: .actionSheet)
        

        let action1 = UIAlertAction(title: Language.delete_chat, style: .destructive) { _ in
            self.tableView.beginUpdates()
            // delete chat from database on disk
            deleteChatroomsInDatabaseOnDisk(fileName: self.fileName, folderName: self.diskPath, chatroomsToUpdate: [self.archivedChatrooms[indexPath.row]], tableName: DataStore.shared.archivedChatsTable)
            
            //Update previous screen
            self.archivedChatrooms.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.checkIfEmpty()
            self.tableView.endUpdates()
            
            
            // update previous chats
            self.delegate?.updateArchivedChats(updatedChatrooms: self.chatrooms, updatedArchivedChatrooms: self.archivedChatrooms)
        }
        let action2 = UIAlertAction(title: Language.unarchive_chat, style: .default) { _ in
            self.removeFromArchived(indexPath: indexPath)
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






