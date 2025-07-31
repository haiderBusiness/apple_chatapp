//
//  ChatroomVC+MenuContext.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 18.9.2023.
//

//import UIKit
//
//private let imageIconConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .medium)
//
//private let reactionsView = UIView()
//private let testView = UIView()

//extension ChatroomVC {
//
//
//
//    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
//        guard let cell = interaction.view as? CTRMAudioMessageCell, let indexPath = tableView.indexPath(for: cell) else {
//                   return nil
//               }
//
//        cell.backgroundColor = .clear
//        cell.setHighlighted(false, animated: false)
//        cell.selectionStyle = .none
//        let sectionTitle = sections[indexPath.section]
//
//        guard let messagesInSection = sectionMessages[sectionTitle] else { return nil }
//
//        let row = messagesInSection[indexPath.row]
//
//
//
//        let archiveOption : UIAction = {
//            let title = Language.archive
//            let option = UIAction(
//                title: title,
//                image: UIImage(systemName: IconStrings.archive, withConfiguration: imageIconConfiguration)
//            ) { _ in
//                // Handle off action
////                self.addToArchived(indexPath: indexPath);
//            }
//            return option
//        }()
//
//        let readUnReadOption : UIAction = {
//            let title = Language.mark_as_read
//            let option = UIAction(title: title, image: UIImage(systemName: IconStrings.message_read, withConfiguration: imageIconConfiguration)) { _ in
//                // Handle off action
////                self.markUnread(indexPath: indexPath);
//            }
//            return option
//        }()
//
//
//
//        let pinUnpinOption : UIAction = {
//            let title = Language.unpin
//            let option = UIAction(title: title,image: UIImage(systemName: IconStrings.unpin, withConfiguration: imageIconConfiguration)) { _ in
//                // Handle off action
////                self.pinChat(indexPath: indexPath);
//            }
//            return option
//        }()
//
//        let muteUnMuteOption : UIAction = {
//            let title = Language.unmute
//            let option = UIAction(title: title, image: UIImage(systemName: IconStrings.unmute_speaker, withConfiguration: imageIconConfiguration)) { _ in
//                // Handle off action
////                self.muteChat(indexPath: indexPath)
//            }
//            return option
//        }()
//
//        let DeleteExitGroupOption : UIAction = {
//            let title = Language.delete
//            let option = UIAction(
//                title: title,
//                image: UIImage(systemName: IconStrings.trash, withConfiguration: imageIconConfiguration),
//                attributes: .destructive
//            ) { _ in
//                // Handle off action
////                self.showActionSheet(indexPath: indexPath);
//                self.deleteMessage(message: row, indexPath: indexPath)
//            }
//            return option
//        }()
//
//
//
//
//
//        let menu = UIMenu(title: "", children: [archiveOption,readUnReadOption, pinUnpinOption, muteUnMuteOption, DeleteExitGroupOption])
//
//        let identifierString = "\(indexPath.section)-\(indexPath.row)"
//        let configuration =  UIContextMenuConfiguration(identifier: identifierString as NSString, previewProvider: {nil}, actionProvider: { _ in
//
//
//            return menu
//        })
//
//        return configuration
//    }
//
//
//
//    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
//
//        let sectionTitle = sections[indexPath.section]
//
//        guard let messagesInSection = sectionMessages[sectionTitle] else { return nil }
//
//        let message = messagesInSection[indexPath.row]
//
//
//        let archiveOption : UIAction = {
//            let title = Language.archive
//            let option = UIAction(
//                title: title,
//                image: UIImage(systemName: IconStrings.archive, withConfiguration: imageIconConfiguration)
//            ) { _ in
//                // Handle off action
////                self.addToArchived(indexPath: indexPath);
//            }
//            return option
//        }()
//
//        let readUnReadOption : UIAction = {
//            let title = Language.mark_as_read
//            let option = UIAction(title: title, image: UIImage(systemName: IconStrings.message_read, withConfiguration: imageIconConfiguration)) { _ in
//                // Handle off action
////                self.markUnread(indexPath: indexPath);
//            }
//            return option
//        }()
//
//
//
//        let pinUnpinOption : UIAction = {
//            let title = Language.unpin
//            let option = UIAction(title: title,image: UIImage(systemName: IconStrings.unpin, withConfiguration: imageIconConfiguration)) { _ in
//                // Handle off action
////                self.pinChat(indexPath: indexPath);
//            }
//            return option
//        }()
//
//        let muteUnMuteOption : UIAction = {
//            let title = Language.unmute
//            let option = UIAction(title: title, image: UIImage(systemName: IconStrings.unmute_speaker, withConfiguration: imageIconConfiguration)) { _ in
//                // Handle off action
////                self.muteChat(indexPath: indexPath)
//            }
//            return option
//        }()
//
//        let DeleteExitGroupOption : UIAction = {
//            let title = Language.delete
//            let option = UIAction(
//                title: title,
//                image: UIImage(systemName: IconStrings.trash, withConfiguration: imageIconConfiguration),
//                attributes: .destructive
//            ) { _ in
//                // Handle off action
////                self.showActionSheet(indexPath: indexPath);
//                self.deleteMessage(message: message, indexPath: indexPath)
//            }
//            return option
//        }()
//
//
//
//
//        // to add sub menu or anothor menu inside the main menu
////        let subMenu = UIMenu(title: "Sub menu", children: [archiveOption,readUnReadOption, pinUnpinOption, muteUnMuteOption, DeleteExitGroupOption])
//
//
//
//
//
//
//        let menu = UIMenu(title: "",
//                          children: [
//                            archiveOption,
//                            readUnReadOption,
//                            pinUnpinOption,
//                            muteUnMuteOption,
//                            DeleteExitGroupOption
////                            ,subMenu,
//                          ])
//
//
//        let configuration =  UIContextMenuConfiguration(identifier: indexPath as NSCopying, previewProvider: {
////            guard let cell = cell else {
////                return nil
////            }
//
//
//
//
//            let reactionsWithCellClass = ChatroomContextReactions()
//            let navController = UINavigationController(rootViewController: reactionsWithCellClass)
//
//
//            func basicTask(snapshot: UIView, snapshotWidth: CGFloat, snapshotHeight: CGFloat ) {
//                reactionsWithCellClass.view.backgroundColor = .clear
//
////                cell.configure(message: message, isSelecting: false)
//
//
//                    snapshot.isHidden = false
//                    snapshot.layer.cornerRadius = 10
//                    snapshot.layer.masksToBounds = true
//                    snapshot.translatesAutoresizingMaskIntoConstraints = false
//
////                    snapshot.backgroundColor = .yellow
//                    reactionsWithCellClass.view.addSubview(snapshot)
//
////                    reactionsWithCellClass.view.backgroundColor = .red
//
//                    NSLayoutConstraint.activate([
////                        snapshot.leadingAnchor.constraint(equalTo: reactionsWithCellClass.view.leadingAnchor),
////                        snapshot.trailingAnchor.constraint(equalTo: reactionsWithCellClass.view.trailingAnchor),
//                        snapshot.trailingAnchor.constraint(equalTo: reactionsWithCellClass.view.trailingAnchor, constant: 0),
////                        snapshot.leadingAnchor.constraint(equalTo: reactionsWithCellClass.view.leadingAnchor, constant: 0),
//                        snapshot.widthAnchor.constraint(equalToConstant: CGFloat(snapshotWidth)),
//                        snapshot.heightAnchor.constraint(equalToConstant: CGFloat(snapshotHeight)),
////                        snapshot.topAnchor.constraint(equalTo: reactionsWithCellClass.view.topAnchor),
//                        snapshot.topAnchor.constraint(equalTo: reactionsWithCellClass.reactionsView.bottomAnchor, constant: 10),
////                        snapshot.centerYAnchor.constraint(equalTo: reactionsWithCellClass.view.centerYAnchor),
////                        snapshot.bottomAnchor.constraint(equalTo: reactionsWithCellClass.view.bottomAnchor),
//
//                    ])
//
//                    reactionsWithCellClass.view.layoutIfNeeded()
//
//
//                    navController.preferredContentSize = CGSize(width: snapshotWidth, height: snapshotHeight + 5)
////                    navController.view.transform = CGAffineTransform(translationX: 600, y: 400)
////                    reactionsWithCellClass.view.transform = CGAffineTransform(translationX: 600, y: 400)
//                    navController.view.backgroundColor = .clear
////                    navController.view.layer.shadowOpacity = 0
//
////                    reactionsWithCellClass.view.frame.size.width = CGFloat(5)
////                    reactionsWithCellClass.view.frame.size.height = CGFloat(5)
////                    reactionsWithCellClass.shadowPath = UIBezierPath()
//
//            }
//
//
//
//            if let _ = message.videoMessage, let _ = message.textMessage { // video with text
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMPhotoWithTextCell
//                reactionsWithCellClass.view.addSubview(cell)
//            }
//            else if let _ = message.videoMessage { // video only
//
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMOnlyPhotoMessageCell
//                reactionsWithCellClass.view.addSubview(cell)
//            }
//            else if let _ = message.photoMessage, let _ = message.textMessage { // photo with text
//
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMPhotoWithTextCell
//                reactionsWithCellClass.view.addSubview(cell)
//            }
//            else if let _ = message.photoMessage { // only photo
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMOnlyPhotoMessageCell
//                reactionsWithCellClass.view.addSubview(cell)
//            }
//            else if let _ = message.locationMessage, let _ = message.textMessage { // location with text
//
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMLocationWithTextCell
//                reactionsWithCellClass.view.addSubview(cell)
//            }
//            else if let _ = message.locationMessage { // only location
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMLocationMessageCell
//
//                reactionsWithCellClass.view.addSubview(cell)
//            }
//            else if let _ = message.audioMessage {
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMAudioMessageCell
//                if let snapshot = cell.mainView.snapshotView(afterScreenUpdates: false) {
//
//                    let cellWidth = cell.mainView.bounds.size.width
//                    let cellHeight = cell.mainView.bounds.size.height
//
//                    basicTask(snapshot: snapshot, snapshotWidth: cellWidth, snapshotHeight: cellHeight)
//                }
//
//            }
//            else if let _ = message.textMessage { // only text
//
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMTextMessageCell
//
//                if let snapshot = cell.mainView.snapshotView(afterScreenUpdates: false) {
//
//                    let cellWidth = cell.mainView.bounds.size.width
//                    let cellHeight = cell.mainView.bounds.size.height
//
//                    basicTask(snapshot: snapshot, snapshotWidth: cellWidth, snapshotHeight: cellHeight)
//                }
//
//
//
//            }
//
//            return navController
////            return nil
//        }, actionProvider: { _ in
//            return menu
//        })
//
//
//        return configuration
//    }
//
//
//
////    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
////        return false
////    }
//
//
//
//
//
//        func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
//            guard
//                let indexPath = configuration.identifier as? IndexPath
//            else {
//                return nil
//            }
//
//
//            let sectionTitle = sections[indexPath.section]
//
//            guard let messagesInSection = sectionMessages[sectionTitle] else { return nil }
//
//            let message = messagesInSection[indexPath.row]
//
//
//            let params = UIPreviewParameters()
//            params.backgroundColor = .clear
//            if #available(iOS 14.0, *) {
//                params.shadowPath = UIBezierPath()
//            }
//
//    //        let cell = tableView.cellForRow(at: indexPath) as! CTRMAudioMessageCell
//
//            if let _ = message.videoMessage, let _ = message.textMessage { // video with text
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMPhotoWithTextCell
//
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//            else if let _ = message.videoMessage { // video only
//
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMOnlyPhotoMessageCell
//
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//            else if let _ = message.photoMessage, let _ = message.textMessage { // photo with text
//
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMPhotoWithTextCell
//
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//            else if let _ = message.photoMessage { // only photo
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMOnlyPhotoMessageCell
//
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//            else if let _ = message.locationMessage, let _ = message.textMessage { // location with text
//
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMLocationWithTextCell
//
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//            else if let _ = message.locationMessage { // only location
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMLocationMessageCell
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//            else if let _ = message.audioMessage {
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMAudioMessageCell
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//            else if let _ = message.textMessage { // only text
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMTextMessageCell
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//
//
//            return nil
//
//        }
//
//
//
//        func tableView(_ tableView: UITableView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
//
//            guard let indexPath = configuration.identifier as? IndexPath
//            else {
//                return nil
//            }
//    //        reactionsView.isHidden = true
//    //        testView.isHidden = true
//            let sectionTitle = sections[indexPath.section]
//
//            guard let messagesInSection = sectionMessages[sectionTitle] else { return nil }
//
//            let message = messagesInSection[indexPath.row]
//
//
//            let params = UIPreviewParameters()
//            params.backgroundColor = .clear
//            if #available(iOS 14.0, *) {
//                params.shadowPath = UIBezierPath()
//            }
//
//    //        let cell = tableView.cellForRow(at: indexPath) as! CTRMAudioMessageCell
//
//            if let _ = message.videoMessage, let _ = message.textMessage { // video with text
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMPhotoWithTextCell
//
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//            else if let _ = message.videoMessage { // video only
//
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMOnlyPhotoMessageCell
//
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//            else if let _ = message.photoMessage, let _ = message.textMessage { // photo with text
//
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMPhotoWithTextCell
//
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//            else if let _ = message.photoMessage { // only photo
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMOnlyPhotoMessageCell
//
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//            else if let _ = message.locationMessage, let _ = message.textMessage { // location with text
//
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMLocationWithTextCell
//
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//            else if let _ = message.locationMessage { // only location
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMLocationMessageCell
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//            else if let _ = message.audioMessage {
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMAudioMessageCell
////                cell.Reactions.removeFromSuperview()
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//            else if let _ = message.textMessage { // only text
//                let cell = tableView.cellForRow(at: indexPath) as! CTRMTextMessageCell
//                return UITargetedPreview(view: cell, parameters: params)
//            }
//
//
//            return nil
//        }
//
//
//
//
//
//
//    func tableView(_ tableView: UITableView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
////        reactionsView.isHidden = false
////        testView.isHidden = false
//
////        guard let indexPath = configuration.identifier as? IndexPath
////        else {
////            return
////        }
////
////
////        let cell = tableView.cellForRow(at: indexPath) as! CTRMAudioMessageCell
////        cell.addSubview(cell.Reactions)
////
////        cell.Reactions.isLeading = false
////
////        cell.bounds.size.height = 400
////
////        NSLayoutConstraint.activate([
//////            cell.Reactions.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
////
////            cell.Reactions.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
////            cell.Reactions.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
//////            cell.Reactions.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
////            cell.Reactions.bottomAnchor.constraint(equalTo: cell.bubbleView.topAnchor, constant: 10),
////        ])
//    }
//
//
//
//
//
//
//
//    private func deleteMessage(message: Message, indexPath: IndexPath) {
//
//        deleteMessagesInDatabaseOnDisk(fileName: self.fileName, folderName: self.messagesDiskPath, messagesToDelete: [message], tableName: DataStore.shared.messagesTable)
//
//        let sectionTitle  = sections[indexPath.section]
//
//        var deleteSection = false
//
//        if var sectionMessages = sectionMessages[sectionTitle] {
//
//            self.messages.removeAll(where: {$0.id == message.id})
//            sectionMessages.removeAll(where: {$0.id == message.id})
//            if sectionMessages.count > 0 {
//                self.sectionMessages[sectionTitle] = sectionMessages
//            } else {
//                self.sectionMessages.removeValue(forKey: sectionTitle)
//                self.sections.removeAll(where: {$0 == sectionTitle})
//                deleteSection = true
//            }
//
//            if let fileName = message.audioMessage {
//                let appName = DataStore.shared.appName
//                let diskPath = appName + "/chats/\(message.chatroomId)/audios"
//                removeFileOrFolderFromDisk(fileName: fileName, folderName: diskPath)
//            }
////            self.sectionMessages[sectionTitle] = sectionMessages
//        }
//
////ª
//        self.tableView.beginUpdates()
//        if deleteSection {
//            let indexSet = IndexSet(integer: indexPath.section)
//            tableView.deleteSections(indexSet, with: .none)
//        }
//        self.tableView.deleteRows(at: [indexPath], with: .fade)
//        self.tableView.endUpdates()
//
//    }
//}

















