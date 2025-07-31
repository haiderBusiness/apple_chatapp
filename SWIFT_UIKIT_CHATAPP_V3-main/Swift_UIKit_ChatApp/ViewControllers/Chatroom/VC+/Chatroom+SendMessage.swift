//
//  SendMessage.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 25.6.2023.
//

import UIKit

enum SendMessageType {
    case textMessage(text: String)
}

extension ChatroomVC {

    
    func appendMessage(message: Message) {
        
        if sections.isEmpty {
            // Create a new section and update the data source
            let newSection = Language.today
            sections.insert(newSection, at: 0)
            sectionMessages[newSection] = [message]
            saveMessagesToDatabaseOnDisk(fileName: fileName, folderName: messagesDiskPath, messages: [message], tableName: DataStore.shared.messagesTable)
            self.tableView.reloadData()
        } else if sections.first == Language.today {
            print("second statment")
            let firstSectionTitle = sections.first!
            let indexPath = IndexPath(row: 0, section: 0)
            
            //print("indexPath ", indexPath)
            // Update the table view with the new row
            tableView.beginUpdates()
            sectionMessages[firstSectionTitle]?.insert(message, at: 0)
            saveMessagesToDatabaseOnDisk(fileName: fileName, folderName: messagesDiskPath, messages: [message], tableName: DataStore.shared.messagesTable)
            tableView.insertRows(at: [indexPath], with: .right)
            tableView.endUpdates()
            
        } else {
            
            let newSection = Language.today
            sections.insert(newSection, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)

            // Update the table view with the new row
            tableView.beginUpdates()
            sectionMessages[newSection] = [message]
            saveMessagesToDatabaseOnDisk(fileName: fileName, folderName: messagesDiskPath, messages: [message], tableName: DataStore.shared.messagesTable)
            tableView.insertSections(IndexSet(integer: 0), with: .right)
            tableView.insertRows(at: [indexPath], with: .right)
            tableView.endUpdates()
//            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }

          
            //let footerRect = CGRect(x: 0, y: tableView.contentSize.height - 1, width: 1, height: 1)
            //tableView.scrollRectToVisible(footerRect, animated: true)
    }
    
    
    
    
    func sendMessage(text: String?, audioFileName: String? = nil, photoObject: PhotoMessage? = nil, videoObject: VideoMessage? = nil, locationObject: Coordinates? = nil) {
        
        let lastMessage = (audioFileName != nil) ? "audio message" : (photoObject != nil) ? "photo message" : (videoObject != nil) ? "video message" : (locationObject != nil) ? "location message" : text
        
        
        if var unWrapedChatroom = chatroom {
            let newMessage = Message(
                id: "\(UUID())",
                chatroomId: unWrapedChatroom.id,
                senderId: DataStore.shared.user.id,
                textMessage: text,
                audioMessage: audioFileName,
                photoMessage: photoObject,
                videoMessage: videoObject,
                fileMessage: nil,
                locationMessage: locationObject,
                replyMessage: nil,
                createdAt: currentTimeStamp()
            );
            chatroom?.lastMessage = self.messageInput.text
            self.messages.append(newMessage)
            appendMessage(message: newMessage)
            unWrapedChatroom.lastMessage = (lastMessage != nil) ? lastMessage! : ""
            self.updateCurrentChatroom?.updatedChatroom(chatroom: unWrapedChatroom)
        } else {
            if let otherUser = receivedUser {
                
                // create a new chatroom
//                let newChatRoom = ChatRoom(id: newChatroomId, usersIds: [DataStore.shared.user.id, otherUser.id], messagesIds: [], lastMessage: self.messageInput.text, unreadCount: 0, lastMessageDate: currentTimeStamp(), pinnedAt: currentTimeStamp(), createdAt: currentTimeStamp());
                

                
                let newChatRoom = ChatRoom(id: "\(newChatroomId)", usersIds: [DataStore.shared.user.id, otherUser.id], messagesIds:[], lastMessage: (lastMessage != nil) ? lastMessage! : "", unreadCount: 13, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())
                
                
                
                // create a new message
                let newMessage = Message(
                    id: "\(UUID())",
                    chatroomId: newChatRoom.id,
                    senderId: DataStore.shared.user.id,
                    textMessage: text,
                    audioMessage: audioFileName,
                    photoMessage: photoObject,
                    videoMessage: videoObject,
                    fileMessage: nil,
                    locationMessage: locationObject,
                    createdAt: currentTimeStamp());
                
//                newChatRoom.messages.append(newMessage);
                
                // set self.chatroom to this new chatroom
                self.chatroom = newChatRoom
                
                let appName = DataStore.shared.appName
                
                // set chatroomDiskPath
                chatroomDiskPath = "\(appName)/chats"
                
                // create file name for the chatroom
                let fileName = "chats.db"
                
                // update messages disk path:
                messagesDiskPath = chatroomDiskPath + "/\(newChatroomId)/messages"
                // save new chatroom to database on disk
                saveChatroomsToDatabaseOnDisk(fileName: fileName, folderName: chatroomDiskPath, chatrooms: [newChatRoom], tableName: DataStore.shared.chatsTable)
                // display message and update datasource
                appendMessage(message: newMessage)
                // update chats controller (<- prvious scene)
                self.addNewChatroomDelegate?.newChatAdded(newChat: newChatRoom)
               // print("here we got")
            }
        }
        
        self.messageInput.text = Language.message
        messageInput.textColor = UIColor.lightGray
        messageInput.selectedTextRange = messageInput.textRange(from: messageInput.beginningOfDocument, to: messageInput.beginningOfDocument)
        self.showSendImage(show: false)
        
    }
}
