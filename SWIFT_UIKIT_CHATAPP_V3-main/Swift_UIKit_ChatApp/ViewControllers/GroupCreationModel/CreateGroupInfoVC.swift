//
//  CreateGroupProfileVC.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 18.6.2023.
//

import UIKit

class CreateGroupInfoVC: UIViewController {
    
        var participants: [User] = []
        var tableView: UITableView!
        
        var option: MessageDisapear = .off
        
        var tableViewHeightConstraint: NSLayoutConstraint!
    
        
        var navigationDelegate: NavigateToNewChatroomDelegate?
    
        var headerView: GroupCreationHeader?
        
        var removeUserDelegate: UpdateSelectedUsersProtocol?
        
        var addNewChatDelegate: NewChatAddedProtocol?
        
        let deviceUniqueIdentifier = DataStore.shared.deviceUniqueIdentifier
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = Language.group_info
            view.backgroundColor = .systemGray6
    //        configureScrollView()
           
    //        configureFirstField()
    //        configureSecondField()
            configureNavigation()
            configureTableView()
        }

    
    
  

        func configureNavigation()  {
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Language.create, style: .plain, target: self, action: #selector(onNextButtonPress))
            
            navigationItem.rightBarButtonItem?.tintColor = .systemGray4
        }
        
        @objc func onCancelButtonPress() {
            dismiss(animated: true, completion: nil)
        }
    
        @objc func onNextButtonPress() {
            
            
            guard let unwrapedHeaderView = self.headerView else {
                return
            }
            
            guard let unwrapedText = unwrapedHeaderView.nameTextField.text else {
                return
            }
            
                if !unwrapedText.isEmpty {
                    createGroup()
                    dismiss(animated: true, completion: nil)
                } else {
                    print("its empty")
                }
        }
    
    
    func createGroup() {
        guard let unwrapedHeaderView = headerView else {
            return
        }
        
       
        
        self.participants.insert(DataStore.shared.user, at: 0)
        
        
        let currentDate = Date()
        let timestamp = currentDate.timeIntervalSince1970
        //print(timestamp) // Unix timestamp as a Double
        
        let idArray = participants.map {$0.id}

        
        var groupChatRoom: ChatRoom = ChatRoom(id: "\(UUID())", usersIds: idArray, messagesIds: [], lastMessage: Language.you_have_created_a_group, unreadCount: 0, lastMessageDate: timestamp, name: unwrapedHeaderView.nameTextField.text, pinnedAt: timestamp, createdAt: timestamp)

        if let groupImage = unwrapedHeaderView.groupImage.image {
            
            
            let imageData = groupImage.jpegData(compressionQuality: 0.72)
            
            let width = groupImage.size.width
            let height = groupImage.size.height
            
            if let imageData = imageData {
                let bytes = imageData.count
                let kilobytes = bytes / 1024
                let photoUrl = "https//serverUrl/images/\(UUID())" // not complete
                
                let placeHolderUrl = ""
                
                //TODO: resize image width to 15px and push it as a placeholder:
                //-> Not done
                
                //TODO: save image to disk directly to display it on auth user side
                //-> Not done
                
                // image data
                let _ = PhotoMessage(photoUrl: photoUrl, placeHolderUrl: placeHolderUrl, photoSizeInPX: ImageSizeInPX(width: width, height: height), photoSizeInBytes: "\(kilobytes) \(Language.KB)", savedOnDeviceId:nil)
                
                //TODO: push imageData to with Chatroom to the server
                // -> Not done
            }
            
//            print("image: ", image)
//            
//            groupChatRoom.image = image
        }
        
        addNewChatDelegate?.newChatAdded(newChat: groupChatRoom)
        navigationDelegate?.navigateToNewChatroom(userData: nil, Chatroom: groupChatRoom)
  
    }
    
}


extension CreateGroupInfoVC {
        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            if let unwrapedHeaderView = self.headerView {
                unwrapedHeaderView.nameTextField.resignFirstResponder()
            }
        }
}



extension CreateGroupInfoVC: UITextFieldDelegate {
    
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Get the updated text string
            let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
            
            // Process the updated text as needed
            print("Live input: \(updatedText ?? "")")
            
            if let text = updatedText {
                if !text.isEmpty {
                    navigationItem.rightBarButtonItem?.tintColor = AppTheme.primaryColor
                } else {
                    navigationItem.rightBarButtonItem?.tintColor = .systemGray4
                }
            } else {
                navigationItem.rightBarButtonItem?.tintColor = .systemGray4
            }
            
            // Return true to allow the text change, or false to reject it
            return true
        }
}

