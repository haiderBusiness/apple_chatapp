//
//  LoadChatrooms.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 20.7.2023.
//

import UIKit

extension ChatsVC {
    
    
    
    func setSearchBar() {
        //searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func show_table_search_header_footer_largeTitle() {
        setSearchBar()
        configureTableView();
        configureTableHeader()
        self.createBottomFooter()
        title = Language.chats;
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func loadArchivedChatrooms() {
        
//        let fileName = "archivedChats.json"
        let areArchivedChatroomsSavedToDisk = areChatroomsSavedToDisk(fileName: diskPath + "/" + archivedfileName)

        // remove messages from disk temporerlly
//        removeMessagesFromDisk(fileNameString: "messages.json")
        
        
        if areArchivedChatroomsSavedToDisk {
            if let _ = retrieveChatroomsFromDatabaseOnDisk(fileName: archivedfileName, folderName: diskPath, limit: 1, offset: 0, tableName: DataStore.shared.archivedChatsTable) {
                
                self.showArchivedChatsButton = true
                configureTableHeader()
            }
        }
        
//        if areArchivedChatroomsSavedToDisk {
//            if let savedArchivedChatrooms = retrieveChatroomsFromDatabaseOnDisk(fileName: fileName, folderName: diskPath, limit: chatroomsOffset, offset: chatroomsOffset) {
//                self.archivedChatrooms = savedArchivedChatrooms
//                print("we are fetching chatrooms from disk")
//            } else {
//                print("saved chatrooms error")
//            }
//        }
        
    }
    
    func updateChatsInDatabaseOnDisk(chatrooms: [ChatRoom]?, archivedChatrooms: [ChatRoom]? = nil) {
        
        // update multiple chatrooms in database on disk
        if let chatrooms = chatrooms {
            updateChatroomsInDatabaseOnDisk(fileName: fileName, folderName: diskPath, chatroomsToUpdate: chatrooms, tableName: DataStore.shared.chatsTable)
        }
        
        // save multiple archived chatrooms to database on disk
        if let archivedChatrooms = archivedChatrooms {
            saveChatroomsToDatabaseOnDisk(fileName: archivedfileName, folderName: diskPath, chatrooms: archivedChatrooms, tableName: DataStore.shared.archivedChatsTable)
        }
        
    }

    func saveLoadChatrooms() {
        let appName = DataStore.shared.appName
        diskPath = "\(appName)/chats"
        
        let areChatroomsSavedToDisk = areChatroomsSavedToDisk(fileName: diskPath + "/" + fileName)

        // remove messages from disk temporerlly
//        removeMessagesFromDisk(fileNameString: "messages.json")
        
        
         
        if areChatroomsSavedToDisk, let savedChatrooms = retrieveChatroomsFromDatabaseOnDisk(fileName: fileName, folderName: diskPath, limit: chatroomsLimit, offset: chatroomsOffset, tableName: DataStore.shared.chatsTable) {
            
            chatroomsOffset += chatroomsLimit
            self.chatrooms = savedChatrooms
            show_table_search_header_footer_largeTitle()
        } else {
            title = Language.chats;
            navigationItem.largeTitleDisplayMode = .never
            showEmptyMessage()
        }
        
        loadArchivedChatrooms()
        sortChatrooms()
    }
    
    
    func sortChatrooms() {
        if chatrooms.count > 0 {
            var room: ChatRoom?
            
            chatrooms.sort { (room1, room2) in
                if room1.pinned && !room2.pinned {
                    
                    if room?.id != room1.id {
                        pinnedChatsNumber += 1
                        room = room1
                    }
                    
                    return true
                } else if !room1.pinned && room2.pinned {
                    if room?.id != room1.id {
                        pinnedChatsNumber += 1
                        room = room1
                    }
                    return false
                } else if room1.pinned && room2.pinned {
                    if room?.id != room1.id {
                        pinnedChatsNumber += 1
                        room = room1
                    }
                    return room1.pinnedAt > room2.pinnedAt
                } else {
                    return room1.lastMessageDate > room2.lastMessageDate
                }
            }
        }
        
        print("pinned chats number: ",pinnedChatsNumber)
        
    }
    
    func showEmptyMessage() {
        emptyMessageView.translatesAutoresizingMaskIntoConstraints = false
        
        emptyMessageView.backgroundColor = .clear
        
        emptyMessageView.messageText = Language.there_are_no_active_chats_you_have_tap_the + " " + "`\(Language.new)`" + " " + Language.button_to_start_a_new_chat
        
        emptyMessageView.wordToColor = "`\(Language.new)`"
        
        view.addSubview(emptyMessageView)
        
        NSLayoutConstraint.activate([
            emptyMessageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyMessageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            emptyMessageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
    }
}
