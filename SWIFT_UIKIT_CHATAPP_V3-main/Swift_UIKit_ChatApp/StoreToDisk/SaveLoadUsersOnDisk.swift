//
//  SaveLoadUsersOnDisk.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 4.8.2023.
//

import UIKit


    // Step 1: Serialize the Message array to data (JSON or binary)
    func serializeUsers(_ users: [User]) throws -> Data {
        let encoder = JSONEncoder() // Use JSONEncoder for JSON serialization
        return try encoder.encode(users)
    }

    func convertArrayToString(users: [User]) -> String {
        let string = "\(users)"
        return string
    }




    // Step 2: Save the serialized data to a file on disk
    func saveUsersToDisk(_ users: [User], fileName: String, folderName: String) {
        
        guard let cachedUsersDirectoryURL = getDirectoryURL(folderName: folderName) else {
             print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached users directory URL."]))
            return
        }
        
        let fileURL = cachedUsersDirectoryURL.appendingPathComponent(fileName)
    
        
        do {
            let data = try serializeUsers(users)
            FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
            print("users successfully saved")
        } catch {
            print("Error in (saveUsersToDisk > catch block: )", error)
        }
        
        
//        let messageWrappers = users.map { MessageWrapper(message: $0) }
//
//        do {
//            let data = try NSKeyedArchiver.archivedData(withRootObject: messageWrappers, requiringSecureCoding: false)
////            try data.write(to: fileURL, options: .atomic)
//            FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
////            try data.write(to: fileURL)
//            print("users successfully saved")
//        } catch {
//            print("error in saveusersToDisk function: ",error)
//        }
        
    }

    // checks if users have been saved or not
    func areUsersSavedToDisk(fileName: String) -> Bool {
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectoryURL.appendingPathComponent(fileName)
        
        return FileManager.default.fileExists(atPath: fileURL.path)
    }


    // Step 3: Read the file from disk and deserialize it back into an array of Message objects
    func readUsersFromDisk(fileName: String, folderName: String) -> [User]? {

        guard let cachedUsersDirectoryURL = getDirectoryURL(folderName: folderName) else {
             print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached users directory URL."]))
            return nil
        }

        let fileURL = cachedUsersDirectoryURL.appendingPathComponent(fileName)

        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let users = try decoder.decode([User].self, from: data)
            print("found saved users")
            return users
        } catch {
            print(error)
        }


        return nil

//        if let data = try? Data(contentsOf: fileURL),
//               let messageWrappers = NSKeyedUnarchiver.unarchiveObject(with: data) as? [MessageWrapper] {
//                let users = messageWrappers.map { $0.message }
//                print("Found saved users")
//                return users
//            } else {
//                return nil
//            }

//        do {
//            let data = try Data(contentsOf: fileURL)
//            let unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
//
//            if let messageWrappers = unarchiver.decodeObject(of: [NSArray.self, MessageWrapper.self], forKey: NSKeyedArchiveRootObjectKey) as? [MessageWrapper] {
//                let users = messageWrappers.map { $0.message }
//                print("Found saved users")
//                return users
//            }
//        } catch {
//            print(error)
//        }
//
//        return nil
    }


// Step 3: Read the file from disk and deserialize it back into an array of Message objects
//func readusersFromDisk(fileName: String, folderName: String, completion: @escaping ([User]?) -> Void) {
//
//    guard let cachedUsersDirectoryURL = getDirectoryURL(folderName: folderName) else {
//         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached users directory URL."]))
//        completion(nil)
//        return
//    }
//
//    let fileURL = cachedusersDirectoryURL.appendingPathComponent(fileName)
//
//    DispatchQueue.global().async {
//        do {
//            let data = try Data(contentsOf: fileURL)
//            let decoder = JSONDecoder()
//            let users = try decoder.decode([User].self, from: data)
//            print("found saved users")
//            completion(users)
//        } catch {
//            completion(nil)
//            print(error)
//        }
//    }
//
//    completion(nil)
//
//}


    // to remove users from disk
func removeUsersFromDisk(fileName: String, folderName: String, removeFolder: Bool = false) {
        
    guard let cachedUsersDirectoryURL = getDirectoryURL(folderName: folderName) else {
         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached users directory URL."]))
        return
    }

    if removeFolder {
        do {
            try FileManager.default.removeItem(at: cachedUsersDirectoryURL)
            print("successfully removed users folder from disk")
        } catch {
            print(error)
        }
    } else {
        let fileURL = cachedUsersDirectoryURL.appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("successfully removed user from disk")
        } catch {
            print(error)
        }
    }
}

//    // Step 4: Remove the data after one month is passed
//    func removeExpiredusers(filePath: String) {
//        do {
//            let fileAttributes = try FileManager.default.attributesOfItem(atPath: filePath)
//            if let creationDate = fileAttributes[FileAttributeKey.creationDate] as? Date {
//                let currentTime = Date()
//                let oneMonthInSeconds: TimeInterval = 30 * 24 * 60 * 60 // 30 days * 24 hours * 60 minutes * 60 seconds
//                if currentTime.timeIntervalSince(creationDate) > oneMonthInSeconds {
//                    try FileManager.default.removeItem(atPath: filePath)
//                }
//            }
//        } catch {
//            // Handle any errors that might occur during the process
//            print("Error while removing expired users: \(error)")
//        }
//    }


    
   



