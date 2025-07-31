//
//  DataStore.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 20.7.2023.
//

import UIKit

class DataStore {
    static let shared = DataStore()
    
    var deviceUniqueIdentifier: String!
    
    var appName = "ThisAppName"
    var chatsServer = "http://localhost/test-server-images/"
    
    let archivedChatsTable = "archivedChatsTable"
    let chatsTable = "chatsTable"
    let messagesTable = "messagesTable"
    
    
    
    var user: User!
    var chatrooms: [ChatRoom] = []
    var archivedChatrooms : [ChatRoom] = []
    var users: [User] = []
    
    
//    let mapView = MapView()
    
    
    
    
    private init() {

        let fileName = "deviceUinqueIdentifer.txt"
        let filePath = "\(appName)/\(fileName)"
        
        if doesFileExist(fileName: filePath) {
            print("file exists")
            deviceUniqueIdentifier = loadStringFromDisk(fileName: filePath)
        } else {
            deviceUniqueIdentifier = "\(UUID())"
            saveStringToDisk(deviceUniqueIdentifier, fileName: fileName, folderName: appName)
        }
    }
    
    
}
