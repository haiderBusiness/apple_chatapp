//
//  reducers.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 5.6.2023.
//

import UIKit

struct AppState {
    var chatrooms: [ChatRoom];
    var archivedChatrooms: [ChatRoom];
}

func appReducer(state: inout AppState, action: AppAction) {
    switch action {
        // Other cases...
    case .updateChatrooms(let newData):
        state.chatrooms = newData
    case .updateArchivedChatrooms(let newData):
        state.archivedChatrooms = newData
    }
}