////////////////////////////////////////

















//NSLayoutConstraint.activate([
//    reactionsView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
////                    reactionsView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
//    reactionsView.bottomAnchor.constraint(equalTo: container.topAnchor, constant:10),
//    reactionsView.heightAnchor.constraint(equalToConstant: 100),
//    reactionsView.widthAnchor.constraint(equalToConstant: 100)
//])
//
////                NSLayoutConstraint.activate([
////                    container.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
////                    container.topAnchor.constraint(equalTo: cell.topAnchor)
////                ])
//
//var centerPoint = CGPoint(x: cell.center.x, y: cell.center.y - reactionsView.bounds.height)
//let windowHeight =  UIScreen.main.bounds.height
//
//if snapshot.bounds.height > (windowHeight * 0.9) { // if the snapshot of cell if too tall, we use this center point to make it fit *&#x2F;
//    centerPoint = CGPoint(x: cell.center.x, y: tableView.center.y)
//}


//func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
//
//    guard
//        let indexPath = configuration.identifier as? IndexPath
////                let cell = tableView.cellForRow(at: indexPath) as? CTRMAudioMessageCell
//    else {
//        return nil
//    }
//
//
//
////            if let snapshot = cell.snapshotView(afterScreenUpdates: false)
//
//    let cell = tableView.cellForRow(at: indexPath) as! CTRMAudioMessageCell
//
//
//
//    reactionsView.translatesAutoresizingMaskIntoConstraints = false
//    reactionsView.backgroundColor = .red
//
//
//
//
//    if let snapshot = cell.snapshotView(afterScreenUpdates: false) {
//            print("snapshow: ", snapshot)
//                snapshot.isHidden = false
//                snapshot.layer.cornerRadius = 10
//                snapshot.layer.masksToBounds = true
//                snapshot.translatesAutoresizingMaskIntoConstraints = false
//
//
//
//
//
//                let container = UIView(frame: CGRect(
//                    origin: .zero,
//                    size: CGSize(
//                        width: cell.bounds.width,
//                        height: cell.bounds.height + reactionsView.bounds.height + 5
//                    )
//                ))
//                container.backgroundColor = .clear
//                container.addSubview(reactionsView)
//                container.addSubview(snapshot)
//
//        NSLayoutConstraint.activate([
//            reactionsView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
//        //                    reactionsView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
//            reactionsView.bottomAnchor.constraint(equalTo: container.topAnchor, constant:10),
//            reactionsView.heightAnchor.constraint(equalToConstant: 100),
//            reactionsView.widthAnchor.constraint(equalToConstant: 100)
//        ])
//
//
//        cell.backgroundColor = .clear
//        cell.selectionStyle = .none
//        cell.setHighlighted(false, animated: false)
//
//        let params = UIPreviewParameters()
//        params.backgroundColor = .clear
//
//        if #available(iOS 14.0, *) {
//            params.shadowPath = UIBezierPath()
//        }
//
//        var centerPoint = CGPoint(x: cell.center.x, y: cell.center.y - reactionsView.bounds.height)
//        let windowHeight =  UIScreen.main.bounds.height
//
//        if snapshot.bounds.height > (windowHeight * 0.9) { // if the snapshot of cell if too tall, we use this center point to make it fit *&#x2F;
//            centerPoint = CGPoint(x: cell.center.x, y: tableView.center.y)
//        }
//
//        let previewTarget = UIPreviewTarget(container: tableView, center: centerPoint)
//
//        reactionsView.isHidden = false
//        return UITargetedPreview(view: cell, parameters: params)
//    }
//
//    return nil
//}





