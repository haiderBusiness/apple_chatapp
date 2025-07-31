//
//  SotreOnDisk.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 18.7.2023.
//

import UIKit


    // Step 1: Serialize the Message array to data (JSON or binary)
    func serializeMessages(_ messages: [Message]) throws -> Data {
        let encoder = JSONEncoder() // Use JSONEncoder for JSON serialization
        return try encoder.encode(messages)
    }
    
    func convertArrayToString(messages: [Message]) -> String {
        let string = "\(messages)"
        return string
    }


    func getDirectoryURL(folderName: String) -> URL? {
        let fileManager = FileManager.default
        
        // Get the app's Documents directory
        guard let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }

        // Append a folder name for cached Messages
        let cachedMessagesFolderName = folderName
        let cachedMessagesDirectoryURL = documentsDirectoryURL.appendingPathComponent(cachedMessagesFolderName)

        do {
            // Create the directory if it doesn't exist
            try fileManager.createDirectory(at: cachedMessagesDirectoryURL, withIntermediateDirectories: true, attributes: nil)
            return cachedMessagesDirectoryURL
        } catch {
            print("Error in creating cached messages directory: \(error)")
            return nil
        }
    }



    // Step 2: Save the serialized data to a file on disk
    func saveMessagesToDisk(_ messages: [Message], fileName: String, folderName: String) {
        
        guard let cachedMessagesDirectoryURL = getDirectoryURL(folderName: folderName) else {
             print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached messages directory URL."]))
            return
        }
        
        let fileURL = cachedMessagesDirectoryURL.appendingPathComponent(fileName)
    
        do {
            let data = try serializeMessages(messages)
            FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
            print("messages successfully saved, ")
        } catch {
            print(error)
        }
        
        
//        let messageWrappers = messages.map { MessageWrapper(message: $0) }
//
//        do {
//            let data = try NSKeyedArchiver.archivedData(withRootObject: messageWrappers, requiringSecureCoding: false)
////            try data.write(to: fileURL, options: .atomic)
//            FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
////            try data.write(to: fileURL)
//            print("Messages successfully saved")
//        } catch {
//            print("error in saveMessagesToDisk function: ",error)
//        }
        
    }

    // checks if messages have been saved or not
    func areMessagesSavedToDisk(fileName: String) -> Bool {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectoryURL.appendingPathComponent(fileName)
        
        return FileManager.default.fileExists(atPath: fileURL.path)
    }


    // Step 3: Read the file from disk and deserialize it back into an array of Message objects
    func readMessagesFromDisk(fileName: String, folderName: String) -> [Message]? {

        guard let cachedMessagesDirectoryURL = getDirectoryURL(folderName: folderName) else {
             print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached messages directory URL."]))
            return nil
        }

        let fileURL = cachedMessagesDirectoryURL.appendingPathComponent(fileName)
        let startTime = Date()
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let messages = try decoder.decode([Message].self, from: data)
            
            let endTime = Date()
            let timeElapsed = endTime.timeIntervalSince(startTime)
            print("Messages.json reading time spent: ", timeElapsed)
            
            return messages
        } catch {
            print("Error in (readMessagesFromDisk > catch block): ", error)
            return nil
        }

//        if let data = try? Data(contentsOf: fileURL),
//               let messageWrappers = NSKeyedUnarchiver.unarchiveObject(with: data) as? [MessageWrapper] {
//                let messages = messageWrappers.map { $0.message }
//                print("Found saved messages")
//                return messages
//            } else {
//                return nil
//            }

//        do {
//            let data = try Data(contentsOf: fileURL)
//            let unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
//
//            if let messageWrappers = unarchiver.decodeObject(of: [NSArray.self, MessageWrapper.self], forKey: NSKeyedArchiveRootObjectKey) as? [MessageWrapper] {
//                let messages = messageWrappers.map { $0.message }
//                print("Found saved messages")
//                return messages
//            }
//        } catch {
//            print(error)
//        }
//
//        return nil
    }


// Step 3: Read the file from disk and deserialize it back into an array of Message objects
//func readMessagesFromDisk(fileName: String, folderName: String, completion: @escaping ([Message]?) -> Void) {
//
//    guard let cachedMessagesDirectoryURL = getDirectoryURL(folderName: folderName) else {
//         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached messages directory URL."]))
//        completion(nil)
//        return
//    }
//
//    let fileURL = cachedMessagesDirectoryURL.appendingPathComponent(fileName)
//
//    DispatchQueue.global().async {
//        do {
//            let data = try Data(contentsOf: fileURL)
//            let decoder = JSONDecoder()
//            let messages = try decoder.decode([Message].self, from: data)
//            print("found saved messages")
//            completion(messages)
//        } catch {
//            completion(nil)
//            print(error)
//        }
//    }
//
//    completion(nil)
//
//}




    // Step 4: Remove the data after one month is passed
    func removeExpiredMessages(filePath: String) {
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: filePath)
            if let creationDate = fileAttributes[FileAttributeKey.creationDate] as? Date {
                let currentTime = Date()
                let oneMonthInSeconds: TimeInterval = 30 * 24 * 60 * 60 // 30 days * 24 hours * 60 minutes * 60 seconds
                if currentTime.timeIntervalSince(creationDate) > oneMonthInSeconds {
                    try FileManager.default.removeItem(atPath: filePath)
                }
            }
        } catch {
            // Handle any errors that might occur during the process
            print("Error while removing expired messages: \(error)")
        }
    }


    
   


