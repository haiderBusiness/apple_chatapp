//
//  ChatroomsSQLite.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 15.8.2023.
//

import UIKit
import SQLite


// save a specific chatroom's all messages to the messagesTable
func saveChatroomsToDatabaseOnDisk(fileName: String, folderName: String, chatrooms: [ChatRoom], tableName: String) {
    guard let folderUrl = getDirectoryURL(folderName: folderName) else {
        print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error in (saveChatroomsDatabase > folderUrl), failed to get folder url"]))
        return
    }

    let databasePath = "\(folderUrl)/\(fileName)"
    
    //path is something like this: Users/al-tameemihayder/Library/Developer/CoreSimulator/Devices/ED0005FD-82FD-4E8D-A356-20ECB8F2F75B/data/Containers/Data/Application/9379C18A-C3F7-4C37-A1F1-FA2268445A02/Documents/ThisAppName/chats//chats.db
    
    print("path url of database on disk: ",databasePath)

    let encoder = JSONEncoder()

    do {
        // Record the start time
        let startTime = Date()

        let database = try Connection(databasePath)
        let chatroomsTable = Table(tableName)

        // Create the table if it doesn't exist
        
            try database.run(chatroomsTable.create(ifNotExists: true) { table in
                table.column(SQLiteChatroomSchema.id, primaryKey: true)
                table.column(SQLiteChatroomSchema.usersIds)
                table.column(SQLiteChatroomSchema.messagesIds)
                table.column(SQLiteChatroomSchema.lastMessage)
                table.column(SQLiteChatroomSchema.unreadCount)
                table.column(SQLiteChatroomSchema.lastMessageDate)
                table.column(SQLiteChatroomSchema.name)
                table.column(SQLiteChatroomSchema.image)
                table.column(SQLiteChatroomSchema.selected)
                table.column(SQLiteChatroomSchema.archived)
                table.column(SQLiteChatroomSchema.markUnRead)
                table.column(SQLiteChatroomSchema.deleted)
                table.column(SQLiteChatroomSchema.muted)
                table.column(SQLiteChatroomSchema.pinned)
                table.column(SQLiteChatroomSchema.pinnedAt)
                table.column(SQLiteChatroomSchema.editedAt)
                table.column(SQLiteChatroomSchema.deletedAt)
                table.column(SQLiteChatroomSchema.messageDisappear)
                table.column(SQLiteChatroomSchema.createdAt)
            })

            // Batch insert using a transaction
            try database.transaction {
                for chatroom in chatrooms {
                    // Your insert code here...
                    let imageJson: Data = try encoder.encode(chatroom.image)
                    let userIdsJson: Data = try encoder.encode(chatroom.usersIds)
                    let messageIdsJson: Data = try encoder.encode(chatroom.messagesIds)
                    let messageDisapperJson: Data = try encoder.encode(chatroom.messageDisapear)
        
        
                      let insert = chatroomsTable.insert(
                        SQLiteChatroomSchema.id <- chatroom.id,
                        SQLiteChatroomSchema.usersIds <- userIdsJson,
                        SQLiteChatroomSchema.messagesIds <- messageIdsJson,
                        SQLiteChatroomSchema.lastMessage <- chatroom.lastMessage,
                        SQLiteChatroomSchema.unreadCount <- chatroom.unreadCount,
                        SQLiteChatroomSchema.lastMessageDate <- chatroom.lastMessageDate,
                        SQLiteChatroomSchema.name <- chatroom.name,
                        SQLiteChatroomSchema.image <- imageJson,
                        SQLiteChatroomSchema.selected <- chatroom.selected,
                        SQLiteChatroomSchema.archived <- chatroom.archived,
                        SQLiteChatroomSchema.markUnRead <- chatroom.markUnRead,
                        SQLiteChatroomSchema.deleted <- chatroom.deleted,
                        SQLiteChatroomSchema.muted <- chatroom.muted,
                        SQLiteChatroomSchema.pinned <- chatroom.pinned,
                        SQLiteChatroomSchema.pinnedAt <- chatroom.pinnedAt,
                        SQLiteChatroomSchema.editedAt <- chatroom.editedAt,
                        SQLiteChatroomSchema.deletedAt <- chatroom.deletedAt,
                        SQLiteChatroomSchema.messageDisappear <- messageDisapperJson,
                        SQLiteChatroomSchema.createdAt <- chatroom.createdAt
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
        print("Error in (saveChatroomsDatabase > catch block): ", error)
    }
}




// Retrieve specific number of messages offest for a specific chatroom from messageTable. (not all messages)
func retrieveChatroomsFromDatabaseOnDisk(fileName: String, folderName: String, limit: Int?, offset: Int?, tableName: String) -> [ChatRoom]? {
    guard let folderUrl = getDirectoryURL(folderName: folderName) else {
        print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error in (retrieveChatroomsFromDatabaseOnDisk > folderUrl), failed to get folder url"]))
        return []
    }
    
    let databasePath = "\(folderUrl)/\(fileName)"
    
    
    let startTime = Date()
    
    do {
        let database = try Connection(databasePath)
        let chatroomsTable = Table(tableName)
        
        // Prepare the select statement
        var select: QueryType!
        
        if let limit = limit, let offset = offset {
           select = chatroomsTable.select(*).order(SQLiteChatroomSchema.lastMessageDate.desc).limit(limit, offset: offset)
        } else {
            select = chatroomsTable.select(*).order(SQLiteChatroomSchema.lastMessageDate.desc)
        }

        // Execute the select query and fetch the results
        var retrievedChatrooms: [ChatRoom] = []
        for row in try database.prepare(select) {
            // Your retrieval code here...
            let id = row[SQLiteChatroomSchema.id]
            let usersIdsJson = row[SQLiteChatroomSchema.usersIds]
            let messagesIdsJson = row[SQLiteChatroomSchema.messagesIds]
            let lastMessage = row[SQLiteChatroomSchema.lastMessage]
            let unreadCount = row[SQLiteChatroomSchema.unreadCount]
            let lastMessageDate = row[SQLiteChatroomSchema.lastMessageDate]
            let name = row[SQLiteChatroomSchema.name]
            let image = row[SQLiteChatroomSchema.image]
            let selected = row[SQLiteChatroomSchema.selected]
            let archived = row[SQLiteChatroomSchema.archived]
            let markUnRead = row[SQLiteChatroomSchema.markUnRead]
            let deleted = row[SQLiteChatroomSchema.deleted]
            let muted = row[SQLiteChatroomSchema.muted]
            let pinned = row[SQLiteChatroomSchema.pinned]
            let pinnedAt = row[SQLiteChatroomSchema.pinnedAt]
            let editedAt = row[SQLiteChatroomSchema.editedAt]
            let deletedAt = row[SQLiteChatroomSchema.deletedAt]
            let messageDisappearJson = row[SQLiteChatroomSchema.messageDisappear]
            let createdAt = row[SQLiteChatroomSchema.createdAt]

            
            let decoder = JSONDecoder()
             
            
            let imageObject =  try? decoder.decode(PhotoMessage.self, from: image)
            let usersIds = try? decoder.decode([String].self, from: usersIdsJson)
            let messagesIds = try? decoder.decode([String].self, from: messagesIdsJson)
            let messageDisappear = try? decoder.decode(MessageDisapear.self, from: messageDisappearJson)

                
            let message = ChatRoom(id: id, usersIds: usersIds ?? [], messagesIds: messagesIds ?? [], lastMessage: lastMessage, unreadCount: unreadCount, lastMessageDate: lastMessageDate, name: name, image: imageObject, selected: selected, archived: archived, markUnRead: markUnRead, deleted: deleted, muted: muted, pinned: pinned, pinnedAt: pinnedAt, editedAt: editedAt, deletedAt: deletedAt, messageDisapear: messageDisappear ?? .off, createdAt: createdAt)

                retrievedChatrooms.append(message)
                
//            }




            
        }
        
        let endTime = Date()
        let timeElapsed = endTime.timeIntervalSince(startTime)
        print("Chatroomsdatabase reading time spent: ", timeElapsed)
        if retrievedChatrooms.count < 1 {
            return nil
        } else {
            return retrievedChatrooms
        }

    } catch {
        print("Error in (retrieveChatroomsFromDatabaseOnDisk > catch block): ", error)
        return nil
    }
    
    
}


// Update a specific message in the messageTable on disk:
func updateChatroomsInDatabaseOnDisk(fileName: String, folderName: String, chatroomsToUpdate: [ChatRoom], tableName: String) {
    guard let folderUrl = getDirectoryURL(folderName: folderName) else {
        print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error in (updateChatroomInDatabaseOnDisk > folderUrl), failed to get folder url"]))
        return
    }

    let databasePath = "\(folderUrl)/\(fileName)"

    let encoder = JSONEncoder()

    do {
        // Record the start time
        let startTime = Date()

        let database = try Connection(databasePath)
        let chatroomsTable = Table(tableName)

        

        
        
        try database.transaction {
            for chatroom in chatroomsToUpdate {
                // Update code here...
                let imageJson: Data = try encoder.encode(chatroom.image)
                let userIdsJson: Data = try encoder.encode(chatroom.usersIds)
                let messageIdsJson: Data = try encoder.encode(chatroom.messagesIds)
                let messageDisapperJson: Data = try encoder.encode(chatroom.messageDisapear)
                
                // Create a filter to match the specific message you want to update
                let chatroomFilter = chatroomsTable.filter(SQLiteChatroomSchema.id == chatroom.id)
                
                // Perform the update
                let update = chatroomFilter.update(
                    SQLiteChatroomSchema.id <- chatroom.id,
                    SQLiteChatroomSchema.usersIds <- userIdsJson,
                    SQLiteChatroomSchema.messagesIds <- messageIdsJson,
                    SQLiteChatroomSchema.lastMessage <- chatroom.lastMessage,
                    SQLiteChatroomSchema.unreadCount <- chatroom.unreadCount,
                    SQLiteChatroomSchema.lastMessageDate <- chatroom.lastMessageDate,
                    SQLiteChatroomSchema.name <- chatroom.name,
                    SQLiteChatroomSchema.image <- imageJson,
                    SQLiteChatroomSchema.selected <- chatroom.selected,
                    SQLiteChatroomSchema.archived <- chatroom.archived,
                    SQLiteChatroomSchema.markUnRead <- chatroom.markUnRead,
                    SQLiteChatroomSchema.deleted <- chatroom.deleted,
                    SQLiteChatroomSchema.muted <- chatroom.muted,
                    SQLiteChatroomSchema.pinned <- chatroom.pinned,
                    SQLiteChatroomSchema.pinnedAt <- chatroom.pinnedAt,
                    SQLiteChatroomSchema.editedAt <- chatroom.editedAt,
                    SQLiteChatroomSchema.deletedAt <- chatroom.deletedAt,
                    SQLiteChatroomSchema.messageDisappear <- messageDisapperJson,
                    SQLiteChatroomSchema.createdAt <- chatroom.createdAt
                )
                
                try database.run(update)
            }
            
 
        }

        // Record the end time
        let endTime = Date()

        // Calculate the time elapsed
        let timeElapsed = endTime.timeIntervalSince(startTime)
        print("database update time spent: ", timeElapsed)
    } catch {
        print("Error in (updateChatroomInDatabaseOnDisk > catch block): ", error)
    }
}


// delete chatrooms in the chatroomsTable on disk:
func deleteChatroomsInDatabaseOnDisk(fileName: String, folderName: String, chatroomsToUpdate: [ChatRoom], tableName: String) {
    guard let folderUrl = getDirectoryURL(folderName: folderName) else {
        print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error in (updateChatroomInDatabaseOnDisk > folderUrl), failed to get folder url"]))
        return
    }

    let databasePath = "\(folderUrl)/\(fileName)"

    do {
        // Record the start time
        let startTime = Date()

        let database = try Connection(databasePath)
        let chatroomsTable = Table(tableName)

        

        
        
        try database.transaction {
            for chatroom in chatroomsToUpdate {
                // Create a filter to match the specific message you want to update
                let chatroomFilter = chatroomsTable.filter(SQLiteChatroomSchema.id == chatroom.id)
                
                // Perform the update
                let delete = chatroomFilter.delete()
                
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
