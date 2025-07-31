//
//  ImageDataSQL.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 7.8.2023.
//


import UIKit
import SQLite



    let photoUrl = Expression<String>("photoUrl")
    let placeHolderUrl = Expression<String>("placeHolderUrl")
    let photoSizeInBytes = Expression<String>("photoSizeInBytes")
    let savedOnDeviceId = Expression<String?>("savedOnDeviceId")
    let photoWidth = Expression<Double>("photoWidth")
    let photoHeight = Expression<Double>("photoHeight")



// save a specific chatroom's all messages to the messageTable
func saveImagesToDatabaseOnDisk(fileName: String, folderName: String, images: [PhotoMessage]) {
    guard let folderUrl = getDirectoryURL(folderName: folderName) else {
        print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error in (saveMessagesDatabase > folderUrl), failed to get folder url"]))
        return
    }

    let databasePath = "\(folderUrl)/\(fileName).db"

    do {
        // Record the start time
        let startTime = Date()

        let database = try Connection(databasePath)
        let imagesTable = Table("imagesTable")

        // Create the table if it doesn't exist

            try database.run(imagesTable.create(ifNotExists: true) { table in
                table.column(photoUrl, primaryKey: true)
                table.column(placeHolderUrl)
                table.column(photoSizeInBytes)
                table.column(savedOnDeviceId)
                table.column(photoWidth)
                table.column(photoHeight)
            })


            try database.transaction {
                for image in images {
                    // Your insert code here...

                      let insert = imagesTable.insert(
                        photoUrl <- image.photoUrl,
                        placeHolderUrl <- image.placeHolderUrl,
                        photoSizeInBytes <- image.photoSizeInBytes,
                        savedOnDeviceId <- image.savedOnDeviceId,
                        photoWidth <- image.photoSizeInPX.width,
                        photoHeight <- image.photoSizeInPX.height
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
        print("Error in (saveImagesToDatabaseOnDisk > catch block): ", error)
    }
}





// Retrive all messages for s specific chatroom from the messageTable
func retrieveImagesFromDatabaseOnDisk(fileName: String, folderName: String) -> [PhotoMessage]? {
    guard let folderUrl = getDirectoryURL(folderName: folderName) else {
        print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error in (retrieveMessagesFromDatabaseOnDisk > folderUrl), failed to get folder url"]))
        return []
    }
    
//    let chatroom12 = ChatRoom(id: "\(1003)", usersIds:[],messagesIds:[], lastMessage: "Did you get my email?", unreadCount: 0, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())

    let databasePath = "\(folderUrl)/\(fileName).db"
    


//    let user = DataStore.shared.user!
    
//    let startTime = Date()
    
    do {
        let database = try Connection(databasePath)
        let imagesTable = Table("imagesTable")

        // Prepare the select statement
        let select = imagesTable.select(*)

        // Execute the select query and fetch the results
        var retrievedImages: [PhotoMessage] = []
        for row in try database.prepare(select) {
            // Your retrieval code here...
            let photoUrl = row[photoUrl]
            let placeHolderUrl = row[placeHolderUrl]
            let photoSizeInBytes = row[photoSizeInBytes]
            let savedOnDeviceId = row[savedOnDeviceId]
            let photoWidth = row[photoWidth]
            let photoHeight = row[photoHeight]
             
            
            let photo = PhotoMessage(photoUrl: photoUrl, placeHolderUrl: placeHolderUrl, photoSizeInPX: ImageSizeInPX(width: photoWidth, height: photoHeight), photoSizeInBytes: photoSizeInBytes, savedOnDeviceId: savedOnDeviceId)
            
            retrievedImages.append(photo)
            
        }
        
//        let endTime = Date()
//        let timeElapsed = endTime.timeIntervalSince(startTime)
//        print("Messagesdatabase reading time spent: ", timeElapsed)
        if retrievedImages.count > 0 {
            return retrievedImages
        } else {
            return nil
        }
        
    } catch {
        print("Error in (retrieveImagesFromDatabaseOnDisk > catch block): ", error)
        return nil
    }
    
    
}




// Retrieve specific number of messages offest for a specific chatroom from messageTable. (not all messages)
func retrieveLimitedNumberOfImagesFromDatabaseOnDisk(fileName: String, folderName: String, limit: Int, offset: Int) -> [PhotoMessage]? {
    guard let folderUrl = getDirectoryURL(folderName: folderName) else {
        print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error in (retrieveMessagesFromDatabaseOnDisk > folderUrl), failed to get folder url"]))
        return []
    }
    
//    let chatroom12 = ChatRoom(id: "\(1003)", usersIds:[],messagesIds:[], lastMessage: "Did you get my email?", unreadCount: 0, lastMessageDate: randomTimestamp(), selected:false, archived: false, markUnRead: false, muted: false, pinned: false, pinnedAt: randomTimestamp(), createdAt: randomTimestamp())

    let databasePath = "\(folderUrl)/\(fileName).db"
    


//    let user = DataStore.shared.user!
    
//    let startTime = Date()
    
    do {
        let database = try Connection(databasePath)
        let imagesTable = Table("imagesTable")

        // Prepare the select statement
        let select = imagesTable.select(*).limit(limit, offset: offset)

        // Execute the select query and fetch the results
        var retrievedImages: [PhotoMessage] = []
        for row in try database.prepare(select) {
            // Your retrieval code here...
            let photoUrl = row[photoUrl]
            let placeHolderUrl = row[placeHolderUrl]
            let photoSizeInBytes = row[photoSizeInBytes]
            let savedOnDeviceId = row[savedOnDeviceId]
            let photoWidth = row[photoWidth]
            let photoHeight = row[photoHeight]
             
            
            let photo = PhotoMessage(photoUrl: photoUrl, placeHolderUrl: placeHolderUrl, photoSizeInPX: ImageSizeInPX(width: photoWidth, height: photoHeight), photoSizeInBytes: photoSizeInBytes, savedOnDeviceId: savedOnDeviceId)
            
            retrievedImages.append(photo)
            
        }
        
//        let endTime = Date()
//        let timeElapsed = endTime.timeIntervalSince(startTime)
//        print("Messagesdatabase reading time spent: ", timeElapsed)
        if retrievedImages.count < 1 {
            return nil
        } else {
            return retrievedImages
        }

    } catch {
        print("Error in (retrieveLimitedNumberOfImagesFromDatabaseOnDisk > catch block): ", error)
        return nil
    }
    
    
}



// Save a new image to the messageTable :
func saveImageToDatabaseOnDisk(fileName: String, folderName: String, image: PhotoMessage) {
    guard let folderUrl = getDirectoryURL(folderName: folderName) else {
        print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Error in (saveMessagesDatabase > folderUrl), failed to get folder url"]))
        return
    }

    let databasePath = "\(folderUrl)/\(fileName).db"

//    let encoder = JSONEncoder()

    do {
        // Record the start time
//        let startTime = Date()

        let database = try Connection(databasePath)
        let imagesTable = Table("imagesTable")

            // Create the table if it doesn't exist
            try database.run(imagesTable.create(ifNotExists: true) { table in
                table.column(photoUrl, primaryKey: true)
                table.column(placeHolderUrl)
                table.column(photoSizeInBytes)
                table.column(savedOnDeviceId)
                table.column(photoWidth)
                table.column(photoHeight)
            })


        let insert = imagesTable.insert(
          photoUrl <- image.photoUrl,
          placeHolderUrl <- image.placeHolderUrl,
          photoSizeInBytes <- image.photoSizeInBytes,
          savedOnDeviceId <- image.savedOnDeviceId,
          photoWidth <- image.photoSizeInPX.width,
          photoHeight <- image.photoSizeInPX.height
        )
      
        try database.run(insert)

        // Record the end time
//        let endTime = Date()
//
//        // Calculate the time elapsed
//        let timeElapsed = endTime.timeIntervalSince(startTime)
//        print("database saving time spent: ", timeElapsed)
    } catch {
        print("Error in (saveImageToDatabaseOnDisk > catch block): ", error)
    }
}

