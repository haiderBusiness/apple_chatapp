//
//  SaveAllChatsAndPhotosToDisk.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 23.7.2023.
//

import UIKit


//class PersonArrayWrapper: NSObject, NSSecureCoding {
//    static var supportsSecureCoding: Bool { return true }
//    let persons: [Person]
//
//    init(persons: [Person]) {
//        self.persons = persons
//    }
//
//    func encode(with coder: NSCoder) {
//        coder.encode(persons, forKey: "persons")
//    }
//
//    required init?(coder: NSCoder) {
//        guard let persons = coder.decodeObject(of: [NSArray.self, Person.self], forKey: "persons") as? [Person] else {
//            return nil
//        }
//        self.persons = persons
//    }
//}







class Book: NSObject, NSCoding {
    
    var title:String
    var author:String
    var published:Int

    init(title: String, author: String, published: Int) {
          self.title = title
          self.author = author
          self.published = published
      }
      
      func encode(with coder: NSCoder) {
          coder.encode(title, forKey: "title")
          coder.encode(author, forKey: "author")
          coder.encode(published, forKey: "published")
      }
      
      required convenience init?(coder: NSCoder) {
          guard let title = coder.decodeObject(forKey: "title") as? String,
                let author = coder.decodeObject(forKey: "author") as? String
          else { return nil }

          self.init(
              title: title,
              author: author,
              published: coder.decodeInteger(forKey: "published")
          )
      }
    
    
    func replacementObject(forKeyedArchiver archiver: NSKeyedArchiver) -> Any? {
        return nil
    }
}


struct Person {
    var name: String
    var age: Int
}


    let chatroom = ChatRoom(id: "\(1003)", usersIds:[], messagesIds:[], lastMessage: "Did you get my email?", unreadCount: 0, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())



func saveTestArray(folderName: String) {
 
//    // Example usage
//    let _ = [Person(name: "Alice", age: 25), Person(name: "Bob", age: 30)]
//
//    let books = [Book(title: "testBook", author: "testAuthor", published: 1932), Book(title: "1testBook", author: "1testAuthor", published: 1932), Book(title: "2testBook", author: "2testAuthor", published: 1932)]
//
//
//
//   let messages = [MessageClass(id: "\(UUID())", chatroom: chatroom, senderId: DataStore.shared.user.id, textMessage: "HI!", createdAt: randomTimestamp()),
//        (MessageClass(id: "\(UUID())", chatroom: chatroom, senderId: DataStore.shared.user.id, textMessage: "don't you have an enternet", createdAt: randomTimestamp())),
//        (MessageClass(id: "\(UUID())", chatroom: chatroom, senderId: DataStore.shared.user.id, textMessage: "What is wrong?", createdAt: randomTimestamp())),
//        (MessageClass(id: "\(UUID())", chatroom: chatroom, senderId: DataStore.shared.user.id, textMessage: "don't you have an enternet", createdAt: randomTimestamp()))
//    ]
//
//
//    // Save the array to disk
//    saveArrayToDisk(books, fileName: "persons_array", folderName: folderName)
}

func saveAllChatsAndPhotosToDisk(completion: @escaping ([ChatRoom]) -> Void) {
    
    
    var chatrooms = getChatroomsWithPhotoMessages(data: DataStore.shared.users)
    
    let authUser = DataStore.shared.user
    
    let appName = DataStore.shared.appName
    
    for index in 0..<chatrooms.count {
        
        let chatroom = chatrooms[index]
//        let chatroomFolderName = appName + "/chats/\(chatroom.id)/images"
        let chatroomFolderName = appName + "/images"
        
        //TODO: maybe you need to get group users also
        
        let chatroomUserId: String? = chatroom.usersIds.first(where: {$0 != authUser!.id})
        
        
        let messages = addMessages(chatroom: chatroom, otherUserId: chatroomUserId)
        
        
        
        let messagesFileName = "messages.json"
//        let messagesFileName = "messages"
        let messagesFolderName = "\(appName)/chats/\(chatroom.id)/messages"
        
        
//        let startTime = Date()
        // save messages as a json file
        saveMessagesToDisk(messages, fileName: messagesFileName, folderName: messagesFolderName)
//        let endTime = Date()
//        let timeElapsed = endTime.timeIntervalSince(startTime)
//        print("Messagesdatabase reading time spent: ", timeElapsed)
        
        // save messages as an SQL Database
        saveMessagesToDatabaseOnDisk(fileName: "messages", folderName: messagesFolderName, messages: messages, tableName: DataStore.shared.messagesTable)
        
//        saveArrayToDisk(chatroom.messages, fileName: "persons_array", folderName: messagesFolderName)
        
        // Iterate through each message in the chatroom
        
        
        
        
        for message in messages {
            if let photoMessage = message.photoMessage {
                downloadImageToDisk(placeHolderUrl: photoMessage.placeHolderUrl, folderName: chatroomFolderName, beforStart: nil, completion: nil)
            }
        }
        
//        for message in chatroom.messagesids {
//            if let photoMessage = message.photoMessage {
//                downloadImageToDisk(placeHolderUrl: photoMessage.placeHolderUrl, folderName: chatroomFolderName, beforStart: nil, completion: nil)
//            }
//        }
//
        chatrooms[index].messagesIds = []
        
        // Call the completion handler with the processed chatrooms
    }
    
    completion(chatrooms)
}
