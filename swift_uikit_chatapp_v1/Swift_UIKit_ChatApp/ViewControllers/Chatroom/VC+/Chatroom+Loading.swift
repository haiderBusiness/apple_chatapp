//
//  ChatroomVC+Loading.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 14.8.2023.
//

import UIKit

extension ChatroomVC {
    
    func configureNetwork() {
        
            switch loadingStatus {
            case .waitingForNetwork:
                lastSeenLabel.text = Language.waiting_for_network + "..."
            case .connecting:
                lastSeenLabel.text = Language.connecting + "..."
                
            case .updating:
                lastSeenLabel.text = Language.updating + "..."
            case .working:
                if let _ = self.chatroom?.name, let unwrapedChatroom = self.chatroom {
                    let number = unwrapedChatroom.usersIds.count
                    self.lastSeenLabel.text = String(number) + " " + Language.members
                }
                else if let lastSeenAt = self.receivedUser?.lastOnlineAt {
                    self.lastSeenLabel.text = getLastSeenDate(received_date: lastSeenAt)
                }
            }
        
            network.whenReachable = { _ in
                // after recieving network signal display connecting
//                print("test reachable")
//                guard let self = self else {return}
                // display waiting for network when there is no network
                if let _ = self.chatroom?.name, let unwrapedChatroom = self.chatroom {
                    let number = unwrapedChatroom.usersIds.count
                    self.lastSeenLabel.text = String(number) + " " + Language.members
                }
                else if let lastSeenAt = self.receivedUser?.lastOnlineAt {
                    self.lastSeenLabel.text = getLastSeenDate(received_date: lastSeenAt)
                }
                
            }
            
            // if device goes offline
            network.whenUnreachable = { _ in
//                print("test unreachable")
//                guard let self = self else {return}
                self.lastSeenLabel.text = Language.waiting_for_network + "..."
            }
    }

}
