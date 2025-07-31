//
//  ChatViewController.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 30.5.2023.
//

struct SectionData {
    let sectionTitle: String
    let messages: [Message]
}

import UIKit
import AVFoundation
//import MapKit

class ChatroomVC: UIViewController {
    
    var tableView: FetchFromBotomTableView!
    
    var mapView: MapView?
    
    // received variables
    var chatroom: ChatRoom?
    var receivedUser: User?
    var loadingStatus: ChatsLoadingEnum = .waitingForNetwork
    
    
    // chatroom navigation header:
    let lastSeenLabel = UILabel()
    let navigationView = UIView()
    

    // datasrouce variables
    var messages: [Message] = [] // array of messages
    var sections: [String] = [] // array of section titles
    var sectionMessages: [String: [Message]] = [:] // array of sections with its messages
    var addNewChatroomDelegate: NewChatAddedProtocol? // new message addition
    

    // database variables
    var messagesDiskPath: String!
    var chatroomDiskPath: String!
//    var fileName = "messages.json"
    let limit = 120
    var messagesOffset = 0 // initally 
    var fileName = "messages"
    var newChatroomId = UUID()
    var isFetchingItems = true
    
    var firstRender = true
    
    // changes made to messages
    var updateCurrentChatroom: UpdateChatroom?
    
    var isScrolling: Bool = false
    // keyboard variables
    let messageInputViewMaxHeight: CGFloat = 265
    var textFieldBottomConstraint: NSLayoutConstraint!
    let keyboardContainer = UIView();
    let attachmentImage = ImageViewPro();
    let messageInput = UITextView();
    let stickerImage = ImageViewPro();
    let micImage = ImageViewPro();
    let cameraImage = ImageViewPro();
    let sendImage = ImageViewPro();
    let optionsContainerView = UIView()
    var optionsContainerBottomConstraint: NSLayoutConstraint!
    let sendImageBackgroundView = HighlightedButton()
    
    // mic
    let micView = AudioRecorderView()
    
    // audio
    var audios: [AudioObject] = []
    var audioPlayer: AVAudioPlayer?
    var playingAudio: AudioObject?
    
    
    //internet variables
    let network = NetworkManager.sharedInstance
    
    var longPressGestrueRecognaizer: UILongPressGestureRecognizer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
       // navigationItem.searchController = nil
//        self.isFetchingItems = true
        self.configureNavigationView()
        setBackgroundImage()
        
        
//        mapView = MapView()
        
        
        
        showMessages()
        
        configureTableView()

        //configureCollectionView()
        configureKeyboard()
        //options()
        optionSheet()
//        firstRender = true
//        tableView.automaticallyAdjustsScrollIndicatorInsets = false
//        tableView.prefetchDataSource = self
        //collectionView.layoutIfNeeded()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.scrollToBottom()
//        }
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        // check internet and server
        //configureNetwork() // stop it temporirly
//        isFetchingItems = false
        
    }
  
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if firstRender == true {
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001) {
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else {return}
//                self.firstRender = false
//                self.scrollToBottom()
//                self.isFetchingItems = false
//
//            }

        }

        
        
    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//    }

    
    func scrollToBottom() {
        
        if !sections.isEmpty {
            let lastSectionIndex = sections.count - 1
            let lastRowIndex = sectionMessages[sections[lastSectionIndex]]?.count ?? 0
            // Create the index path for the new row
            let indexPath = IndexPath(row: lastRowIndex - 1, section: lastSectionIndex)
    //        collectionView.scrollToItem(at: indexPath, at: .top, animated: false)
            tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        }
        
    }
    
    func scrollToTop() {
        if messages.isEmpty { return }
        let firstIndexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: firstIndexPath, at: .top, animated: false)
    }
    
    
    
    
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        navigationItem.largeTitleDisplayMode = .always
        #if compiler(>=5.1) // ios 13 and above
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground

            // Disable large title display mode
            //navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.standardAppearance = appearance
            if #available(iOS 15, *) {
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            }
        
        #else // ios under 13
            if let navigationController = self.navigationController {
                if responds(to: #selector(willMove(toParentViewController:))) {
                navigationController.navigationBar.barTintColor = .systemBackground
                } else {
                navigationController.navigationBar.tintColor = .systemBackground
                }
            }
        #endif
    }
    


}





extension ChatroomVC {
    

    func setBackgroundImage() {
        let backgroundImage = ImageViewPro(image: UIImage(named: "1400X1400_RED_ORANGE"))
        backgroundImage.contentMode = .left
        let scaleFactor: CGFloat = 1
        let scaledTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
            backgroundImage.transform = scaledTransform
        
        //backgroundImage.frame = view.bounds
        
        view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
       // view.sendSubviewToBack(backgroundImage)
    }
    
    
    
    func saveUpdatesToDisk(message: Message) {
        
        // json
//        saveMessagesToDisk(messages, fileName: fileName, folderName: diskPath)
        // SQLite
//        saveMessagesToDatabaseOnDisk(fileName: fileName, folderName: diskPath, messages: messages)
        // update single message:
        updateMessageInDatabaseOnDisk(fileName: fileName, folderName: messagesDiskPath, messageToUpdate: message, tableName: DataStore.shared.messagesTable)
    }
    
    
    func showMessages() {
        
        if let unWrappedChatroom = chatroom {
            let appName = DataStore.shared.appName
            messagesDiskPath = "\(appName)/chats/\(unWrappedChatroom.id)/messages"
            micView.audioFolderName = "\(appName)/chats/\(newChatroomId)/audios"
                
                let areMessagesSavedToDisk = areMessagesSavedToDisk(fileName: messagesDiskPath)
            
                if areMessagesSavedToDisk {
                    if let savedMessages = retrieveNumberOfMessagesFromDatabaseOnDisk(fileName: fileName, folderName: messagesDiskPath, limit: limit, offset: messagesOffset, tableName: DataStore.shared.messagesTable) {
                        self.messages = savedMessages
                        self.messagesOffset += limit
                        isFetchingItems = false
    //                  self.configureFetchedMessages(fetchedMessages: messages)
                        print("we are fetching messages from disk: "
                              //, savedMessages
                        )
                    } else {
                        print("saved messages error")
                    }

                }
            
        } else {
            let appName = DataStore.shared.appName
            let _ = createOrLoadFolder(folderName: "\(appName)/chats/\(newChatroomId)")
            micView.audioFolderName = "\(appName)/chats/\(newChatroomId)/audios"
        }
        

        
        
    }
    
    
}

