//
//  Reaction.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 12.7.2023.
//

import Foundation


struct Reaction: Codable {
    var id: String = "\(UUID())"
    var reactor: User
    var message: Message
    var emoji: String
    var count: Int
    var createdAt: Date
}
