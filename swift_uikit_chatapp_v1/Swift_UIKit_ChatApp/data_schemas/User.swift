//
//  User.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 12.7.2023.
//

import Foundation

enum OnlineStatus: Codable {
    case online
    case offline
}

enum TypingStatus: Codable {
    case isTyping
    case notTyping
}

enum Gender: Codable {
    case male
    case female
    case intersex
    case trans
    case nonConforming
    case personal
    case eunuch
}

struct User: Codable {
    var id: String
    var firstName: String
    var middleName: String?
    var lastName: String
    var gender: Gender
    var userName: String
    var email: String
    var password: String
    var phoneNumber: String
    var birthdate: Date
    var address: String
    var coordinates: Coordinates?
    var profilePhoto: String?
    var avatar: PhotoMessage?
    var profileUrl: String = "https://must_have_a_profile_url.com"
    var bio: String?
//    var media: [Post]?
//    var chatroomsIds: [String]?
//    var groupsIds: [String]?
    var onlineStatus: OnlineStatus
//    var textMessagesIds: [Message]
//    var audioMessagesIds: [Message]
//    var photoMessagesIds: [Message]
//    var videoMessagesIds: [Message]
//    var attachments: [Message]
//    var followers: [User]
//    var following: [User]
//    var interests: [String]?
    var isSelected: Bool = false
    var verified: Bool = false
    var isDeleted: Bool = false
    var deletedAt: Date?
//    var notifications: [Notification]?
//    var blockedUsers: [User]?
//    var favoriteMessages: [Message]?
//    var savedPosts: [Post]?
    var lastOnlineAt: Date?
    var createdAt: Date
}
