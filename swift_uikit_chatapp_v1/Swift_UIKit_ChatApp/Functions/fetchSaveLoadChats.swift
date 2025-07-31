//
//  FetchSaveLoadChats.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 26.7.2023.
//

import Foundation
import UIKit

enum ChatsLoadingEnum {
    case waitingForNetwork
    case connecting
    case updating
    case working
}


func fetchSaveLoadChats(completion: @escaping ((ChatsLoadingEnum) -> Void)) {
    
    setUserData()

   

    if isThereInternetConnectionSignal() && isThereWorkingInternet() {
        
        connectToServer(completion: completion)
        
    } else if !isThereInternetConnectionSignal() {
//        self.navigateToChats(waitingForNetwork: true, connecting: false, loading: false)
        completion(.waitingForNetwork)
        print("network error")
//            showMessage(self: self, title: Language.connection_error, message: Language.no_internet_connection_please_check_your_network_settings, okActionText: Language.ok, onActionPress: nil)
    } else if !isThereWorkingInternet() {
        completion(.connecting)
        print("weak internet error")
//        self.navigateToChats(waitingForNetwork: false, connecting: true, loading: false)
//            showMessage(self: self, title: Language.connection_error, message: Language.no_internet_connection_please_check_your_network_settings, okActionText: Language.ok, onActionPress: nil)
    }
    
//    else if !isUrlReachable(urlString: serverUrl){
//        print("url error: ", serverUrl)
//        completion(.connecting)
//
////        self.navigateToChats(waitingForNetwork: false, connecting: false, loading: true)
////            showMessage(self: self, title: Language.something_went_wrong, message: Language.erorr_please_try_again_later, okActionText: Language.ok, onActionPress: nil)
//    }
    
    
}




func connectToServer(completion: @escaping ((ChatsLoadingEnum) -> Void)) {
    
    
//    let fileName = "chats.json"
    let fileName = "chats.db"
    let appName = DataStore.shared.appName
    let diskPath = "\(appName)/chats"
    
    let serverUrl = DataStore.shared.chatsServer
    
    // check if server(given url) is reachable
    isReachable(url: serverUrl) { booleanStatus in
            
        // check if chatrooms are saved on disk of this device //comment was 25hiHIHI/7/2025
        let areChatroomsSavedToDisk = areChatroomsSavedToDisk(fileName: diskPath + "/" + fileName)
        
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                            if booleanStatus == false {
                                completion(.connecting)
                            } else if !areChatroomsSavedToDisk {
                                var i = 0
                                saveAllChatsAndPhotosToDisk { chatrooms in
                                    // Update the UI on the main queue once the processing is complete
                                        print("chatrooms ", i)
                                    i += 1
//                                        saveChatroomsToDisk(chatrooms, fileName: fileName, folderName: diskPath)
                                    saveChatroomsToDatabaseOnDisk(fileName: fileName, folderName: diskPath, chatrooms: chatrooms, tableName: DataStore.shared.chatsTable)

                                        completion(.working)
                                        print("all chats are saved")
                              }
                            } else {
                                print("server is working")
                                completion(.working)
                            }
                }
            }
        }
}
