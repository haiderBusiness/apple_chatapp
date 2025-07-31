//
//  MessagesSQLite.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 5.8.2023.
//

import UIKit
import SQLite


// save a specific chatroom's all messages to the messageTable
func saveMessagesToDatabaseOnDisk(fileName: String, folderName: String, messages: [Message], tableName: String) {
    guard let folderUrl = getDirectoryURL(folderName: folderName) else {
        print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error in (saveMessagesDatabase > folderUrl), failed to get folder url"]))
        return
    }

    let databasePath = "\(folderUrl)/\(fileName).db"

    let encoder = JSONEncoder()

    do {
        // Record the start time
        let startTime = Date()

        let database = try Connection(databasePath)
        let messagesTable = Table(tableName)

        // Create the table if it doesn't exist

            try database.run(messagesTable.create(ifNotExists: true) { table in
                table.column(SQLiteMessageSchema.id, primaryKey: true)
                table.column(SQLiteMessageSchema.chatroomId)
                table.column(SQLiteMessageSchema.senderId)
                table.column(SQLiteMessageSchema.textMessage)
                table.column(SQLiteMessageSchema.audioMessage)
                table.column(SQLiteMessageSchema.photoMessage)
                table.column(SQLiteMessageSchema.videoMessage)
                table.column(SQLiteMessageSchema.fileMessage)
                table.column(SQLiteMessageSchema.locationMessage)
                table.column(SQLiteMessageSchema.replyMessage)
                table.column(SQLiteMessageSchema.reactions)
                table.column(SQLiteMessageSchema.isSelected)
                table.column(SQLiteMessageSchema.isSent)
                table.column(SQLiteMessageSchema.isRead)
                table.column(SQLiteMessageSchema.isEdited)
                table.column(SQLiteMessageSchema.isDeleted)
                table.column(SQLiteMessageSchema.sentAt)
                table.column(SQLiteMessageSchema.readAt)
                table.column(SQLiteMessageSchema.editedAt)
                table.column(SQLiteMessageSchema.deletedAt)
                table.column(SQLiteMessageSchema.mentions)
                table.column(SQLiteMessageSchema.coordinates)
                table.column(SQLiteMessageSchema.hashtags)
                table.column(SQLiteMessageSchema.isFlagged)
                table.column(SQLiteMessageSchema.flaggedAt)
                table.column(SQLiteMessageSchema.createdAt)
            })

            // Prepare the insert statement
//            let insert = try database.prepare("INSERT INTO messagesTable (id, chatroom, sender, textMessage, audioMessage, photoMessage, videoMessage, fileMessage, locationMessage, replyMessage, reactions, isSelected, isSent, isRead, isEdited, isDeleted, sentAt, readAt, editedAt, deletedAt, mentions, coordinates, hashtags, isFlagged, flaggedAt, createdAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")

            // Batch insert using a transaction
            try database.transaction {
                for message in messages {
                    // Your insert code here...
                    let imageJson: Data = try encoder.encode(message.photoMessage)
                    let videoJson: Data = try encoder.encode(message.videoMessage)
                    let locationJson: Data = try encoder.encode(message.locationMessage)
                    let replyJson: Data = try encoder.encode(message.replyMessage)
                    let reactionsJson: Data = try encoder.encode(message.reactions)
                    let mentionsJson: Data = try encoder.encode(message.mentions)
                    let hashtagsJson: Data = try encoder.encode(message.hashtags)
                    let coordinatesJson: Data = try encoder.encode(message.coordinates)
//                    let chatroomJson: Data = try encoder.encode(message.chatroom)
//                    let senderJson: Data = try encoder.encode(message.sender)
                    
//                    let blobObjectData : [UInt8]? = imageJson.map { $0 }
//                    if let imageJson = blobObjectData {
//                        print("imageObject: ", imageJson)
//                    }
                    
//                    if let imageData =  message.photoMessage  {
//                        print("imageBlob: ", Blob(bytes: message.photoMessage))
//                    }

//                    try insert.run(
//                        message.id, sender as? Binding, chatroom as? Binding,
//                        message.textMessage, message.audioMessage, videoJson as? Binding,
//                        message.fileMessage, locationJson as? Binding, replyJson as? Binding, reactionsJson as? Binding,
//                        message.isSelected, message.isSent, message.isRead, message.isEdited,
//                        message.isDeleted, message.sentAt, message.readAt, message.editedAt,
//                        message.deletedAt, mentionsJson as? Binding, locationJson as? Binding, hashtagsJson as? Binding,
//                        message.isFlagged, message.flaggedAt, message.createdAt
//                    )
                      let insert = messagesTable.insert(
                        SQLiteMessageSchema.id <- message.id,
                        SQLiteMessageSchema.chatroomId <- message.chatroomId,
                        SQLiteMessageSchema.senderId <- message.senderId,
                        SQLiteMessageSchema.textMessage <- message.textMessage,
                        SQLiteMessageSchema.audioMessage <- message.audioMessage,
                        SQLiteMessageSchema.photoMessage <- imageJson,
                        SQLiteMessageSchema.videoMessage <- videoJson,
                        SQLiteMessageSchema.fileMessage <- message.fileMessage,
                        SQLiteMessageSchema.locationMessage <- locationJson,
                        SQLiteMessageSchema.replyMessage <- replyJson,
                        SQLiteMessageSchema.reactions <- reactionsJson,
                        SQLiteMessageSchema.isSelected <- message.isSelected,
                        SQLiteMessageSchema.isSent <- message.isSent,
                        SQLiteMessageSchema.isRead <- message.isRead,
                        SQLiteMessageSchema.isEdited <- message.isEdited,
                        SQLiteMessageSchema.isDeleted <- message.isDeleted,
                        SQLiteMessageSchema.sentAt <- message.sentAt,
                        SQLiteMessageSchema.readAt <- message.readAt,
                        SQLiteMessageSchema.editedAt <- message.editedAt,
                        SQLiteMessageSchema.deletedAt <- message.deletedAt,
                        SQLiteMessageSchema.mentions <- mentionsJson,
                        SQLiteMessageSchema.coordinates <- coordinatesJson,
                        SQLiteMessageSchema.hashtags <- hashtagsJson,
                        SQLiteMessageSchema.isFlagged <- message.isFlagged,
                        SQLiteMessageSchema.flaggedAt <- message.flaggedAt,
                        SQLiteMessageSchema.createdAt <- message.createdAt
                    )
                    
                    try database.run(insert)
                }
            }

        // Record the end time
        let endTime = Date()

        // Calculate the time elapsed
        let timeElapsed = endTime.timeIntervalSince(startTime)
        print("database saving time spent: ", timeElapsed)
    } catch {
        print("Error in (saveMessagesDatabase > catch block): ", error)
    }
}





