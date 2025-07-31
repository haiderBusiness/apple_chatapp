//
//  GenerateUsers.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 11.6.2023.
//

import UIKit


// Create a function to generate random dates within a specified range
func randomDate(from startDate: Date, to endDate: Date) -> Date {
    let timeInterval = endDate.timeIntervalSince(startDate)
    let randomInterval = TimeInterval.random(in: 0...timeInterval)
    return startDate.addingTimeInterval(randomInterval)
}

// Generate dummy data for 13 users
func generateDummyUsers() -> [User] {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    var users: [User] = []
    
    
    //let firstNames = ["John", "Jane", "David", "Emma", "Michael", "Olivia", "Daniel", "Sophia", "Matthew", "Isabella", "Andrew", "Emily", "William"]
    let lastNames = ["Smith", "Johnson", "Brown", "Taylor", "Anderson", "Miller", "Wilson", "Moore", "Clark", "Lee", "Young", "Hall", "King"]
//    let genders: [Gender] = [.male, .female]
    let usernames = ["johnsmith", "jane_doe", "davidbrown", "emma_m", "michael87", "olivia23", "daniel_12", "sophia2000", "mattew_w", "isabella7", "andy23", "emilyc", "william_k"]
    let emailDomains = ["gmail.com", "yahoo.com", "hotmail.com", "outlook.com"]
    let passwords = ["password123", "12345678", "qwerty", "abcdefg", "password1234", "987654321", "letmein", "football", "baseball", "qwerty123"]
    let phoneNumbers = ["1234567890", "9876543210", "5555555555", "1111111111", "9999999999", "1231231234", "5551234567", "9876543210", "5555555555", "1111111111", "9999999999", "1231231234", "5551234567"]
    let addresses = ["123 Main St", "456 Elm St", "789 Oak Ave", "321 Pine St", "555 Maple Dr", "777 Cedar Ln", "999 Walnut Ave", "888 Birch Rd", "111 Spruce Ct", "222 Ash St", "444 Cherry Ave", "666 Willow Ln", "333 Oakwood Dr"]
    
    var menNames = ["John", "Jane", "David", "Michael", "Daniel", "Matthew", "Andrew", "William",]
    
    var womenNames = ["Emma", "Olivia", "Sophia", "Isabella", "Emily", "Saali", "Zainab", "Elisa"]
    
    func firstName(gender: Gender) -> String {
        var toReturn = ""
        if gender == .male {
            if let randomName = menNames.randomElement(){
            let index = menNames.firstIndex(of: randomName)!
            menNames.remove(at: index)
            toReturn = randomName
            }
        } else {
            if let randomName = womenNames.randomElement() {
            let index = womenNames.firstIndex(of: randomName)!
            womenNames.remove(at: index)
                toReturn = randomName
            }
        }
        
        return toReturn
    }
    
    
    var menAvatars: [String] = [
                   "https://randomuser.me/api/portraits/men/2.jpg",
                   "https://randomuser.me/api/portraits/men/3.jpg",
                   "https://randomuser.me/api/portraits/men/4.jpg",
                   "https://randomuser.me/api/portraits/men/6.jpg",
                   "https://randomuser.me/api/portraits/men/8.jpg",
                   "https://randomuser.me/api/portraits/men/10.jpg",
                   "https://randomuser.me/api/portraits/men/12.jpg",
                   "https://randomuser.me/api/portraits/men/14.jpg",
                   "https://randomuser.me/api/portraits/men/16.jpg",
                ]
    
    var womenAvatars = [
        "https://randomuser.me/api/portraits/women/1.jpg",
        "https://randomuser.me/api/portraits/women/13.jpg",
        "https://randomuser.me/api/portraits/women/5.jpg",
        "https://randomuser.me/api/portraits/women/7.jpg",
        "https://randomuser.me/api/portraits/women/9.jpg",
        "https://randomuser.me/api/portraits/women/11.jpg",
        "https://randomuser.me/api/portraits/women/15.jpg",
        "https://randomuser.me/api/portraits/women/17.jpg"
    ]
    
    func avatar(gender: Gender) -> String {
        
        var toReturn = ""
        
        if gender == .male {
            if let randomAvatar = menAvatars.randomElement() {
                let index = menAvatars.firstIndex(of: randomAvatar)!
                menAvatars.remove(at: index)
                toReturn = randomAvatar
            }
            
        } else {
            if let randomAvatar = womenAvatars.randomElement() {
                let index = womenAvatars.firstIndex(of: randomAvatar)!
                    womenAvatars.remove(at: index)
                    toReturn = randomAvatar
            }
        }
        
        return toReturn
    }
    
//    func name(gender: Gender) -> String {
//
//        if gender == .male {
//            return menNames.randomElement()!
//        } else {
//            return womenNames.randomElement()!
//        }
//    }
    
//    let interests = [["Sports", "Movies"], ["Music", "Books"], ["Photography"], ["Cooking", "Travel"], ["Art", "Fashion"], ["Technology", "Gaming"], ["Fitness"], ["Food", "Nature"], ["Writing"], ["Dancing"]]
    
    
    var previousGender: Gender!
    
    for i in 1...13 {
        
        if previousGender == .male {
            previousGender = .female
        } else {
            previousGender = .male
        }
        
        
        //let genderValue: Gender = genders.randomElement()!
        
        let firstName = firstName(gender: previousGender!)
        let lastName = lastNames.randomElement()!
        let gender = previousGender!
        let username = usernames[i-1]
        let email = "\(username)@\(emailDomains.randomElement()!)"
        let password = passwords.randomElement()!
        let phoneNumber = phoneNumbers[i-1]
        let birthdate = randomDate(from: dateFormatter.date(from: "1980-01-01")!, to: dateFormatter.date(from: "2005-12-31")!)
        let address = addresses.randomElement()!
        let coordinates = Coordinates(latitude: Double.random(in: -90...90), longitude: Double.random(in: -180...180))
        let avatar = avatar(gender: previousGender!)
        let onlineStatus = Bool.random() ? OnlineStatus.online : OnlineStatus.offline
        let createdAt = randomDate(from: dateFormatter.date(from: "2020-01-01")!, to: Date())
        let lastOnlineAt = randomDate(from: dateFormatter.date(from: "2023-01-01")!, to: Date())
        
        let user = User(
            id: "\(UUID())",
            firstName: firstName,
            middleName: nil,
            lastName: lastName,
            gender: gender,
            userName: username,
            email: email,
            password: password,
            phoneNumber: phoneNumber,
            birthdate: birthdate,
            address: address,
            coordinates: coordinates,
            avatar: PhotoMessage(photoUrl: avatar, placeHolderUrl: avatar, photoSizeInPX: ImageSizeInPX(width: 0, height: 0), photoSizeInBytes: "", savedOnDeviceId: ""),
            onlineStatus: onlineStatus,
//            textMessages: [],
//            audioMessages: [],
//            photoMessages: [],
//            videoMessages: [],
//            attachments: [],
//            followers: [],
//            following: [],
//            interests: interests.randomElement(),
////                        notifications: [],
//            blockedUsers: [],
//            favoriteMessages: [],
//                        savedPosts: [],
            lastOnlineAt: lastOnlineAt,
            createdAt: createdAt)
        
        users.append(user)
    }
    
    
//    users.insert(User(firstName: "Sami", lastName: "John", gender: .male, userName: "sami_somaali", email: "sami.somaali@gmail.com", password: "sami12345", phoneNumber: "0469697687", birthdate: Date(), address: "Miami 5 S 42", onlineStatus: .offline, textMessages: [], audioMessages: [], photoMessages: [], videoMessages: [], attachments: [], followers: [], following: [], createdAt: Date()), at: 0);
//
//    users.insert(User(firstName: "Ahmed", lastName: "Somaali", gender: .male, userName: "ahmed_somaali", email: "ahmed.somaali@gmail.com", password: "ahmed12345", phoneNumber: "0469697687", birthdate: Date(), address: "Olympiakatu 10 F 42", onlineStatus: .offline, textMessages: [], audioMessages: [], photoMessages: [], videoMessages: [], attachments: [], followers: [], following: [], createdAt: Date()), at: 0);
    
    
    return users
}
