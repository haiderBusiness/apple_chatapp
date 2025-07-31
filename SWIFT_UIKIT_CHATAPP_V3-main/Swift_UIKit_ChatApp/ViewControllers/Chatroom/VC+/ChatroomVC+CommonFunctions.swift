//
//  ChatroomVC+CommonFunctions.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 6.10.2023.
//

import UIKit

extension ChatroomVC {
    
        func deleteMessage(message: Message, indexPath: IndexPath, deleteForAll: Bool = false) {
    
            deleteMessagesInDatabaseOnDisk(fileName: self.fileName, folderName: self.messagesDiskPath, messagesToDelete: [message], tableName: DataStore.shared.messagesTable)
        
            if deleteForAll {
                // TODO: remove message from all users
            }
            
            let sectionTitle  = sections[indexPath.section]
            
            var deleteSection = false
    
            if var sectionMessages = sectionMessages[sectionTitle] {
    
                self.messages.removeAll(where: {$0.id == message.id})
                sectionMessages.removeAll(where: {$0.id == message.id})
                if sectionMessages.count > 0 {
                    self.sectionMessages[sectionTitle] = sectionMessages
                } else {
                    self.sectionMessages.removeValue(forKey: sectionTitle)
                    self.sections.removeAll(where: {$0 == sectionTitle})
                    deleteSection = true
                }
    
                if let fileName = message.audioMessage {
                    let appName = DataStore.shared.appName
                    let diskPath = appName + "/chats/\(message.chatroomId)/audios"
                    removeFileOrFolderFromDisk(fileName: fileName, folderName: diskPath)
                }
    //            self.sectionMessages[sectionTitle] = sectionMessages
            }
    
    //ª
            self.tableView.beginUpdates()
            if deleteSection {
                let indexSet = IndexSet(integer: indexPath.section)
                tableView.deleteSections(indexSet, with: .none)
            }
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
    
        }
}








// MARK: ACTION SHEET
extension ChatroomVC {
    
//    func showActionSheet(indexPath: IndexPath) {
//
//        let userId = chatrooms[indexPath.row].usersIds.first(where: {$0 != DataStore.shared.user.id})
//        let user = DataStore.shared.users.first(where: {$0.id == userId})
//        var name: String!
//
//        if let user_first_name = user?.firstName {
//            name = user_first_name
//        }
//
//        let alertController = CustomAllertController(title: Language.delete_chat_with + " " + name, message: nil, preferredStyle: .actionSheet)
//
//        if let imageData = user?.avatar {
//
////                    let placeHolderUrl = imageData.placeHolderUrl
//                    let imageUrl = imageData.photoUrl
////                    let photoDeviceId = imageData.savedOnDeviceId
////
////                    var fileName = placeHolderUrl.replacingOccurrences(of: "https://", with: "")
////                    fileName = fileName.replacingOccurrences(of: "http://", with: "")
//
////
////                    if deviceId == photoDeviceId {
////                        chatImageView.LoadSaveDisplayImage(originalImageUrl: imageUrl, placeHolderUrl: placeHolderUrl , savePlaceHolder: false,folderName: diskPath)
////                    } else {
////                        chatImageView.LoadSaveDisplayImage(originalImageUrl: imageUrl, placeHolderUrl: placeHolderUrl , savePlaceHolder: true,folderName: diskPath)
////                    }
////
////                } else {
////                        chatImageView.image = Empty.image
////                }
//            alertController.setTitleImage(image: nil, imageUrl: imageUrl)
//        }
//
//
//        let action1 = UIAlertAction(title: Language.delete_chat, style: .destructive) { _ in
//            self.tableView.beginUpdates()
//            // DataStore.shared.chatrooms.remove(at: indexPath.row)
//            let itemToDelete = self.chatrooms.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .fade)
//            self.tableView.endUpdates()
//            deleteChatroomsInDatabaseOnDisk(fileName: self.fileName, folderName: self.diskPath, chatroomsToUpdate: [itemToDelete], tableName: DataStore.shared.chatsTable)
//        }
//        let action2 = UIAlertAction(title: Language.archive_chat, style: .default) { _ in
//            self.addToArchived(indexPath: indexPath)
//
//            // Handle Action 2
//        }
//        let cancelAction = UIAlertAction(title: Language.cancel, style: .cancel) { _ in
//            // Handle Cancel action
//        }
//
//        alertController.addAction(action1)
//        alertController.addAction(action2)
//        alertController.addAction(cancelAction)
//
//        if let popoverPresentationController = alertController.popoverPresentationController {
//            // Set the source view or bar button item to anchor the action sheet on iPad
//            popoverPresentationController.sourceView = view // Replace "view" with your desired source view
//            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
//            popoverPresentationController.permittedArrowDirections = [] // Remove the arrow on iPad
//        }
//
//        present(alertController, animated: true, completion: nil)
//    }

}