//func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
//
//    guard
//        let indexPath = configuration.identifier as? IndexPath
////                let cell = tableView.cellForRow(at: indexPath) as? CTRMAudioMessageCell
//    else {
//        return nil
//    }
//
//
//
////            if let snapshot = cell.snapshotView(afterScreenUpdates: false)
//
//    let cell = tableView.cellForRow(at: indexPath) as! CTRMAudioMessageCell
//
//
//
//    reactionsView.translatesAutoresizingMaskIntoConstraints = false
//    reactionsView.backgroundColor = .red
//
//    if let snapshot = cell.snapshotView(afterScreenUpdates: false) {
//            print("snapshow: ", snapshot)
//                snapshot.isHidden = false
//                snapshot.layer.cornerRadius = 10
//                snapshot.layer.masksToBounds = true
//                snapshot.translatesAutoresizingMaskIntoConstraints = false
//
////                    snapshot.transform = CGAffineTransform(scaleX: 1, y: -1)
//
//
//                let container = UIView(frame: CGRect(
//                    origin: .zero,
//                    size: CGSize(
//                        width: cell.bounds.width,
//                        height: cell.bounds.height + reactionsView.bounds.height + 5
//                    )
//                ))
//                container.backgroundColor = .clear
//                container.addSubview(reactionsView)
//                container.addSubview(snapshot)
//        container.transform = CGAffineTransform(scaleX: 1, y: -1)
//
//        NSLayoutConstraint.activate([
//            reactionsView.leftAnchor.constraint(equalTo: container.leftAnchor),
//            reactionsView.topAnchor.constraint(equalTo: container.topAnchor),
//            reactionsView.widthAnchor.constraint(equalTo: container.widthAnchor),
//            reactionsView.heightAnchor.constraint(equalToConstant: cell.bounds.height),
//
//            snapshot.leftAnchor.constraint(equalTo: container.leftAnchor),
//            snapshot.rightAnchor.constraint(equalTo: container.rightAnchor),
//            snapshot.bottomAnchor.constraint(equalTo: container.bottomAnchor),
//            snapshot.heightAnchor.constraint(equalToConstant: cell.bounds.height)
//        ])
//
//
//
//        let params = UIPreviewParameters()
//        params.backgroundColor = .clear
//
//        if #available(iOS 14.0, *) {
//            params.shadowPath = UIBezierPath()
//        }
//
//        var centerPoint = CGPoint(x: cell.center.x, y: cell.center.y - reactionsView.bounds.height)
//        let windowHeight =  UIScreen.main.bounds.height
//
//        if snapshot.bounds.height > (windowHeight * 0.9) { // if the snapshot of cell if too tall, we use this center point to make it fit *&#x2F;
//            centerPoint = CGPoint(x: cell.center.x, y: tableView.center.y)
//        }
//
//        let previewTarget = UIPreviewTarget(container: tableView, center: centerPoint)
//
////            reactionsView.isHidden = false
//        return UITargetedPreview(view: container, parameters: params, target: previewTarget)
//    }
//
//    return nil
//}



