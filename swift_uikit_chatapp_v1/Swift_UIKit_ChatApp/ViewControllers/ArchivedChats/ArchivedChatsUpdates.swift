//
//  ArchivedChatsUpdates.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 27.6.2023.
//

import UIKit

// update chat room
extension ArchivedChatsVC: UpdateChatroom {
    func updatedChatroom(chatroom: ChatRoom) {
        let foundIndex = self.archivedChatrooms.firstIndex(where: {$0.id == chatroom.id})
        if let index = foundIndex {
            self.archivedChatrooms[index] = chatroom
            let indexPath = IndexPath(row: index, section: 0)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            self.delegate?.updateArchivedChats(updatedChatrooms: self.chatrooms, updatedArchivedChatrooms: self.archivedChatrooms)
        }
    }
}
