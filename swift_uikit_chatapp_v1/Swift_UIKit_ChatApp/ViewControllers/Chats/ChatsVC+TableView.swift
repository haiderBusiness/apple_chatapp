//
//  ChatsTableExtintion.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 3.6.2023.
//

import UIKit

private let configuration = UIImage.SymbolConfiguration(pointSize: 25, weight: .ultraLight, scale: .medium)

var startTime: DispatchTime!

extension ChatsVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func startTimer() {
            startTime = DispatchTime.now()
            // You can replace the following line with any code that takes some time to execute.
            // For this example, we'll simply delay the execution for 1 second.
                self.stopTimerAndCalculateMilliseconds()
            
        }
    
    func stopTimerAndCalculateMilliseconds() {
//            let endTime = DispatchTime.now()
//            let nanosecondsElapsed = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
//            let millisecondsElapsed = Double(nanosecondsElapsed) / 1_000_000 // Convert nanoseconds to milliseconds
//            print("Elapsed time in milliseconds: \(millisecondsElapsed)")
        
            let endTime = DispatchTime.now()
                let nanosecondsElapsed = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
                let millisecondsElapsed = Double(nanosecondsElapsed) / 1_000_000 // Convert nanoseconds to milliseconds
                print("Elapsed time in milliseconds: \(millisecondsElapsed)")
        }
    
    
    
    
    
    
    func configureTableView () {
        // Create a table view
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100;
        tableView.backgroundColor = .systemBackground
        
        tableView.register(ChatsCell.self, forCellReuseIdentifier: ids.chat_room_cell)
        
        tableView.register(ChatsTableHeader.self, forHeaderFooterViewReuseIdentifier: ids.table_header)
        view.addSubview(tableView)
        
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
            let constraints = [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
        
    }
    
    
    
    
    //MARK: - header view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if chatrooms.isEmpty {
           return UIView()
        } else if !showArchivedChatsButton {
            //let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ids.table_header) as! ChatsTableHeader
            //self.tableView.contentInset = UIEdgeInsets(top: -100, left: 0, bottom: 0, right: 0)
            return UIView()
        } else {
            return self.header;
        }
        
    }
    
//    @objc func headerViewTapped(_ sender: UITapGestureRecognizer) {
//        print("tapped")
//        let archivedChatsVC = ArchivedChatsVC();
//        //archivedChatsVC.archivedChatrooms = DataStore.shared.archivedChatrooms
//        archivedChatsVC.archivedChatrooms = self.archivedChatrooms
//        //archivedChatsVC.delegate = self
//
//        self.navigationController?.pushViewController(archivedChatsVC, animated: true)
//    }
    
    //MARK: - header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if chatrooms.isEmpty {
            return CGFloat()
        } else if !showArchivedChatsButton {
            return CGFloat()
        } else {
            return 60;
        }
        
    }
    
        
    

    
        
        
        // MARK: - cell
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            if self.chatrooms.isEmpty && showArchivedChatsButton {
                self.showAllChatsAreArchivedMessage()
            }
            else if self.chatrooms.isEmpty {
                self.tableView.setEmptyMessage(Language.there_are_no_active_chats_you_have_tap_the, iconName: "square.and.pencil", afterIconText: Language.icon_to_start_a_new_chat)
            } else {
                self.navigationItem.searchController = self.searchController
                self.tableView.restore()
            }
            return self.chatrooms.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//            let allUsers = DataStore.shared.users
            let userId = chatrooms[indexPath.row].usersIds.first(where: {$0 != DataStore.shared.user.id})
            
            let user = DataStore.shared.users.first(where: {$0.id == userId})
