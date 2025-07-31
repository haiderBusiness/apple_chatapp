//
//  setUserData.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 23.7.2023.
//

import UIKit

func setUserData() {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let imageLink = "https://www.google.com/search?q=man+image&rlz=1C5CHFA_enFI978FI978&oq=man+image+&aqs=chrome..69i57j69i59l2j69i60.151116j0j9&sourceid=chrome&ie=UTF-8#imgrc=WDnjVHeluEl1gM&imgdii=pD2XsonmQW76BM"
    
    let avatarData = PhotoMessage(photoUrl: imageLink, placeHolderUrl: imageLink, photoSizeInPX: ImageSizeInPX(width: 0, height: 0), photoSizeInBytes: "10 KB", savedOnDeviceId: nil)
    
    let user = User(id: "authID:12345", firstName: "Haider", lastName: "Al-Tameemi", gender: .male, userName: "haider132", email: "haider@gmail.com", password: "12345678", phoneNumber: "0467896545", birthdate: Date(), address: "Newyourk as 4 D 5", avatar: avatarData, onlineStatus: OnlineStatus.online,
//                    textMessages: [], audioMessages: [], photoMessages: [], videoMessages: [], attachments: [], followers: [], following: [],
                    createdAt: Date())
    
    DataStore.shared.user = user
    
    // set users data here
    
    let fileName = "users.json"
    let appName = DataStore.shared.appName
    let diskPath = "\(appName)/users"
    
    let areUsersSaved = areUsersSavedToDisk(fileName: diskPath + "/" + fileName)
    
    if areUsersSaved {
        if let users = readUsersFromDisk(fileName: fileName, folderName: diskPath) {
            DataStore.shared.users = users
        }
    } else {
        let users = generateDummyUsers()
        saveUsersToDisk(users, fileName: fileName, folderName: diskPath)
        DataStore.shared.users = users
    }
    
}
