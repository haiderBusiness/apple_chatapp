//
//  Chatroom+CellRow.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 8.7.2023.
//

import UIKit
extension ChatroomVC: UIGestureRecognizerDelegate {
    
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // MARK: old table view cell (not in use)
    
    func tableViewNOTUSED(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatroomCell.identifier) as! ChatroomCell
          let sectionTitle = sections[indexPath.section]
        

              if let messagesInSection = sectionMessages[sectionTitle] {
                  let message = messagesInSection[indexPath.row]

                  cell.updateMessage = { [weak self] media in


                      let index = self?.messages.firstIndex(where: {$0.id == message.id})
                      if let index = index {

                          if media.isVideo {
                              self?.messages[index].videoMessage?.savedOnDeviceId = DataStore.shared.deviceUniqueIdentifier
                          } else if media.isPhoto {
                              self?.messages[index].photoMessage?.savedOnDeviceId = DataStore.shared.deviceUniqueIdentifier
                          }

                          self?.setupSectionsAndMessages()
  //                        let messageTest = messagesInSection[indexPath.row]
  //                        let indexPath = IndexPath(item: indexPath.row, section: indexPath.section)
                          if let message = self?.messages[index] {
                              cell.setup(message: message, isSelecting: false)
                              self?.saveUpdatesToDisk(message: message)
                          }


  //                        self?.tableView.reloadRows(at: [indexPath], with: .automatic)

  //                        print("update function message: ", messageTest.photoMessage?.savedOnDeviceId ?? "nil")
                      }

                  }



  //                if let messageLocation = message.locationMessage {
  //                    let messageLocationMapView : CoreChatroomCellMap = {
  //                         let map = ChatroomCellMap()
  //                         return map
  //                     }()
  //                    messageLocationMapView.setMapLocation(location: messageLocation)
  //                    messageLocationMapView.centerMap()
  //
  //                    cell.messageLocationMapView = messageLocationMapView
  //                }


                  cell.setup(message: message, isSelecting: false)

              }




              cell.backgroundColor = .clear

