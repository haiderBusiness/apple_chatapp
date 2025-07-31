//
//  Chat_schema.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 31.5.2023.
//

import UIKit

struct Empty {
    static let image = UIImage(systemName: "photo.fill")
}

struct IconStrings {
    static let message_read_unread = "message.circle"
    static let archive_fill = "archivebox.fill"
    static let trash_fill = "trash.fill"
    static let unmute_speaker_fill = "speaker.wave.2.fill"
    static let mute_speaker_fill = "speaker.slash.fill"
    static let unpin_fill = "pin.slash.fill"
    static let pin_fill = "pin.fill"
    
    static let message_read = "message"
    static let message_unread = "message"
    static let archive = "archivebox"
    static let trash = "trash"
    static let unmute_speaker = "speaker.wave.2"
    static let mute_speaker = "speaker.slash"
    static let unpin = "pin.slash"
    static let pin = "pin"
    }


enum PrivacyType: Codable {
    case `public`
    case `private`
    case friendsOnly
}




enum Reason: Codable {
    case IjustDontLikeIt
    case itsASpam
    case NudityOrSexualActivity
    case HateSpeechOrSymbols
}




struct ids {
    static let chat_room_cell = "chat_room_cell";
    static let table_header = "table_header";
    static let archived_table_header = "archived_table_header";
    static let add_new_chat_cell = "add_new_chat_cell";
    static let add_new_chat_table_header = "add_new_chat_table_header";
}

struct Coordinates: Codable {
    var latitude: Double
    var longitude: Double
}


struct Post {
    var id: UUID = UUID()
    var poster: User
    var photo: String?
    var video: String?
    var reactions: [Reaction]?
    var comments: [Comment]?
    var isPosted: Bool = false
    var isHidden: Bool = false
    var isEdited: Bool = false
    var isDeleted: Bool = false
    var isFlagged: Bool = false  // Indicates if the comment has been flagged as inappropriate
    var mentions: [User]?
    var coordinates: Coordinates?
    var hashtags: [String]?
    var caption: String?
    var location: String?
    var sharesCount:Int = 0
    var viewsCount:Int = 0
    var isSaved: Bool = false
    var taggedUsers: [User]?
    var privacy: PrivacyType = .public
    var link: String = "https//must_have_a_link.com"
    var externalLinks: [String]?
    var reports: [Report]?
    var flaggedAt: Date?  // Timestamp indicating when the comment was flagged
    var editedAt: Date?  // Timestamp indicating when the comment was last edited
    var deletedAt: Date?
    var createdAt: Date
}



struct Comment {
    var id: UUID = UUID()
    var commenter: User
    var post: Post
    var textComment: String
    var reactions: [Reaction]?
    var isEdited: Bool = false
    var isFlagged: Bool = false // Indicates if the comment has been flagged as inappropriate
    var isDeleted: Bool = false
    var mentions: [User]?
    var hashtags: [String]?
    var coordinates: Coordinates?
    var location: String?
    var link: String = "https://must_have_a_link.com"
    var externalLinks: [String]?
    var reports: [Report]?
    var editedAt: Date?  // Timestamp indicating when the comment was last edited
    var deletedAt: Date?
    var createdAt: Date
}

struct Report {
    var id = UUID()
    var comment: Comment?
    var post: Post?
    var user: User?
    var reason: Reason?
    var createdAt: Date
}