//else if let _ = message.audioMessage {
//    let cell =  CTRMAudioMessageCell()
//    reactionsWithCellClass.view.addSubview(cell)
//    cell.translatesAutoresizingMaskIntoConstraints = false
//
//
//    NSLayoutConstraint.activate([
//        cell.leadingAnchor.constraint(equalTo: reactionsWithCellClass.view.leadingAnchor),
//        cell.trailingAnchor.constraint(equalTo: reactionsWithCellClass.view.trailingAnchor),
//        cell.topAnchor.constraint(equalTo: reactionsWithCellClass.view.topAnchor),
//        cell.bottomAnchor.constraint(equalTo: reactionsWithCellClass.view.bottomAnchor)
//    ])
//
//    reactionsWithCellClass.view.backgroundColor = .clear
//    print("cell.bounds.size", cell.bounds.size)
//    reactionsWithCellClass.preferredContentSize = cell.bounds.size
//    cell.configure(message: message, isSelecting: false)
//}







//    func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
//
//        guard
//            let indexPath = configuration.identifier as? IndexPath
////                let cell = tableView.cellForRow(at: indexPath) as? CTRMAudioMessageCell
//        else {
//            return nil
//        }
//
//
//
////            if let snapshot = cell.snapshotView(afterScreenUpdates: false)
//
//        let cell = tableView.cellForRow(at: indexPath) as! CTRMAudioMessageCell
//
//
//
//        testView.translatesAutoresizingMaskIntoConstraints = false
//        testView.backgroundColor = .blue
//        testView.isHidden = true
//
//
////        let size = cell.bounds.size
//
//        view.addSubview(testView)
//        NSLayoutConstraint.activate([
//            testView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            testView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            testView.topAnchor.constraint(equalTo: cell.topAnchor),
////                    reactionsView.heightAnchor.constraint(equalToConstant: 100),
//            testView.bottomAnchor.constraint(equalTo: cell.bottomAnchor)
//        ])
//
//
//
//
//        reactionsView.translatesAutoresizingMaskIntoConstraints = false
//        reactionsView.backgroundColor = .red
//        view.addSubview(reactionsView)
//        reactionsView.isHidden = true
//
//        NSLayoutConstraint.activate([
//            reactionsView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
//            reactionsView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
//            reactionsView.bottomAnchor.constraint(equalTo: cell.topAnchor, constant:10),
////                    reactionsView.heightAnchor.constraint(equalToConstant: 100),
//            reactionsView.widthAnchor.constraint(equalToConstant: 100)
//        ])
//
//
//            cell.backgroundColor = .clear
//
//            let params = UIPreviewParameters()
//            params.backgroundColor = .clear
//
//            if #available(iOS 14.0, *) {
//                params.shadowPath = UIBezierPath()
//            }
//
//            return UITargetedPreview(view: testView, parameters: params)
//    }
























