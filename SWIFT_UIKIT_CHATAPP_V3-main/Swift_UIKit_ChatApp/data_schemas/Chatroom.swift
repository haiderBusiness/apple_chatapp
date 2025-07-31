//
//  Chatroom.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 12.7.2023.
//

import UIKit

struct ChatRoom: MenuIdentifiable, Codable {
    var id: String
    var usersIds: [String] // user ids
    var messagesIds: [String] // messages ids
    var lastMessage: String
    var unreadCount: Int
    var lastMessageDate: Double
    var name: String?
    var image: PhotoMessage?
    
    var selected: Bool = false
    var archived: Bool = false
    var markUnRead: Bool = false
    var deleted: Bool = false
    var muted: Bool = false
    var pinned: Bool = false
    var pinnedAt: TimeInterval
    var editedAt: TimeInterval? // Timestamp indicating when the comment was last edited
    var deletedAt: TimeInterval?
    var messageDisapear: MessageDisapear = .off
    var createdAt: TimeInterval
}



//
//
//class ChatRoomClass: NSObject, NSCoding {
//    var id: String
//    var users: [User]
//    var messages: [Message]
//    var lastMessage: String
//    var unreadCount: Int
//    var lastMessageDate: Double
//    var name: String?
//    var image: PhotoMessage?
//    var selected: Bool = false
//    var archived: Bool = false
//    var markUnRead: Bool = false
//    var deleted: Bool = false
//    var muted: Bool = false
//    var pinned: Bool = false
//    var pinnedAt: Double
//    var editedAt: Date? // Timestamp indicating when the comment was last edited
//    var deletedAt: Date?
//    var messageDisapear: MessageDisapear = .off
//    var createdAt: Double
//
//    init(id: String, users: [User], messages: [Message], lastMessage: String, unreadCount: Int, lastMessageDate: Double, pinnedAt: Double, createdAt: Double) {
//        self.id = id
//        self.users = users
//        self.messages = messages
//        self.lastMessage = lastMessage
//        self.unreadCount = unreadCount
//        self.lastMessageDate = lastMessageDate
//        self.pinnedAt = pinnedAt
//        self.createdAt = createdAt
//    }
//
//    func encode(with coder: NSCoder) {
//        coder.encode(id, forKey: "id")
//        coder.encode(users, forKey: "users")
//        coder.encode(messages, forKey: "messages")
//        coder.encode(lastMessage, forKey: "lastMessage")
//        coder.encode(unreadCount, forKey: "unreadCount")
//        coder.encode(lastMessageDate, forKey: "lastMessageDate")
//        coder.encode(name, forKey: "name")
//        coder.encode(image, forKey: "image")
//        coder.encode(selected, forKey: "selected")
//        coder.encode(archived, forKey: "archived")
//        coder.encode(markUnRead, forKey: "markUnRead")
//        coder.encode(deleted, forKey: "deleted")
//        coder.encode(muted, forKey: "muted")
//        coder.encode(pinned, forKey: "pinned")
//        coder.encode(pinnedAt, forKey: "pinnedAt")
//        coder.encode(editedAt, forKey: "editedAt")
//        coder.encode(deletedAt, forKey: "deletedAt")
//        coder.encode(messageDisapear, forKey: "messageDisapear")
//        coder.encode(createdAt, forKey: "createdAt")
//    }
//
//    required convenience init?(coder: NSCoder) {
//        guard let id = coder.decodeObject(forKey: "id") as? String,
//              let users = coder.decodeObject(forKey: "users") as? [User],
//              let messages = coder.decodeObject(forKey: "messages") as? [Message],
//              let lastMessage = coder.decodeObject(forKey: "lastMessage") as? String,
//              let name = coder.decodeObject(forKey: "name") as? String?,
//              let image = coder.decodeObject(forKey: "image") as? PhotoMessage?,
//              let editedAt = coder.decodeObject(forKey: "editedAt") as? Date?,
//              let deletedAt = coder.decodeObject(forKey: "deletedAt") as? Date?,
//              let messageDisapear = coder.decodeObject(forKey: "messageDisapear") as? MessageDisapear
//        else { return nil }
//
//        let unreadCount = coder.decodeInteger(forKey: "unreadCount")
//        let lastMessageDate = coder.decodeDouble(forKey: "lastMessageDate")
//        let selected = coder.decodeBool(forKey: "selected")
//        let archived = coder.decodeBool(forKey: "archived")
//        let markUnRead = coder.decodeBool(forKey: "markUnRead")
//        let deleted = coder.decodeBool(forKey: "deleted")
//        let muted = coder.decodeBool(forKey: "muted")
//        let pinned = coder.decodeBool(forKey: "pinned")
//        let pinnedAt = coder.decodeDouble(forKey: "pinnedAt")
//        let createdAt = coder.decodeDouble(forKey: "createdAt")
//
//        self.init(
//            id: id,
//            users: users,
//            messages: messages,
//            lastMessage: lastMessage,
//            unreadCount: unreadCount,
//            lastMessageDate: lastMessageDate,
//            pinnedAt: pinnedAt,
//            createdAt: createdAt
//        )
//
//        self.name = name
//        self.image = image
//        self.selected = selected
//        self.archived = archived
//        self.markUnRead = markUnRead
//        self.deleted = deleted
//        self.muted = muted
//        self.pinned = pinned
//        self.editedAt = editedAt
//        self.deletedAt = deletedAt
//        self.messageDisapear = messageDisapear
//    }
//}
//
//
//class MessageClass: NSObject, NSCoding {
//
//    var id: String
//    var chatroom: ChatRoomClass
//    var sender: User
//    var textMessage: String?
//    var audioMessage: String?
//    var photoMessage: PhotoMessage?
//    var videoMessage: VideoMessage?
//    var fileMessage: String?
//    var locationMessage: Coordinates?
//    var replyMessage: MessageReply?
//    var reactions: [Reaction]?
//    var isSelected: Bool = false
//    var isSent: Bool = false
//    var isRead: Bool = false
//    var isEdited: Bool = false
//    var isDeleted: Bool = false
//    var sentAt: TimeInterval?
//    var readAt: TimeInterval?
//    var editedAt: TimeInterval?
//    var deletedAt: TimeInterval?
//    var mentions: [User]?
//    var coordinates: Coordinates?
//    var hashtags: [String]?
//    var isFlagged: Bool = false
//    var flaggedAt: TimeInterval?
//    var createdAt: TimeInterval
//
//    init(id: String, chatroom: ChatRoomClass, sender: User, createdAt: TimeInterval) {
//        self.id = id
//        self.chatroom = chatroom
//        self.sender = sender
//        self.createdAt = createdAt
//    }
//
//    func encode(with coder: NSCoder) {
//        coder.encode(id, forKey: "id")
//        coder.encode(chatroom, forKey: "chatroom")
//        coder.encode(sender, forKey: "sender")
//        coder.encode(textMessage, forKey: "textMessage")
//        coder.encode(audioMessage, forKey: "audioMessage")
//        coder.encode(photoMessage, forKey: "photoMessage")
//        coder.encode(videoMessage, forKey: "videoMessage")
//        coder.encode(fileMessage, forKey: "fileMessage")
//        coder.encode(locationMessage, forKey: "locationMessage")
//        coder.encode(replyMessage, forKey: "replyMessage")
//        coder.encode(reactions, forKey: "reactions")
//        coder.encode(isSelected, forKey: "isSelected")
//        coder.encode(isSent, forKey: "isSent")
//        coder.encode(isRead, forKey: "isRead")
//        coder.encode(isEdited, forKey: "isEdited")
//        coder.encode(isDeleted, forKey: "isDeleted")
//        coder.encode(sentAt, forKey: "sentAt")
//        coder.encode(readAt, forKey: "readAt")
//        coder.encode(editedAt, forKey: "editedAt")
//        coder.encode(deletedAt, forKey: "deletedAt")
//        coder.encode(mentions, forKey: "mentions")
//        coder.encode(coordinates, forKey: "coordinates")
//        coder.encode(hashtags, forKey: "hashtags")
//        coder.encode(isFlagged, forKey: "isFlagged")
//        coder.encode(flaggedAt, forKey: "flaggedAt")
//        coder.encode(createdAt, forKey: "createdAt")
//    }
//
//    required convenience init?(coder: NSCoder) {
//        guard let id = coder.decodeObject(forKey: "id") as? String,
//              let chatroom = coder.decodeObject(forKey: "chatroom") as? ChatRoomClass,
//              let sender = coder.decodeObject(forKey: "sender") as? User
//        else { return nil }
//
//        let createdAt = coder.decodeDouble(forKey: "createdAt")
//
//        self.init(
//            id: id,
//            chatroom: chatroom,
//            sender: sender,
//            createdAt: createdAt
//        )
//
//        textMessage = coder.decodeObject(forKey: "textMessage") as? String
//        audioMessage = coder.decodeObject(forKey: "audioMessage") as? String
//        photoMessage = coder.decodeObject(forKey: "photoMessage") as? PhotoMessage
//        videoMessage = coder.decodeObject(forKey: "videoMessage") as? VideoMessage
//        fileMessage = coder.decodeObject(forKey: "fileMessage") as? String
//        locationMessage = coder.decodeObject(forKey: "locationMessage") as? Coordinates
//        replyMessage = coder.decodeObject(forKey: "replyMessage") as? MessageReply
//        reactions = coder.decodeObject(forKey: "reactions") as? [Reaction]
//        isSelected = coder.decodeBool(forKey: "isSelected")
//        isSent = coder.decodeBool(forKey: "isSent")
//        isRead = coder.decodeBool(forKey: "isRead")
//        isEdited = coder.decodeBool(forKey: "isEdited")
//        isDeleted = coder.decodeBool(forKey: "isDeleted")
//        sentAt = coder.decodeObject(forKey: "sentAt") as? TimeInterval
//        readAt = coder.decodeObject(forKey: "readAt") as? TimeInterval
//        editedAt = coder.decodeObject(forKey: "editedAt") as? TimeInterval
//        deletedAt = coder.decodeObject(forKey: "deletedAt") as? TimeInterval
//        mentions = coder.decodeObject(forKey: "mentions") as? [User]
//        coordinates = coder.decodeObject(forKey: "coordinates") as? Coordinates
//        hashtags = coder.decodeObject(forKey: "hashtags") as? [String]
//        isFlagged = coder.decodeBool(forKey: "isFlagged")
//        flaggedAt = coder.decodeObject(forKey: "flaggedAt") as? TimeInterval
//    }
//
//    func replacementObject(forKeyedArchiver archiver: NSKeyedArchiver) -> Any? {
//        return nil
//    }
//}
//
//
//
//

