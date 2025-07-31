//
//  ChatsMenuContext.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 19.6.2023.
//

import UIKit

private let imageIconConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .medium)

extension ChatsVC {
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let row = self.chatrooms[indexPath.row]
    
        
        let archiveOption : UIAction = {
            let title = Language.archive
            let option = UIAction(
                title: title,
                image: UIImage(systemName: IconStrings.archive, withConfiguration: imageIconConfiguration)
            ) { _ in
                // Handle off action
                self.addToArchived(indexPath: indexPath);
            }
            return option
        }()
        
        let readUnReadOption : UIAction = {
            let title = row.unreadCount > 0 ? Language.mark_as_read : (row.markUnRead ? Language.mark_as_read : Language.mark_as_unread)
            let option = UIAction(title: title, image: UIImage(systemName: IconStrings.message_read, withConfiguration: imageIconConfiguration)) { _ in
                // Handle off action
                self.markUnread(indexPath: indexPath);
            }
            return option
        }()
        
        
        
        let pinUnpinOption : UIAction = {
            let title = row.pinned ? Language.unpin : Language.pin
            let option = UIAction(title: title,image: UIImage(systemName: row.pinned ? IconStrings.unpin : IconStrings.pin, withConfiguration: imageIconConfiguration)) { _ in
                // Handle off action
                self.pinChat(indexPath: indexPath);
            }
            return option
        }()
        
        let muteUnMuteOption : UIAction = {
            let title = row.muted ? Language.unmute : Language.mute
            let option = UIAction(title: title, image: UIImage(systemName: row.muted ? IconStrings.unmute_speaker : IconStrings.mute_speaker, withConfiguration: imageIconConfiguration)) { _ in
                // Handle off action
                self.muteChat(indexPath: indexPath)
            }
            return option
        }()
        
        let DeleteExitGroupOption : UIAction = {
            let title = Language.delete
            let option = UIAction(
                title: title,
                image: UIImage(systemName: IconStrings.trash, withConfiguration: imageIconConfiguration),
                attributes: .destructive
            ) { _ in
                // Handle off action
                self.showActionSheet(indexPath: indexPath);
            }
            return option
        }()
        


            
            
        let menu = UIMenu(title: "", children: [archiveOption,readUnReadOption, pinUnpinOption, muteUnMuteOption, DeleteExitGroupOption])

       
        let configuration =  UIContextMenuConfiguration(identifier: row.menuID, previewProvider: {
            
            let chatroomVC = ChatroomVC()
            
            let authUser = DataStore.shared.user
            //            print("user found: ", authUser?.firstName)
            
            let chatroom = row
            
            let userId = chatroom.usersIds.first(where: {$0 != authUser?.id})
            let user = DataStore.shared.users.first(where: {$0.id == userId})
            
            if let user = user {
                chatroomVC.receivedUser = user
            }
            chatroomVC.chatroom = chatroom
            
    
            
            let navController = UINavigationController(rootViewController: chatroomVC)
            let backButton = UIBarButtonItem(title: Language.back, style: .plain, target: nil, action: nil)
            self.navigationItem.backBarButtonItem = backButton // Set back button for the previous view controller
            
            return navController
        
        }, actionProvider: { _ in
            return menu
        })
        
        return configuration
    }
    

     func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
          
         guard let chatroom = chatrooms.item(for: configuration) else {
             return
         }
         
         let chatroomVC = ChatroomVC()
         
         let authUser = DataStore.shared.user
         //            print("user found: ", authUser?.firstName)
         
         
         let userId = chatroom.usersIds.first(where: {$0 != authUser?.id})
         let user = DataStore.shared.users.first(where: {$0.id == userId})
         
        
         chatroomVC.chatroom = chatroom
         
//            print("user found: ", user?.firstName)
         
         guard let user = user else {
             return
         }
         
         chatroomVC.receivedUser = user
         
         chatroomVC.updateCurrentChatroom = self
         
         animator.addCompletion { [weak self] in
             
             guard let self = self else {
                 return
             }
             
             self.show(chatroomVC, sender: self)
         }
        
     }
    
 
    
    
    
}