//func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
//
//    guard
//        let indexPath = configuration.identifier as? IndexPath
////                let cell = tableView.cellForRow(at: indexPath) as? CTRMAudioMessageCell
//    else {
//        return nil
//    }
//
//
//
////            if let snapshot = cell.snapshotView(afterScreenUpdates: false)
//
//    let cell = tableView.cellForRow(at: indexPath) as! CTRMAudioMessageCell
//
//    guard let snapshot = cell.mainView.snapshotView(afterScreenUpdates: false)  else {return nil}
//
//    let snapshotWidth = cell.mainView.bounds.size.width
//    let snapshotHeight = cell.mainView.bounds.size.height
//
//    let container = UIView(frame: CGRect(
//         origin: .zero,
//         size: CGSize(
//             width: cell.bounds.width,
//             height: cell.bounds.height
//         )
//     ))
//
//    container.backgroundColor = .red
//
//    snapshot.isHidden = false
//    snapshot.layer.cornerRadius = 10
//    snapshot.layer.masksToBounds = true
//    snapshot.translatesAutoresizingMaskIntoConstraints = false
//
//    container.addSubview(snapshot)
//
////                    snapshot.backgroundColor = .yellow
//
////                    reactionsWithCellClass.view.backgroundColor = .red
//
//    NSLayoutConstraint.activate([
////                        snapshot.leadingAnchor.constraint(equalTo: reactionsWithCellClass.view.leadingAnchor),
////                        snapshot.trailingAnchor.constraint(equalTo: reactionsWithCellClass.view.trailingAnchor),
//        snapshot.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
////                        snapshot.leadingAnchor.constraint(equalTo: reactionsWithCellClass.view.leadingAnchor, constant: 0),
//        snapshot.widthAnchor.constraint(equalToConstant: CGFloat(snapshotWidth)),
//        snapshot.heightAnchor.constraint(equalToConstant: CGFloat(snapshotHeight)),
////                        snapshot.topAnchor.constraint(equalTo: reactionsWithCellClass.view.topAnchor),
////                        snapshot.bottomAnchor.constraint(equalTo: reactionsWithCellClass.view.bottomAnchor),
//        snapshot.centerYAnchor.constraint(equalTo: container.centerYAnchor),
////                        snapshot.bottomAnchor.constraint(equalTo: reactionsWithCellClass.view.bottomAnchor),
//
//    ])
//
//
//
//
//
//
//    var centerPoint = CGPoint(x: cell.center.x, y: cell.center.y)
//
//    let windowHeight =  self.view.bounds.size.height
//
//    if cell.bounds.size.height > (windowHeight * 0.9) {
//         centerPoint = CGPoint(x: cell.center.x, y: tableView.center.y)
//     }
//
//        let previewTarget = UIPreviewTarget(container: tableView, center: centerPoint)
//
//
//        cell.backgroundColor = .clear
//
//        let params = UIPreviewParameters()
//        params.backgroundColor = .clear
//
//        if #available(iOS 14.0, *) {
//            params.shadowPath = UIBezierPath()
//        }
//
//
//        return UITargetedPreview(view: container, parameters: params, target: previewTarget)
//}
//
//
//
//
//func tableView(_ tableView: UITableView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
//
//
//
//guard
//    let indexPath = configuration.identifier as? IndexPath
////                let cell = tableView.cellForRow(at: indexPath) as? CTRMAudioMessageCell
//else {
//    return nil
//}
//
//reactionsView.isHidden = true
//testView.isHidden = true
//
//
////            if let snapshot = cell.snapshotView(afterScreenUpdates: false)
//
//let cell = tableView.cellForRow(at: indexPath) as! CTRMAudioMessageCell
//
//
//cell.backgroundColor = .clear
//
//let params = UIPreviewParameters()
//params.backgroundColor = .clear
//
//if #available(iOS 14.0, *) {
//    params.shadowPath = UIBezierPath()
//}
//
//return UITargetedPreview(view: cell, parameters: params)
//}