  //            cell.transform = CGAffineTransform(scaleX: 1, y: -1)
              return cell
          }
    
    
    
    
    
    
    
    
    
    
    
    // MARK: video with text cell
    func showVideoWithTextCell(message: Message, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoWithTextMessageCell.identifier) as! PhotoWithTextMessageCell

        cell.configure(message: message, isSelecting: false)
        cell.updateMessage = { [weak self] in


            let index = self?.messages.firstIndex(where: {$0.id == message.id})
            if let index = index {

                self?.messages[index].videoMessage?.savedOnDeviceId = DataStore.shared.deviceUniqueIdentifier
                
//                        let messageTest = messagesInSection[indexPath.row]
//                        let indexPath = IndexPath(item: indexPath.row, section: indexPath.section)
                if let message = self?.messages[index] {
                    cell.configure(message: message, isSelecting: false)
                    self?.saveUpdatesToDisk(message: message)
                }

//                        self?.tableView.reloadRows(at: [indexPath], with: .automatic)

//                        print("update function message: ", messageTest.photoMessage?.savedOnDeviceId ?? "nil")
            }

        }

        cell.backgroundColor = .clear
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        let longPress = ContextMenuOnLongPress(target: self, action: #selector(contextMenuInteraction), indexPath: indexPath, message: message)
        longPress.minimumPressDuration = 0.2
        longPress.delegate = self
        longPress.delaysTouchesBegan = true
        cell.longPressRecognizer = longPress
        cell.addGestureRecognizer(longPress)
        
        return cell
    }
    
    // MARK: only video cell
    func showVideoCell(message: Message, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoMessageCell.identifier) as! PhotoMessageCell

        cell.configure(message: message, isSelecting: false)

            cell.updateMessage = { [weak self] in
                let index = self?.messages.firstIndex(where: {$0.id == message.id})
                if let index = index {

                    self?.messages[index].videoMessage?.savedOnDeviceId = DataStore.shared.deviceUniqueIdentifier
                    
//                        let messageTest = messagesInSection[indexPath.row]
//                        let indexPath = IndexPath(item: indexPath.row, section: indexPath.section)
                    if let message = self?.messages[index] {
                        cell.configure(message: message, isSelecting: false)
                        self?.saveUpdatesToDisk(message: message)
                    }

//                            print("update function message: ", messageTest.photoMessage?.savedOnDeviceId ?? "nil")
                }
            }

        cell.noInternetMessage = { [weak self] in
            if let self = self {
                showMessage(self: self, title: nil, message: Language.Couldnt_download_image_check_your_internet_connection_and_try_again, okActionText: Language.ok)
            }

        }

        cell.backgroundColor = .clear
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        let longPress = ContextMenuOnLongPress(target: self, action: #selector(contextMenuInteraction), indexPath: indexPath, message: message)
        longPress.minimumPressDuration = 0.2
        longPress.delegate = self
        longPress.delaysTouchesBegan = true
        cell.longPressRecognizer = longPress
        cell.addGestureRecognizer(longPress)
        return cell
    }
    
    
    // MARK: Photo with text cell
    func showPhotoWithTextCell(message: Message, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoWithTextMessageCell.identifier) as! PhotoWithTextMessageCell

        cell.configure(message: message, isSelecting: false)
        cell.updateMessage = { [weak self] in


            let index = self?.messages.firstIndex(where: {$0.id == message.id})
            if let index = index {

                self?.messages[index].photoMessage?.savedOnDeviceId = DataStore.shared.deviceUniqueIdentifier
                
//                        let messageTest = messagesInSection[indexPath.row]
//                        let indexPath = IndexPath(item: indexPath.row, section: indexPath.section)
                if let message = self?.messages[index] {
                    cell.configure(message: message, isSelecting: false)
                    self?.saveUpdatesToDisk(message: message)
                }

//                        self?.tableView.reloadRows(at: [indexPath], with: .automatic)

//                        print("update function message: ", messageTest.photoMessage?.savedOnDeviceId ?? "nil")
            }

        }

        cell.backgroundColor = .clear
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        let longPress = ContextMenuOnLongPress(target: self, action: #selector(contextMenuInteraction), indexPath: indexPath, message: message)
        longPress.minimumPressDuration = 0.2
        longPress.delegate = self
        longPress.delaysTouchesBegan = true
        cell.longPressRecognizer = longPress
        cell.addGestureRecognizer(longPress)
        return cell
    }
    
    
    // MARK: only photo cell
    func showPhotoCell(message: Message, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoMessageCell.identifier) as! PhotoMessageCell

        cell.configure(message: message, isSelecting: false)

            cell.updateMessage = { [weak self] in
                let index = self?.messages.firstIndex(where: {$0.id == message.id})
                if let index = index {

                    self?.messages[index].photoMessage?.savedOnDeviceId = DataStore.shared.deviceUniqueIdentifier
//                        let messageTest = messagesInSection[indexPath.row]
//                        let indexPath = IndexPath(item: indexPath.row, section: indexPath.section)
                    
                    if let message = self?.messages[index] {
                        cell.configure(message: message, isSelecting: false)
                        self?.saveUpdatesToDisk(message: message)
                    }

//                            print("update function message: ", messageTest.photoMessage?.savedOnDeviceId ?? "nil")
                }
            }

        cell.noInternetMessage = { [weak self] in
            if let self = self {
                showMessage(self: self, title: nil, message: Language.Couldnt_download_image_check_your_internet_connection_and_try_again, okActionText: Language.ok)
            }

        }

        cell.backgroundColor = .clear
        
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        let longPress = ContextMenuOnLongPress(target: self, action: #selector(contextMenuInteraction), indexPath: indexPath, message: message)
        longPress.minimumPressDuration = 0.2
        longPress.delegate = self
        longPress.delaysTouchesBegan = true
        cell.longPressRecognizer = longPress
        cell.addGestureRecognizer(longPress)
        return cell
    }
    
    
    // MARK: location with text cell
    func showLocationWithTextCell(message: Message, indexPath: IndexPath) -> UITableViewCell {
//        print("text message: ", message.textMessage ?? "")

        let cell = tableView.dequeueReusableCell(withIdentifier: CTRMLocationWithTextCell.identifier) as! CTRMLocationWithTextCell

        cell.configure(message: message, isSelecting: false)

        cell.backgroundColor = .clear
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        let longPress = ContextMenuOnLongPress(target: self, action: #selector(contextMenuInteraction), indexPath: indexPath, message: message)
        longPress.minimumPressDuration = 0.2
        longPress.delegate = self
        longPress.delaysTouchesBegan = true
        cell.longPressRecognizer = longPress
        cell.addGestureRecognizer(longPress)
        return cell
    }
    
    
    
    // MARK: only location cell
    func showLocationCell(message: Message, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationMessageCell.identifier) as! LocationMessageCell

        cell.configure(message: message, isSelecting: false)

        cell.backgroundColor = .clear
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        let longPress = ContextMenuOnLongPress(target: self, action: #selector(contextMenuInteraction), indexPath: indexPath, message: message)
        longPress.minimumPressDuration = 0.2
        longPress.delegate = self
        longPress.delaysTouchesBegan = true
        cell.longPressRecognizer = longPress
        cell.addGestureRecognizer(longPress)
        
        
//        if let mapView = mapView {
//            cell.messageLocationSnapshot = mapView.snapshotMap(location: message.locationMessage!)
//        }
        
        return cell
    }
    
    
    
    // MARK: only text cell
    func showTextCell(message:Message, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TextMessageCell.identifier) as! TextMessageCell

        cell.configure(message: message, isSelecting: false)
        cell.backgroundColor = .clear
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        let longPress = ContextMenuOnLongPress(target: self, action: #selector(contextMenuInteraction), indexPath: indexPath, message: message)
        longPress.minimumPressDuration = 0.2
        longPress.delegate = self
        longPress.delaysTouchesBegan = true
        cell.longPressRecognizer = longPress
        cell.addGestureRecognizer(longPress)
        
        
//        print("only text cell here")
//        cell.backgroundColor = .red
        return cell
    }
    
    // MARK: only text cell
    func showAudioCell(message:Message, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CTRMAudioMessageCell.identifier) as! CTRMAudioMessageCell
        
//        cell.gestureRecognizers?.forEach(cell.removeGestureRecognizer)
//
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
//        cell.addGestureRecognizer(longPress)
        
//        cell.interactions.removeAll { $0 is UIContextMenuInteraction }
//        
//        let contextMenuInteraction = UIContextMenuInteraction(delegate: self)
//        cell.addInteraction(contextMenuInteraction)
        
        
        
        cell.configure(message: message, isSelecting: false)
        
        let longPress = ContextMenuOnLongPress(target: self, action: #selector(contextMenuInteraction), indexPath: indexPath, message: message)
        longPress.minimumPressDuration = 0.2
        longPress.delegate = self
        longPress.delaysTouchesBegan = true
        cell.longPressRecognizer = longPress
        cell.addGestureRecognizer(longPress)
        

        cell.backgroundColor = .clear
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        
//        print("audio cell here")
        return cell
        
    }
    
    
    
    //  MARK: tableView cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let sectionTitle = sections[indexPath.section]
        
//        print("section cell here")

        if let messagesInSection = sectionMessages[sectionTitle] {
            let message = messagesInSection[indexPath.row]
            
                
            if let _ = message.videoMessage, let _ = message.textMessage { // video with text
                let cell = showVideoWithTextCell(message: message, indexPath: indexPath)
              return cell
            }
            else if let _ = message.videoMessage { // video only
                let cell = showVideoCell(message: message, indexPath: indexPath)
                return cell
            }
            else if let _ = message.photoMessage, let _ = message.textMessage { // photo with text
                let cell = showPhotoWithTextCell(message: message, indexPath: indexPath)
                return cell
            }
            else if let _ = message.photoMessage { // only photo
                let cell = showPhotoCell(message: message, indexPath: indexPath)
                return cell
            }
            else if let _ = message.locationMessage, let _ = message.textMessage { // location
                let cell = showLocationWithTextCell(message: message, indexPath: indexPath)
                return cell
            }
            else if let _ = message.locationMessage { // only location
                let cell = showLocationCell(message: message, indexPath: indexPath)
                return cell
            }
            else if let _ = message.audioMessage {
                let cell = showAudioCell(message: message, indexPath: indexPath)

                return cell
            }
            
            else if let _ = message.textMessage { // only text
                let cell = showTextCell(message: message, indexPath: indexPath)
                return cell
            }
        }

        let emptyCell = UITableViewCell()

        emptyCell.frame = CGRect.zero
        emptyCell.backgroundColor = .clear
        emptyCell.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        print("empty cell here")
        return emptyCell
    }
    
}







