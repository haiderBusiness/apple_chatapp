//
//  BottomSheetOptions.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 4.7.2023.
//

import UIKit

extension ChatroomVC {
    
    func actionSheet() {
 
        let alertController = UIAlertController(title: Language.delete_chat_with, message: nil, preferredStyle: .actionSheet)
        

        let action1 = UIAlertAction(title: Language.photos, style: .default) { _ in
            //self.tableView.beginUpdates()
            // DataStore.shared.chatrooms.remove(at: indexPat)
        }
        let action2 = UIAlertAction(title: Language.file, style: .default) { _ in
            //self.addToArchived(indexPath: indexPath)
            // Handle Action 2
        }
        
        let action3 = UIAlertAction(title: Language.file, style: .default) { _ in
            //self.addToArchived(indexPath: indexPath)
            // Handle Action 2
        }
        let action4 = UIAlertAction(title: Language.file, style: .default) { _ in
            //self.addToArchived(indexPath: indexPath)
            // Handle Action 2
        }
        let cancelAction = UIAlertAction(title: Language.cancel, style: .cancel) { _ in
            // Handle Cancel action
        }

        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        alertController.addAction(action4)
        alertController.addAction(cancelAction)

        if let popoverPresentationController = alertController.popoverPresentationController {
            // Set the source view or bar button item to anchor the action sheet on iPad
            popoverPresentationController.sourceView = view // Replace "view" with your desired source view
            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = [] // Remove the arrow on iPad
        }

        present(alertController, animated: true, completion: nil)
    }

}