// Retrive all messages for s specific chatroom from the messageTable
func retrieveMessagesFromDatabaseOnDisk(fileName: String, folderName: String, tableName: String) -> [Message]? {
    guard let folderUrl = getDirectoryURL(folderName: folderName) else {
        print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error in (retrieveMessagesFromDatabaseOnDisk > folderUrl), failed to get folder url"]))
        return []
    }
    
//    let chatroom12 = ChatRoom(id: "\(1003)", usersIds:[],messagesIds:[], lastMessage: "Did you get my email?", unreadCount: 0, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())

    let databasePath = "\(folderUrl)/\(fileName).db"
    


//    let user = DataStore.shared.user!
    
    let startTime = Date()
    
    do {
        let database = try Connection(databasePath)
        let messagesTable = Table(tableName)

        // Prepare the select statement
        let select = messagesTable.select(*)

        // Execute the select query and fetch the results
        var retrievedMessages: [Message] = []
        for row in try database.prepare(select) {
            // Your retrieval code here...
            let id = row[SQLiteMessageSchema.id]
            let chatroomId = row[SQLiteMessageSchema.chatroomId]//... Retrieve chatroom here ...
            let senderId = row[SQLiteMessageSchema.senderId]//... Retrieve sender here ...
            let textMessage = row[SQLiteMessageSchema.textMessage]
            let audioMessage = row[SQLiteMessageSchema.audioMessage]
            let photoMessageData = row[SQLiteMessageSchema.photoMessage]
            let videoMessageData = row[SQLiteMessageSchema.videoMessage]
            let fileMessage = row[SQLiteMessageSchema.fileMessage]
            let locationMessageData = row[SQLiteMessageSchema.locationMessage]
            let replyMessageData = row[SQLiteMessageSchema.replyMessage]
            let reactionsData = row[SQLiteMessageSchema.reactions]
            let isSelected = row[SQLiteMessageSchema.isSelected]
            let isSent = row[SQLiteMessageSchema.isSent]
            let isRead = row[SQLiteMessageSchema.isRead]
            let isEdited = row[SQLiteMessageSchema.isEdited]
            let isDeleted = row[SQLiteMessageSchema.isDeleted]
            let sentAt = row[SQLiteMessageSchema.sentAt]
            let readAt = row[SQLiteMessageSchema.readAt]
            let editedAt = row[SQLiteMessageSchema.editedAt]
            let deletedAt = row[SQLiteMessageSchema.deletedAt]
            let mentionsData = row[SQLiteMessageSchema.mentions]
            let coordinatesData = row[SQLiteMessageSchema.coordinates]
            let hashtagsData = row[SQLiteMessageSchema.hashtags]
            let isFlagged = row[SQLiteMessageSchema.isFlagged]
            let flaggedAt = row[SQLiteMessageSchema.flaggedAt]
            let createdAt = row[SQLiteMessageSchema.createdAt]
            
            let decoder = JSONDecoder()
             
            
            let photoMessage =  try? decoder.decode(PhotoMessage.self, from: photoMessageData)
            let videoMessage = try? decoder.decode(VideoMessage.self, from: videoMessageData)
            let locationMessage =  try? decoder.decode(Coordinates.self, from: locationMessageData)
            let replyMessage =  try? decoder.decode(MessageReply.self, from: replyMessageData)
            let reactions = try? decoder.decode([Reaction].self, from: reactionsData)
            let mentions = try? decoder.decode([String].self, from: mentionsData)
            let hashtags = try? decoder.decode([String].self, from: hashtagsData)
            let coordinates = try? decoder.decode(Coordinates.self, from: coordinatesData)
            
//            if let sender =  try? decoder.decode(User.self, from: senderId), let chatroom = try? decoder.decode(ChatRoom.self, from: chatroomId) {
                
                let message = Message(id: id, chatroomId: chatroomId, senderId: senderId, textMessage: textMessage,
                                      audioMessage: audioMessage, photoMessage: photoMessage,
                                      videoMessage: videoMessage, fileMessage: fileMessage,
                                      locationMessage: locationMessage, replyMessage: replyMessage,
                                      reactions: reactions, isSelected: isSelected, isSent: isSent,
                                      isRead: isRead, isEdited: isEdited, isDeleted: isDeleted,
                                      sentAt: sentAt, readAt: readAt, editedAt: editedAt, deletedAt: deletedAt,
                                      mentions: mentions, coordinates: coordinates, hashtags: hashtags,
                                      isFlagged: isFlagged, flaggedAt: flaggedAt, createdAt: createdAt)

                retrievedMessages.append(message)
                
//            }




            
        }
        
        let endTime = Date()
        let timeElapsed = endTime.timeIntervalSince(startTime)
        print("Messagesdatabase reading time spent: ", timeElapsed)
        return retrievedMessages
    } catch {
        print("Error in (retrieveMessagesFromDatabaseOnDisk > catch block): ", error)
        return nil
    }
    
    
}



