//
//  Message.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 12.7.2023.
//

import UIKit


enum MessageDisapear: Codable {
    case off
    case twenty4hours
    case sevendays
    case thirtydays
}

//enum MessageType { <- not included
//    case text(String)
//    case audio(String)
//    case photo(String)
//    case video(String)
//    case file(String)
//    case location(Coordinates)
//    case emoji(String)
//    case sticker(String)
//    case replyWithText(repliedToText: String, repliedToUserId: String, repliedToMessageId: String)
//    case replyWithAudio(repliedToAudio: String, repliedToUserId: String, repliedToMessageId: String)
//    case replyWithPhoto(repliedToPhoto: String, repliedToUserId: String, repliedToMessageId: String)
//    case replyWithVideo(repliedToVideo: String, repliedToUserId: String, repliedToMessageId: String)
//    case replyWithEmoji(repliedToEmoji: String, repliedToUserId: String, repliedToMessageId: String)
//    case replyWithStikcer(repliedToStiker: String, repliedToUserId: String, repliedToMessageId: String)
//    case replyWithLocation(repliedToLocation: Coordinates, repliedToUserId: String, repliedToMessageId: String)
//    case audioWithText(audio: String, text: String)
//    case photoWithText(photo: String, text: String)
//    case videoWithText(video: String, text: String)
//    case fileWithText(file: String, text: String)
//    case locationWithText(Coordinates: Coordinates, text: String)
//}

enum messageEnum: Codable {
    case imageWithText(photoObject: PhotoMessage, text: String)
    case image(photoObject: PhotoMessage)
    case videoWithImage(videoObject:VideoMessage, text: String)
    case video(videoObject: VideoMessage)
    case locationWithText(coordinates: Coordinates, text: String)
    case location(coordinates: Coordinates)
    //case pollMessage <- still uncreated
    case voice(voice: VoiceMessage)
    case textMessage(text: String)
}

struct MessageReply: Codable {
    var repliedToUserId: String
    var repliedToValue: messageEnum
}


struct ImageSizeInPX: Codable {
    var width: Double
    var height: Double
}


struct VoiceMessage: Codable {
    var voiceUrl: String
}

struct PhotoMessage: Codable{
    var photoUrl: String
    var placeHolderUrl: String
    var photoSizeInPX: ImageSizeInPX
    var photoSizeInBytes: String
    var savedOnDeviceId: String?
}

struct VideoMessage: Codable {
    var videoUrl: String
    var videoImageUrl: String
    var videoPlaceHolderUrl: String
    var photoSizeInPX: ImageSizeInPX
    var videoSizeInBytes: String
    var savedOnDeviceId: String?
}




struct Message: MenuIdentifiable, Codable, Equatable {
    var id: String
    var chatroomId: String
    var senderId: String // user id
    //var receiver: User
//    var messageType: MessageType? <- not included
    var textMessage: String?
    var audioMessage: String?
    var photoMessage: PhotoMessage?
    var videoMessage: VideoMessage?
    var fileMessage: String?
    var locationMessage: Coordinates?
    var replyMessage: MessageReply?
    var reactions: [Reaction]? // reaction ids
    var isSelected: Bool = false
    var isSent: Bool = false
    var isRead: Bool = false
    var isEdited: Bool = false
    var isDeleted: Bool = false
    var sentAt: TimeInterval?
    var readAt: TimeInterval?
    var editedAt: TimeInterval?
    var deletedAt: TimeInterval?
    var mentions: [String]? // user ids
    var coordinates: Coordinates?
    var hashtags: [String]?
    var isFlagged: Bool = false
    var flaggedAt: TimeInterval?
    var createdAt: TimeInterval
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
        // You can choose to compare other properties here if needed
    }

}



class MessageWrapper: NSObject, NSCoding {
    var message: Message

    init(message: Message) {
        self.message = message
    }

    // MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(message, forKey: "message")
    }

    required convenience init?(coder: NSCoder) {
        guard let message = coder.decodeObject(forKey: "message") as? Message else {
            return nil
        }
        self.init(message: message)
    }

    func replacementObject(forKeyedArchiver archiver: NSKeyedArchiver) -> Any? {
        return nil
    }
}





//class MessageWrapper: NSObject, NSCoding {
////    static var supportsSecureCoding: Bool {
////           return true
////        }
//
//    var message: Message
//
//    init(message: Message) {
//        self.message = message
//    }
//
//    // MARK: - NSCoding
//    func encode(with coder: NSCoder) {
//        coder.encode(message, forKey: "message")
//    }
//
//    required convenience init?(coder: NSCoder) {
//        guard let message = coder.decodeObject(forKey: "message") as? Message else {
//            return nil
//        }
//        self.init(message: message)
//    }
//}


//struct Message: Codable, NSCoding {
//    var id: String
//    var chatroom: ChatRoom
//    var sender: User
//    //var receiver: User
//    // var messageType: MessageType? <- not included
//    var textMessage: String?
//    var audioMessage: String?
//    var photoMessage: PhotoMessage?
//    var videoMessage: VideoMessage?
//    var fileMessage: String?
//    var locationMessage: Coordinates?
//    var replyMessage: messageRyply?
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
//    // MARK: - NSCoding
//    func encode(with coder: NSCoder) {
//        // Encode your properties using the appropriate keys
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
//    init?(coder: NSCoder) {
//        // Decode your properties using the appropriate keys
//        guard let id = coder.decodeObject(forKey: "id") as? String,
//              let chatroom = coder.decodeObject(forKey: "chatroom") as? ChatRoom,
//              let sender = coder.decodeObject(forKey: "sender") as? User
//        else {
//            return nil
//        }
//
//        self.id = id
//        self.chatroom = chatroom
//        self.sender = sender
//        self.textMessage = coder.decodeObject(forKey: "textMessage") as? String
//        self.audioMessage = coder.decodeObject(forKey: "audioMessage") as? String
//        self.photoMessage = coder.decodeObject(forKey: "photoMessage") as? PhotoMessage
//        self.videoMessage = coder.decodeObject(forKey: "videoMessage") as? VideoMessage
//        self.fileMessage = coder.decodeObject(forKey: "fileMessage") as? String
//        self.locationMessage = coder.decodeObject(forKey: "locationMessage") as? Coordinates
//        self.replyMessage = coder.decodeObject(forKey: "replyMessage") as? messageRyply
//        self.reactions = coder.decodeObject(forKey: "reactions") as? [Reaction]
//        self.isSelected = coder.decodeBool(forKey: "isSelected")
//        self.isSent = coder.decodeBool(forKey: "isSent")
//        self.isRead = coder.decodeBool(forKey: "isRead")
//        self.isEdited = coder.decodeBool(forKey: "isEdited")
//        self.isDeleted = coder.decodeBool(forKey: "isDeleted")
//        self.sentAt = coder.decodeObject(forKey: "sentAt") as? TimeInterval
//        self.readAt = coder.decodeObject(forKey: "readAt") as? TimeInterval
//        self.editedAt = coder.decodeObject(forKey: "editedAt") as? TimeInterval
//        self.deletedAt = coder.decodeObject(forKey: "deletedAt") as? TimeInterval
//        self.mentions = coder.decodeObject(forKey: "mentions") as? [User]
//        self.coordinates = coder.decodeObject(forKey: "coordinates") as? Coordinates
//        self.hashtags = coder.decodeObject(forKey: "hashtags") as? [String]
//        self.isFlagged = coder.decodeBool(forKey: "isFlagged")
//        self.flaggedAt = coder.decodeObject(forKey: "flaggedAt") as? TimeInterval
//        self.createdAt = coder.decodeObject(forKey: "createdAt") as? TimeInterval ?? 0.0
//    }
//}