//            print("userId: ", user?.firstName ?? "nil")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ids.chat_room_cell) as! ChatsCell;
            
            let chat = self.chatrooms[indexPath.row]
  
            if let user = user {
                cell.set(chat: chat, user: user, isSelecting: isSelecting)
                return cell
            } else {
                return UITableViewCell()
            }

        }
    
        // MARK: - cell selection
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let chatroomVC = ChatroomVC() // Instantiate the SecondViewController
            let chat = self.chatrooms[indexPath.row]
            
            let userId = chat.usersIds.first(where: {$0 != DataStore.shared.user.id})
            let user = DataStore.shared.users.first(where: {$0.id == userId})
            let cell = tableView.cellForRow(at: indexPath) as! ChatsCell
            
            if self.isSelecting && chat.selected == false {
                
                // add indexPath of this chat to selectedIndexPaths because it has been selected
                self.selectedIndexPaths.insert(indexPath, at: 0)
                // add this chat to selected chats because it has been selected
                self.selectedChats.insert(chat, at: 0)
                // set title to count of selected chats
                self.title = selectedIndexPaths.count > 0 ? (String(selectedIndexPaths.count) + " " + Language.selected) : Language.chats
                // configure footer
                self.configureBottomFooter()
                // make chatroom selected
                self.chatrooms[indexPath.row].selected = true
                //
                if let userData = user {
                    cell.set(chat: self.chatrooms[indexPath.row], user: userData, isSelecting: true)
                }
                
                tableView.deselectRow(at: indexPath, animated: true)
                
            } else if self.isSelecting && chat.selected == true {
                
                // remove this specifc chat from selected chat because it has been unselected
                self.selectedChats.removeAll(where: {$0.id == chat.id})
                
                // remove this chat's indexPaht from selectedIndexPaths because it has been unselected
                self.selectedIndexPaths.removeAll(where: {$0.row == indexPath.row})
                
                // set title to count of selected chats
                self.title = selectedIndexPaths.count > 0 ? (String(selectedIndexPaths.count) + " " + Language.selected) : Language.chats
//                if let index = selectedIndexPaths.firstIndex(where: { $0.row == indexPath.row }) {
//                    self.selectedIndexPaths.remove(at: index)
//                    self.title = selectedIndexPaths.count > 0 ? (String(selectedIndexPaths.count) + " " + Language.selected) : Language.chats
//                }
                // configure footer
                self.configureBottomFooter()
                // set chat to be unselected
                self.chatrooms[indexPath.row].selected = false
                // check other user
                if let userData = user {
                    cell.set(chat: self.chatrooms[indexPath.row], user: userData, isSelecting: true)
                }
                
                tableView.deselectRow(at: indexPath, animated: true)
            } else {
                if let otherUser = user {
                    startTime = DispatchTime.now()
                    navigationItem.backBarButtonItem = UIBarButtonItem(title: Language.back, style: .plain, target: nil, action: nil)
                    // Push the SecondViewController onto the navigation stack
                    chatroomVC.receivedUser = otherUser
                    chatroomVC.chatroom = self.chatrooms[indexPath.row]
                    chatroomVC.addNewChatroomDelegate = self
                    chatroomVC.updateCurrentChatroom = self
                                        tableView.deselectRow(at: indexPath, animated: true)
                    self.navigationController?.pushViewController(chatroomVC, animated: true)
                    chatroomVC.loadingStatus = loadingStatus
                    self.stopTimerAndCalculateMilliseconds()
                    
                    // deselect cell
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            }
            
            
            
            //print(chat.name)
            
            // deselect cell
//            print("deselectRow")
            
            
        }
    
  
    
    
        //MARK: - trailing swipe
    
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let archiveAction = UIContextualAction(style: .normal, title: Language.archive) {_,_, completion in
                
                self.addToArchived(indexPath: indexPath);
                completion(true)
                //completion(true)
            }
            
            archiveAction.image = UIImage(systemName: IconStrings.archive_fill, withConfiguration: configuration)
            
            
            let deleteAction = UIContextualAction(style: .destructive, title: Language.delete) {_,_, completion in
                
                self.showActionSheet(indexPath: indexPath);
                completion(true)
            }
            
            deleteAction.image = UIImage(systemName: IconStrings.trash_fill, withConfiguration: configuration)
            
            
            let row = chatrooms[indexPath.row]
            
            let muteTitle = row.muted ? Language.unmute : Language.mute
            
            let muteAction = UIContextualAction(style: .destructive, title: muteTitle) {_,_, completion in
                self.muteChat(indexPath: indexPath)
                completion(true)
            }
            
            muteAction.backgroundColor = AppTheme.sucsessColor
            
            muteAction.image = UIImage(systemName:row.muted ? "speaker.wave.2.fill" : "speaker.slash.fill", withConfiguration: configuration)
            
            let swipeConfiguration = UISwipeActionsConfiguration(actions: [archiveAction, deleteAction, muteAction])
            
            swipeConfiguration.performsFirstActionWithFullSwipe = false
            
            tableView.deselectRow(at: indexPath, animated: true)
            
            return swipeConfiguration;
        }
    
    
    
        //MARK: - leading swipe
    
        func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            
            let row = chatrooms[indexPath.row]
            //print(row.name, "pinned:", row.pinned, "pinnedAt:", row.pinnedAt)
            
            let firstTitle = row.unreadCount > 0 ? Language.read : (row.markUnRead ? Language.read : Language.unread)
            
            let unreadAction = UIContextualAction(style: .normal, title: firstTitle ) {_,_, completion in
                self.markUnread(indexPath: indexPath);
                completion(true)
            }
            
            unreadAction.image = UIImage(systemName: "message.circle", withConfiguration: configuration)
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
