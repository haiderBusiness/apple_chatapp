//
//  StoreImageOnDisk.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 19.7.2023.
//

import UIKit



func getCachedImagesDirectoryURL(folderName: String) -> URL? {
    let fileManager = FileManager.default
    
    // Get the app's Documents directory
    guard let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
        print ("Media folder name is not valid")
        return nil
    }

    // Append a folder name for cached images
    let cachedImagesFolderName = folderName
    let cachedImagesDirectoryURL = documentsDirectoryURL.appendingPathComponent(cachedImagesFolderName)

    do {
        // Create the directory if it doesn't exist
        try fileManager.createDirectory(at: cachedImagesDirectoryURL, withIntermediateDirectories: true, attributes: nil)
        return cachedImagesDirectoryURL
    } catch {
        print("Error in creating cached images directory: \(error)")
        return nil
    }
}


func saveImageToDisk(imageData: Data, fileName: String, folderName: String) {
    
    guard let cachedImagesDirectoryURL = getCachedImagesDirectoryURL(folderName: folderName) else {
         print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached images directory URL."]))
        return
    }
    var cleanedFileName = fileName.replacingOccurrences(of: "http://", with: "")
    cleanedFileName = cleanedFileName.replacingOccurrences(of: "https://", with: "")
    cleanedFileName = cleanedFileName.replacingOccurrences(of: "/", with: "_")
    cleanedFileName = cleanedFileName.replacingOccurrences(of: "-", with: "_")
    let fileURL = cachedImagesDirectoryURL.appendingPathComponent(cleanedFileName)
    
//    print("saving image now...", fileURL)
    do {
        try imageData.write(to: fileURL)
        
    } catch {
        print("Error in saving image to disk: \(error)")
    }
}


func loadImageFromDisk(fileName: String, folderName: String, completion: ((Bool) -> Void)? = nil ) -> UIImage? {
    
    
    guard let cachedImagesDirectoryURL = getCachedImagesDirectoryURL(folderName: folderName) else {
        return nil
    }

    var cleanedFileName = fileName.replacingOccurrences(of: "http://", with: "")
    cleanedFileName = cleanedFileName.replacingOccurrences(of: "https://", with: "")
    cleanedFileName = cleanedFileName.replacingOccurrences(of: "/", with: "_")
    cleanedFileName = cleanedFileName.replacingOccurrences(of: "-", with: "_")
    let fileURL = cachedImagesDirectoryURL.appendingPathComponent(cleanedFileName)
    
    let fileManager = FileManager.default

        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                let imageData = try Data(contentsOf: fileURL)
                if let _ = completion {
                    completion!(true)
                }
                return UIImage(data: imageData)
            } catch {
                if let _ = completion {
                    completion!(false)
                }
                print("Error in loading image from disk: \(error)")
                return nil
            }
        } else {
            if let _ = completion {
                completion!(false)
            }
            return nil
        }
}




func removeImageFromDisk(fileName: String, folderName: String, removeFolder: Bool = false) {
    
    guard let cachedImagesDirectoryURL = getCachedImagesDirectoryURL(folderName: folderName) else {
        return
    }
    
    
    
    if removeFolder {
        do {
            try FileManager.default.removeItem(at: cachedImagesDirectoryURL)
            print("successfully removed images folder from disk")
        } catch {
            print(error)
        }
    } else {
        var cleanedFileName = fileName.replacingOccurrences(of: "http://", with: "")
        cleanedFileName = cleanedFileName.replacingOccurrences(of: "https://", with: "")
        cleanedFileName = cleanedFileName.replacingOccurrences(of: "/", with: "_")
        cleanedFileName = cleanedFileName.replacingOccurrences(of: "-", with: "_")
        let fileURL = cachedImagesDirectoryURL.appendingPathComponent(cleanedFileName)
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("successfully removed image from disk")
        } catch {
            print(error)
        }
    }
    
    
}


func doesImageExist(folderName: String, fileName: String) -> Bool {
    
    guard let cachedImagesDirectoryURL = getCachedImagesDirectoryURL(folderName: folderName) else {
        return false
    }
    
    var cleanedFileName = fileName.replacingOccurrences(of: "http://", with: "")
    cleanedFileName = cleanedFileName.replacingOccurrences(of: "https://", with: "")
    cleanedFileName = cleanedFileName.replacingOccurrences(of: "/", with: "_")
    cleanedFileName = cleanedFileName.replacingOccurrences(of: "-", with: "_")
    let fileURL = cachedImagesDirectoryURL.appendingPathComponent(cleanedFileName)
    
    return FileManager.default.fileExists(atPath: fileURL.path)
}

