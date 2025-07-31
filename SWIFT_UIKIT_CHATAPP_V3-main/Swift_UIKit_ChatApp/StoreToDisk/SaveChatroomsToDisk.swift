//
//  SaveChatroomsToDisk.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 20.7.2023.
//

import UIKit

// Step 1: Serialize the Message array to data (JSON or binary)
func serializeChatrooms(_ chatrooms: [ChatRoom]) throws -> Data {
    let encoder = JSONEncoder() // Use JSONEncoder for JSON serialization
    return try encoder.encode(chatrooms)
}


func getCachedChatroomsDirectoryURL(folderName: String) -> URL? {
    let fileManager = FileManager.default
    
    // Get the app's Documents directory
    guard let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
        return nil
    }

    // Append a folder name for cached Chatrooms
    let cachedChatroomsFolderName = folderName
    let cachedChatroomsDirectoryURL = documentsDirectoryURL.appendingPathComponent(cachedChatroomsFolderName)

    do {
        // Create the directory if it doesn't exist
        try fileManager.createDirectory(at: cachedChatroomsDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        return cachedChatroomsDirectoryURL
    } catch {
        print("Error in creating cached chatrooms directory: \(error)")
        return nil
    }
}



// Step 2: Save the serialized data to a file on disk
func saveChatroomsToDisk(_ chatrooms: [ChatRoom], fileName: String, folderName: String) {
    
    guard let cachedChatroomsDirectoryURL = getCachedChatroomsDirectoryURL(folderName: folderName) else {
         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached Chatrooms directory URL."]))
        return
    }
    
    let fileURL = cachedChatroomsDirectoryURL.appendingPathComponent(fileName)
    
    do {
        let data = try serializeChatrooms(chatrooms)
        FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
//        print("Chatrooms successfully saved: ", fileURL)
    } catch {
        print("Error in (saveChatroomsToDisk > catch block: )",error)
    }
    
}

// checks if Chatrooms have been saved or not
func areChatroomsSavedToDisk(fileName: String) -> Bool {
    let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectoryURL.appendingPathComponent(fileName)
    
    return FileManager.default.fileExists(atPath: fileURL.path)
}


// Step 3: Read the file from disk and deserialize it back into an array of Message objects
func readChatroomsFromDisk(fileName: String, folderName: String) -> [ChatRoom]? {
    
    guard let cachedChatroomsDirectoryURL = getCachedChatroomsDirectoryURL(folderName: folderName) else {
         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached Chatrooms directory URL."]))
        return nil
    }
    
    let fileURL = cachedChatroomsDirectoryURL.appendingPathComponent(fileName)
    do {
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        let chatrooms = try decoder.decode([ChatRoom].self, from: data)
//        print("found saved Chatrooms")
        return chatrooms
    } catch {
        print("Error in (readChatroomsFromDisk > catch block: ", error)
    }
    
    return nil
}


// to remove Chatrooms from disk
func removeChatroomsFromDisk(fileName: String, folderName: String, removeFolder: Bool = false) {
    
    guard let cachedChatroomsDirectoryURL = getCachedChatroomsDirectoryURL(folderName: folderName) else {
         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached Chatrooms directory URL."]))
        return
    }

    if removeFolder {
        do {
            try FileManager.default.removeItem(at: cachedChatroomsDirectoryURL)
        } catch {
            print("Error in (removeChatroomsFromDisk > removeFolder > catch block): ", error)
        }
    } else {
        let fileURL = cachedChatroomsDirectoryURL.appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: fileURL)
//            print("successfully removed message from disk")
        } catch {
            print("Error in (removeChatroomsFromDisk > else > catch block): ", error)
        }
    }
}

