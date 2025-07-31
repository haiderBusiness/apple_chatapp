//
//  File.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 15.8.2023.
//

import SQLite
import Foundation


struct SQLiteMessageSchema {
    static let id = Expression<String>("id")
    static let chatroomId = Expression<String>("chatroom")
    static let senderId = Expression<String>("sender")
    static let textMessage = Expression<String?>("textMessage")
    static let audioMessage = Expression<String?>("audioMessage")
    static let photoMessage = Expression<Data>("photoMessage")
    static let videoMessage = Expression<Data>("videoMessage")
    static let fileMessage = Expression<String?>("fileMessage")
    static let locationMessage = Expression<Data>("locationMessage")
    static let replyMessage = Expression<Data>("replyMessage")
    static let reactions = Expression<Data>("reactions")
    static let isSelected = Expression<Bool>("isSelected")
    static let isSent = Expression<Bool>("isSent")
    static let isRead = Expression<Bool>("isRead")
    static let isEdited = Expression<Bool>("isEdited")
    static let isDeleted = Expression<Bool>("isDeleted")
    static let sentAt = Expression<TimeInterval?>("sentAt")
    static let readAt = Expression<TimeInterval?>("readAt")
    static let editedAt = Expression<TimeInterval?>("editedAt")
    static let deletedAt = Expression<TimeInterval?>("deletedAt")
    static let mentions = Expression<Data>("mentions")
    static let hashtags = Expression<Data>("hashtags")
    static let coordinates = Expression<Data>("coordinates")
    static let isFlagged = Expression<Bool>("isFlagged")
    static let flaggedAt = Expression<TimeInterval?>("flaggedAt")
    static let createdAt = Expression<TimeInterval>("createdAt")
}