//
//extension ChatroomVC {
//    func showVideoWithTextCell(message: Message, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CTRMPhotoWithTextCell.identifier) as! CTRMPhotoWithTextCell
//
//        cell.configure(message: message, isSelecting: false)
//        cell.updateMessage = { [weak self] in
//
//
//            let index = self?.messages.firstIndex(where: {$0.id == message.id})
//            if let index = index {
//
//                self?.messages[index].videoMessage?.savedOnDeviceId = DataStore.shared.deviceUniqueIdentifier
//
////                        let messageTest = messagesInSection[indexPath.row]
////                        let indexPath = IndexPath(item: indexPath.row, section: indexPath.section)
//                if let message = self?.messages[index] {
//                    cell.configure(message: message, isSelecting: false)
//                    self?.saveUpdatesToDisk(message: message)
//                }
//
////                        self?.tableView.reloadRows(at: [indexPath], with: .automatic)
//
////                        print("update function message: ", messageTest.photoMessage?.savedOnDeviceId ?? "nil")
//            }
//
//        }
//
//        cell.backgroundColor = .clear
//        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
//        return cell
//    }
//
//
//    func showVideoCell(message: Message, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CTRMOnlyPhotoMessageCell.identifier) as! CTRMOnlyPhotoMessageCell
//
//        cell.configure(message: message, isSelecting: false)
//
//            cell.updateMessage = { [weak self] in
//                let index = self?.messages.firstIndex(where: {$0.id == message.id})
//                if let index = index {
//
//                    self?.messages[index].videoMessage?.savedOnDeviceId = DataStore.shared.deviceUniqueIdentifier
//
////                        let messageTest = messagesInSection[indexPath.row]
////                        let indexPath = IndexPath(item: indexPath.row, section: indexPath.section)
//                    if let message = self?.messages[index] {
//                        cell.configure(message: message, isSelecting: false)
//                        self?.saveUpdatesToDisk(message: message)
//                    }
//
////                            print("update function message: ", messageTest.photoMessage?.savedOnDeviceId ?? "nil")
//                }
//            }
//
//        cell.noInternetMessage = { [weak self] in
//            if let self = self {
//                showMessage(self: self, title: nil, message: Language.Couldnt_download_image_check_your_internet_connection_and_try_again, okActionText: Language.ok)
//            }
//
//        }
//
//        cell.backgroundColor = .clear
//        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
//        return cell
//    }
//
//
//
//    func showPhotoWithTextCell(message: Message, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CTRMPhotoWithTextCell.identifier) as! CTRMPhotoWithTextCell
//
//        cell.configure(message: message, isSelecting: false)
//        cell.updateMessage = { [weak self] in
//
//
//            let index = self?.messages.firstIndex(where: {$0.id == message.id})
//            if let index = index {
//
//                self?.messages[index].photoMessage?.savedOnDeviceId = DataStore.shared.deviceUniqueIdentifier
//
////                        let messageTest = messagesInSection[indexPath.row]
////                        let indexPath = IndexPath(item: indexPath.row, section: indexPath.section)
//                if let message = self?.messages[index] {
//                    cell.configure(message: message, isSelecting: false)
//                    self?.saveUpdatesToDisk(message: message)
//                }
//
////                        self?.tableView.reloadRows(at: [indexPath], with: .automatic)
//
////                        print("update function message: ", messageTest.photoMessage?.savedOnDeviceId ?? "nil")
//            }
//
//        }
//
//        cell.backgroundColor = .clear
//        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
//        return cell
//    }
//
//
//    func showPhotoCell(message: Message, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CTRMOnlyPhotoMessageCell.identifier) as! CTRMOnlyPhotoMessageCell
//
//        cell.configure(message: message, isSelecting: false)
//
//            cell.updateMessage = { [weak self] in
//                let index = self?.messages.firstIndex(where: {$0.id == message.id})
//                if let index = index {
//
//                    self?.messages[index].photoMessage?.savedOnDeviceId = DataStore.shared.deviceUniqueIdentifier
////                        let messageTest = messagesInSection[indexPath.row]
////                        let indexPath = IndexPath(item: indexPath.row, section: indexPath.section)
//
//                    if let message = self?.messages[index] {
//                        cell.configure(message: message, isSelecting: false)
//                        self?.saveUpdatesToDisk(message: message)
//                    }
//
////                            print("update function message: ", messageTest.photoMessage?.savedOnDeviceId ?? "nil")
//                }
//            }
//
//        cell.noInternetMessage = { [weak self] in
//            if let self = self {
//                showMessage(self: self, title: nil, message: Language.Couldnt_download_image_check_your_internet_connection_and_try_again, okActionText: Language.ok)
//            }
//
//        }
//
//        cell.backgroundColor = .clear
//        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
//        return cell
//    }
//
//    func showLocationWithTextCell(message: Message, indexPath: IndexPath) -> UITableViewCell {
//        print("text message: ", message.textMessage ?? "")
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: CTRMLocationWithTextCell.identifier) as! CTRMLocationWithTextCell
//
//        cell.configure(message: message, isSelecting: false)
//
//        cell.backgroundColor = .clear
//        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
//        return cell
//    }
//
//    func showLocationCell(message: Message, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CTRMLocationMessageCell.identifier) as! CTRMLocationMessageCell
//
//        cell.configure(message: message, isSelecting: false)
//
//        cell.backgroundColor = .clear
//        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
//        return cell
//    }
//
//    func showTextCell(message:Message, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CTRMTextMessageCell.identifier) as! CTRMTextMessageCell
//
//        cell.configure(message: message, isSelecting: false)
//
//        cell.backgroundColor = .clear
//        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
//        return cell
//    }
//
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//        let sectionItem = sectionData[indexPath.row]
//
//        if let sectionTitle = sectionItem as? String {
//            let cell = tableView.dequeueReusableCell(withIdentifier: ChatroomSectionCell.identifier) as! ChatroomSectionCell
//
//            cell.sectionLabel.text = sectionTitle
//            cell.transform = CGAffineTransform(scaleX: 1, y: -1)
//            cell.backgroundColor = .clear
//            return cell
//        } else {
//            let message = sectionItem as! Message
//
//            // video with text
//            if let _ = message.videoMessage, let _ = message.textMessage { // video with text
//              let videoWithTextCell = showVideoWithTextCell(message: message)
//              return videoWithTextCell
//            } else if let _ = message.videoMessage { // video only
//                let videoCell = showVideoCell(message:message, indexPath: indexPath)
//                return videoCell
//            } else if let _ = message.photoMessage, let _ = message.textMessage { // photo with text
//                let photoWithTextCell = showPhotoWithTextCell(message: message)
//                return photoWithTextCell
//            } else if let _ = message.photoMessage { // only photo
//                let photoCell = showPhotoCell(message: message)
//                return photoCell
//            } else if let _ = message.locationMessage, let _ = message.textMessage { // location
//                let locationWithTextCell = showLocationWithTextCell(message: message)
//                return locationWithTextCell
//            } else if let _ = message.locationMessage { // only location
//                let locationCell = showLocationCell(message: message)
//                return locationCell
//            } else if let _ = message.textMessage { // only text
//                let textCell = showTextCell(message: message)
//                return textCell
//            }
//        }
//
//            let emptyCell = UITableViewCell()
//
//            emptyCell.frame = CGRect.zero
//            emptyCell.backgroundColor = .clear
//            return emptyCell
//
//    }
//
//
//
//}
//
