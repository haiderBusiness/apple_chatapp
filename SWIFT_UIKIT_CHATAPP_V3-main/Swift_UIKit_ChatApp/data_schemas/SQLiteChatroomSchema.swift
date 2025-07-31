//
//  SQLiteChatroomSchema.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 15.8.2023.
//

import Foundation
import SQLite

typealias Expression = SQLite.Expression

struct SQLiteChatroomSchema {
    static let id = Expression<String>("id")
    static let usersIds = Expression<Data>("usersIds")
    static let messagesIds = Expression<Data>("messagesIds")
    static let lastMessage = Expression<String>("lastMessage")
    static let unreadCount = Expression<Int>("unreadCount")
    static let lastMessageDate = Expression<Double>("lastMessageDate")
    static let name = Expression<String?>("name")
    static let image = Expression<Data>("image")
    static let selected = Expression<Bool>("selected")
    static let archived = Expression<Bool>("archived")
    static let markUnRead = Expression<Bool>("markUnRead")
    static let deleted = Expression<Bool>("deleted")
    static let muted = Expression<Bool>("muted")
    static let pinned = Expression<Bool>("pinned")
    static let pinnedAt = Expression<TimeInterval>("pinnedAt")
    static let editedAt = Expression<TimeInterval?>("editedAt")
    static let deletedAt = Expression<TimeInterval?>("deletedAt")
    static let messageDisappear = Expression<Data>("messageDisappear")
    static let createdAt = Expression<TimeInterval>("createdAt")
}