// Retrieve specific number of messages offest for a specific chatroom from messageTable. (not all messages)
func retrieveNumberOfMessagesFromDatabaseOnDisk(fileName: String, folderName: String, limit: Int, offset: Int, tableName: String) -> [Message]? {
    guard let folderUrl = getDirectoryURL(folderName: folderName) else {
        print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error in (retrieveMessagesFromDatabaseOnDisk > folderUrl), failed to get folder url"]))
        return []
    }
    
//    let chatroom12 = ChatRoom(id: "\(1003)", usersIds:[],messagesIds:[], lastMessage: "Did you get my email?", unreadCount: 0, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())

    let databasePath = "\(folderUrl)/\(fileName).db"
    


//    let user = DataStore.shared.user!
    
    let startTime = Date()
    
    do {
        let database = try Connection(databasePath)
        let messagesTable = Table(tableName)

        // Prepare the select statement
        let select = messagesTable.select(*).order(SQLiteMessageSchema.createdAt.desc).limit(limit, offset: offset)

        // Execute the select query and fetch the results
        var retrievedMessages: [Message] = []
        for row in try database.prepare(select) {
            // Your retrieval code here...
            let id = row[SQLiteMessageSchema.id]
            let chatroomId = row[SQLiteMessageSchema.chatroomId]//... Retrieve chatroom here ...
            let senderId = row[SQLiteMessageSchema.senderId]//... Retrieve sender here ...
            let textMessage = row[SQLiteMessageSchema.textMessage]
            let audioMessage = row[SQLiteMessageSchema.audioMessage]
            let photoMessageData = row[SQLiteMessageSchema.photoMessage]
            let videoMessageData = row[SQLiteMessageSchema.videoMessage]
            let fileMessage = row[SQLiteMessageSchema.fileMessage]
            let locationMessageData = row[SQLiteMessageSchema.locationMessage]
            let replyMessageData = row[SQLiteMessageSchema.replyMessage]
            let reactionsData = row[SQLiteMessageSchema.reactions]
            let isSelected = row[SQLiteMessageSchema.isSelected]
            let isSent = row[SQLiteMessageSchema.isSent]
            let isRead = row[SQLiteMessageSchema.isRead]
            let isEdited = row[SQLiteMessageSchema.isEdited]
            let isDeleted = row[SQLiteMessageSchema.isDeleted]
            let sentAt = row[SQLiteMessageSchema.sentAt]
            let readAt = row[SQLiteMessageSchema.readAt]
            let editedAt = row[SQLiteMessageSchema.editedAt]
            let deletedAt = row[SQLiteMessageSchema.deletedAt]
            let mentionsData = row[SQLiteMessageSchema.mentions]
            let coordinatesData = row[SQLiteMessageSchema.coordinates]
            let hashtagsData = row[SQLiteMessageSchema.hashtags]
            let isFlagged = row[SQLiteMessageSchema.isFlagged]
            let flaggedAt = row[SQLiteMessageSchema.flaggedAt]
            let createdAt = row[SQLiteMessageSchema.createdAt]
            
            let decoder = JSONDecoder()
             
            
            let photoMessage =  try? decoder.decode(PhotoMessage.self, from: photoMessageData)
            let videoMessage = try? decoder.decode(VideoMessage.self, from: videoMessageData)
            let locationMessage =  try? decoder.decode(Coordinates.self, from: locationMessageData)
            let replyMessage =  try? decoder.decode(MessageReply.self, from: replyMessageData)
            let reactions = try? decoder.decode([Reaction].self, from: reactionsData)
            let mentions = try? decoder.decode([String].self, from: mentionsData)
            let hashtags = try? decoder.decode([String].self, from: hashtagsData)
            let coordinates = try? decoder.decode(Coordinates.self, from: coordinatesData)
            
//            if let sender =  try? decoder.decode(User.self, from: senderId), let chatroom = try? decoder.decode(ChatRoom.self, from: chatroomId) {
                
                let message = Message(id: id, chatroomId: chatroomId, senderId: senderId, textMessage: textMessage,
                                      audioMessage: audioMessage, photoMessage: photoMessage,
                                      videoMessage: videoMessage, fileMessage: fileMessage,
                                      locationMessage: locationMessage, replyMessage: replyMessage,
                                      reactions: reactions, isSelected: isSelected, isSent: isSent,
                                      isRead: isRead, isEdited: isEdited, isDeleted: isDeleted,
                                      sentAt: sentAt, readAt: readAt, editedAt: editedAt, deletedAt: deletedAt,
                                      mentions: mentions, coordinates: coordinates, hashtags: hashtags,
                                      isFlagged: isFlagged, flaggedAt: flaggedAt, createdAt: createdAt)

                retrievedMessages.append(message)
                
//            }




            
        }
        
        let endTime = Date()
        let timeElapsed = endTime.timeIntervalSince(startTime)
        print("Messagesdatabase reading time spent: ", timeElapsed)
        if retrievedMessages.count < 1 {
            return nil
        } else {
            return retrievedMessages
        }

    } catch {
        print("Error in (retrieveMessagesFromDatabaseOnDisk > catch block): ", error)
        return nil
    }
    
    
}



