//
//  SomeSavingFuncs.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 20.7.2023.
//

import UIKit


func createOrLoadFolder(folderName: String) -> URL? {
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


func saveStringToDisk(_ stringToSave: String, fileName: String, folderName: String) {
    
    guard let savedDirectoryURL = createOrLoadFolder(folderName: folderName) else {
         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached images directory URL."]))
        return
    }
    
    
    let fileURL = savedDirectoryURL.appendingPathComponent(fileName)
    
    do {
        // Convert the string to Data
        let data = stringToSave.data(using: .utf8)
        
        // Write the data to the specified file path
        try data?.write(to: fileURL, options: .atomic)

        print("String successfully saved to disk.")
    } catch {
        print("Error in saving string to disk: \(error)")
    }
}


 


func loadStringFromDisk(fileName: String) -> String? {
    
    let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectoryURL.appendingPathComponent(fileName)
    
    do {
        // Read the data from the specified file path
        
        let data = try Data(contentsOf: fileURL)

        // Convert the data to a string using UTF-8 encoding
        if let loadedString = String(data: data, encoding: .utf8) {
            print("String successfully loaded from disk.")
            return loadedString
        }
    } catch {
        print("Error in loading string from disk: \(error)")
    }

    return nil
}



func doesFileExist(fileName: String) -> Bool {
    let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectoryURL.appendingPathComponent(fileName)
    
    return FileManager.default.fileExists(atPath: fileURL.path)
}



func saveArrayToDisk(_ array: [Message], fileName: String, folderName: String) {
    
    guard let cachedMessagesDirectoryURL = getDirectoryURL(folderName: folderName) else {
         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached messages directory URL."]))
        return
    }
    
    let fileURL = cachedMessagesDirectoryURL.appendingPathComponent(fileName)
    
    let messageWrappers = array.map { MessageWrapper(message: $0) }
    
    
    do {
//        let data = try NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: false)
        let data = try NSKeyedArchiver.archivedData(withRootObject: messageWrappers, requiringSecureCoding: false)
        try data.write(to: fileURL)
        print("Array successfully saved")
    } catch {
        print("Error saving array:", error)
    }
}

// Step 2: Load the array from disk using binary serialization
func loadArrayFromDisk<T: Codable>(fileName: String) -> [T]? {
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)

    do {
        let data = try Data(contentsOf: fileURL)
        if let array = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [T] {
            print("Array successfully loaded")
            return array
        }
    } catch {
        print("Error loading array:", error)
    }
    
    return nil
}




func loadFileFrom(fileName: String) -> String? {
    
    let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectoryURL.appendingPathComponent(fileName)
    
    do {
        // Read the data from the specified file path
        
        let data = try Data(contentsOf: fileURL)

        // Convert the data to a string using UTF-8 encoding
        if let loadedString = String(data: data, encoding: .utf8) {
            print("String successfully loaded from disk.")
            return loadedString
        }
    } catch {
        print("Error in loading string from disk: \(error)")
    }

    return nil
}


// to remove messages from disk
func removeFileOrFolderFromDisk(fileName: String, folderName: String, removeFolder: Bool = false) {
    
    guard let cachedMessagesDirectoryURL = getDirectoryURL(folderName: folderName) else {
         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached messages directory URL."]))
        return
    }

    if removeFolder {
        do {
            try FileManager.default.removeItem(at: cachedMessagesDirectoryURL)
            print("successfully removed folder from disk")
        } catch {
            print(error)
        }
    } else {
        let fileURL = cachedMessagesDirectoryURL.appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("successfully removed file from disk")
        } catch {
            print(error)
        }
    }
}