// Save a new message to the messageTable :
func saveMessageToDatabaseOnDisk(fileName: String, folderName: String, message: Message, tableName: String) {
    guard let folderUrl = getDirectoryURL(folderName: folderName) else {
        print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error in (saveMessagesDatabase > folderUrl), failed to get folder url"]))
        return
    }

    let databasePath = "\(folderUrl)/\(fileName).db"

    let encoder = JSONEncoder()

    do {
        // Record the start time
        let startTime = Date()

        let database = try Connection(databasePath)
        let messagesTable = Table(tableName)

            // Create the table if it doesn't exist
            try database.run(messagesTable.create(ifNotExists: true) { table in
                table.column(SQLiteMessageSchema.id, primaryKey: true)
                table.column(SQLiteMessageSchema.chatroomId)
                table.column(SQLiteMessageSchema.senderId)
                table.column(SQLiteMessageSchema.textMessage)
                table.column(SQLiteMessageSchema.audioMessage)
                table.column(SQLiteMessageSchema.photoMessage)
                table.column(SQLiteMessageSchema.videoMessage)
                table.column(SQLiteMessageSchema.fileMessage)
                table.column(SQLiteMessageSchema.locationMessage)
                table.column(SQLiteMessageSchema.replyMessage)
                table.column(SQLiteMessageSchema.reactions)
                table.column(SQLiteMessageSchema.isSelected)
                table.column(SQLiteMessageSchema.isSent)
                table.column(SQLiteMessageSchema.isRead)
                table.column(SQLiteMessageSchema.isEdited)
                table.column(SQLiteMessageSchema.isDeleted)
                table.column(SQLiteMessageSchema.sentAt)
                table.column(SQLiteMessageSchema.readAt)
                table.column(SQLiteMessageSchema.editedAt)
                table.column(SQLiteMessageSchema.deletedAt)
                table.column(SQLiteMessageSchema.mentions)
                table.column(SQLiteMessageSchema.coordinates)
                table.column(SQLiteMessageSchema.hashtags)
                table.column(SQLiteMessageSchema.isFlagged)
                table.column(SQLiteMessageSchema.flaggedAt)
                table.column(SQLiteMessageSchema.createdAt)
            })


                    // insert code here...
                    let imageJson: Data = try encoder.encode(message.photoMessage)
                    let videoJson: Data = try encoder.encode(message.videoMessage)
                    let locationJson: Data = try encoder.encode(message.locationMessage)
                    let replyJson: Data = try encoder.encode(message.replyMessage)
                    let reactionsJson: Data = try encoder.encode(message.reactions)
                    let mentionsJson: Data = try encoder.encode(message.mentions)
                    let hashtagsJson: Data = try encoder.encode(message.hashtags)
                    let coordinatesJson: Data = try encoder.encode(message.coordinates)

                      let insert = messagesTable.insert(
                        SQLiteMessageSchema.id <- message.id,
                        SQLiteMessageSchema.chatroomId <- message.chatroomId,
                        SQLiteMessageSchema.senderId <- message.senderId,
                        SQLiteMessageSchema.textMessage <- message.textMessage,
                        SQLiteMessageSchema.audioMessage <- message.audioMessage,
                        SQLiteMessageSchema.photoMessage <- imageJson,
                        SQLiteMessageSchema.videoMessage <- videoJson,
                        SQLiteMessageSchema.fileMessage <- message.fileMessage,
                        SQLiteMessageSchema.locationMessage <- locationJson,
                        SQLiteMessageSchema.replyMessage <- replyJson,
                        SQLiteMessageSchema.reactions <- reactionsJson,
                        SQLiteMessageSchema.isSelected <- message.isSelected,
                        SQLiteMessageSchema.isSent <- message.isSent,
                        SQLiteMessageSchema.isRead <- message.isRead,
                        SQLiteMessageSchema.isEdited <- message.isEdited,
                        SQLiteMessageSchema.isDeleted <- message.isDeleted,
                        SQLiteMessageSchema.sentAt <- message.sentAt,
                        SQLiteMessageSchema.readAt <- message.readAt,
                        SQLiteMessageSchema.editedAt <- message.editedAt,
                        SQLiteMessageSchema.deletedAt <- message.deletedAt,
                        SQLiteMessageSchema.mentions <- mentionsJson,
                        SQLiteMessageSchema.coordinates <- coordinatesJson,
                        SQLiteMessageSchema.hashtags <- hashtagsJson,
                        SQLiteMessageSchema.isFlagged <- message.isFlagged,
                        SQLiteMessageSchema.flaggedAt <- message.flaggedAt,
                        SQLiteMessageSchema.createdAt <- message.createdAt
                    )
                    
                    try database.run(insert)

        // Record the end time
        let endTime = Date()

        // Calculate the time elapsed
        let timeElapsed = endTime.timeIntervalSince(startTime)
        print("database saving time spent: ", timeElapsed)
    } catch {
        print("Error in (saveMessagesDatabase > catch block): ", error)
    }
}




// Update a specific message in the messageTable on disk:
func updateMessageInDatabaseOnDisk(fileName: String, folderName: String, messageToUpdate: Message, tableName: String) {
    guard let folderUrl = getDirectoryURL(folderName: folderName) else {
        print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error in (updateMessageInDatabaseOnDisk > folderUrl), failed to get folder url"]))
        return
    }

    let databasePath = "\(folderUrl)/\(fileName).db"

    let encoder = JSONEncoder()

    do {
        // Record the start time
        let startTime = Date()

        let database = try Connection(databasePath)
        let messagesTable = Table(tableName)

        // Update code here...
        let imageJson: Data = try encoder.encode(messageToUpdate.photoMessage)
        let videoJson: Data = try encoder.encode(messageToUpdate.videoMessage)
        let locationJson: Data = try encoder.encode(messageToUpdate.locationMessage)
        let replyJson: Data = try encoder.encode(messageToUpdate.replyMessage)
        let reactionsJson: Data = try encoder.encode(messageToUpdate.reactions)
        let mentionsJson: Data = try encoder.encode(messageToUpdate.mentions)
        let hashtagsJson: Data = try encoder.encode(messageToUpdate.hashtags)
        let coordinatesJson: Data = try encoder.encode(messageToUpdate.coordinates)

        // Create a filter to match the specific message you want to update
        let messageFilter = messagesTable.filter(SQLiteMessageSchema.id == messageToUpdate.id)

        // Perform the update
        let update = messageFilter.update(
            SQLiteMessageSchema.chatroomId <- messageToUpdate.chatroomId,
            SQLiteMessageSchema.senderId <- messageToUpdate.senderId,
            SQLiteMessageSchema.textMessage <- messageToUpdate.textMessage,
            SQLiteMessageSchema.audioMessage <- messageToUpdate.audioMessage,
            SQLiteMessageSchema.photoMessage <- imageJson,
            SQLiteMessageSchema.videoMessage <- videoJson,
            SQLiteMessageSchema.fileMessage <- messageToUpdate.fileMessage,
            SQLiteMessageSchema.locationMessage <- locationJson,
            SQLiteMessageSchema.replyMessage <- replyJson,
            SQLiteMessageSchema.reactions <- reactionsJson,
            SQLiteMessageSchema.isSelected <- messageToUpdate.isSelected,
            SQLiteMessageSchema.isSent <- messageToUpdate.isSent,
            SQLiteMessageSchema.isRead <- messageToUpdate.isRead,
            SQLiteMessageSchema.isEdited <- messageToUpdate.isEdited,
            SQLiteMessageSchema.isDeleted <- messageToUpdate.isDeleted,
            SQLiteMessageSchema.sentAt <- messageToUpdate.sentAt,
            SQLiteMessageSchema.readAt <- messageToUpdate.readAt,
            SQLiteMessageSchema.editedAt <- messageToUpdate.editedAt,
            SQLiteMessageSchema.deletedAt <- messageToUpdate.deletedAt,
            SQLiteMessageSchema.mentions <- mentionsJson,
            SQLiteMessageSchema.coordinates <- coordinatesJson,
            SQLiteMessageSchema.hashtags <- hashtagsJson,
            SQLiteMessageSchema.isFlagged <- messageToUpdate.isFlagged,
            SQLiteMessageSchema.flaggedAt <- messageToUpdate.flaggedAt,
            SQLiteMessageSchema.createdAt <- messageToUpdate.createdAt
        )

        try database.run(update)

        // Record the end time
        let endTime = Date()

        // Calculate the time elapsed
        let timeElapsed = endTime.timeIntervalSince(startTime)
        print("database update time spent: ", timeElapsed)
    } catch {
        print("Error in (updateMessageInDatabaseOnDisk > catch block): ", error)
    }
}



// delete chatrooms in the messagesTable on disk:
func deleteMessagesInDatabaseOnDisk(fileName: String, folderName: String, messagesToDelete: [Message], tableName: String) {
    guard let folderUrl = getDirectoryURL(folderName: folderName) else {
        print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error in (updateChatroomInDatabaseOnDisk > folderUrl), failed to get folder url"]))
        return
    }

    let databasePath = "\(folderUrl)/\(fileName).db"

    do {
        // Record the start time
        let startTime = Date()

        let database = try Connection(databasePath)
        let messagesTable = Table(tableName)

        
        
        try database.transaction {
            for message in messagesToDelete {
                // Create a filter to match the specific message you want to update
                let messagesFilter = messagesTable.filter(SQLiteChatroomSchema.id == message.id)
                
                // Perform the update
                let delete = messagesFilter.delete()
                
                try database.run(delete)
            }
        }

        // Record the end time
        let endTime = Date()

        // Calculate the time elapsed
        let timeElapsed = endTime.timeIntervalSince(startTime)
        print("database update time spent: ", timeElapsed)
    } catch {
        print("Error in (deleteChatroomInDatabaseOnDisk > catch block): ", error)
    }
}
