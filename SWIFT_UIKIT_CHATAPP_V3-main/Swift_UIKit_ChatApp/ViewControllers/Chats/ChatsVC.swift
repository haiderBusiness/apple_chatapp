//
//  ViewController.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 28.5.2023.


import UIKit

var nameOfThisFile: String = "ChatsVC"

class ChatsVC: UIViewController, UISearchResultsUpdating, UISearchControllerDelegate {
    
        //var store: Store!
    
    

    
    let emptyMessageView = EmptyMessageView()
    
    var navViewController = UINavigationController();
    var tableView: UITableView!
    var chatrooms: [ChatRoom] = [];
//    var archivedChatrooms: [ChatRoom] = []
    let headerView = UIView()
    var searchController = UISearchController(searchResultsController: ChatsSearchResultsVC());
    var rightNavigatoinButton = UIBarButtonItem()
    let header = ChatsTableHeader();
    var isSelecting: Bool = false;
    var bottomFooterView = UIView()
    var bottomFooterConstraint: NSLayoutConstraint!;
    var readAllButton = UIButton(type: .system)
    var archiveButton = UIButton(type: .system)
    var deleteButton = UIButton(type: .system)
    var selectedIndexPaths: [IndexPath] = [];
    var selectedChats: [ChatRoom] = []
    var hasUnread = false;

    var user: User!
    var showArchivedChatsButton = false
    
    var pinnedChatsNumber = 0


    
    var diskPath: String!
//    let fileName = "chats.json"
    let fileName = "chats.db"
    let archivedfileName = "archivedChats.db"
    
    let chatroomsLimit = 50
    var chatroomsOffset = 0
    
    var loadingStatus : ChatsLoadingEnum = .waitingForNetwork
    
    let network = NetworkManager.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
        
        view.backgroundColor = .systemBackground;
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemBackground
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController?.navigationBar.tintColor = .systemBackground
        }
        
        
        user = DataStore.shared.user

        configureNavigation();
        // change navigation configuration
        //chatrooms = GenerateRandomChatRooms.generate().sorted { $0.date > $1.date };
        //chatrooms = store.state.chatrooms;
        //chatrooms = DataStore.shared.chatrooms
        
        self.saveLoadChatrooms()
         //configureNetwork() //check network connection  //stop it temporirly
        //archivedChatrooms.append(ChatRoom(id: UUID(), name: "test", avatar: "https://randomuser.me/api/portraits/women/1.jpg", lastMessage: "Test", unreadCount: 1, lastMessageDate: Date(), selected: false, archived: true, markUnRead: false, muted: false, pinned: false, pinnedAt: Date(), editedAt: nil, deletedAt: nil, createdAt: Date()))

        
        //configureArchived();
        //updateDate()
        //configureSearchBar();
       
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
        //self.navigationItem.largeTitleDisplayMode = .never
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    
    func configureTableHeader() {
        
        header.navigation = self.navigationController
        header.isSelecting = isSelecting
//        header.archivedChatrooms = self.archivedChatrooms
        header.configureButton()
        header.chatrooms = self.chatrooms
        header.delegate = self
        header.loadingStatus = loadingStatus
    }
    
    
        
    
    //headerEditButton.addTarget(self, action: #selector(headerEditButtonTapped), for: .touchUpInside)
    var headerEditButton: UIBarButtonItem!
    var headerAddChatButton: UIBarButtonItem!
    
    let editButtonView = UIButton(type: .system)
    let editLabel: UILabel = {
        let editLabel = UILabel()
        editLabel.translatesAutoresizingMaskIntoConstraints = false
        editLabel.text = Language.edit
        editLabel.textColor = AppTheme.primaryColor
        let font = UIFont.systemFont(ofSize: 17)
        let scaledFont = UIFontMetrics.default.scaledFont(for: font)
        editLabel.font = scaledFont
        return editLabel
    }();
    
    let addChatButtonView = UIButton(type: .system)

    let addChatIcon: ImageViewPro = {
        var addChatIcon = ImageViewPro()
        addChatIcon.translatesAutoresizingMaskIntoConstraints = false;
        addChatIcon.image = UIImage(systemName: "square.and.pencil")
        addChatIcon.tintColor = AppTheme.primaryColor
        return addChatIcon
    }()
    
    var edit: UIBarButtonItem?
    var createChat: UIBarButtonItem?
    
        
    
    func configureNavigation()  {
        
        editButtonView.addTarget(self, action: #selector(onEditButtonPress), for: .touchUpInside)
        editButtonView.addSubview(editLabel)
        
        
        addChatButtonView.addTarget(self, action: #selector(onAddChatButtonPress), for: .touchUpInside)
        addChatButtonView.addSubview(addChatIcon)
        
        addChatIcon.widthAnchor.constraint(lessThanOrEqualToConstant: 26).isActive = true
        addChatIcon.heightAnchor.constraint(lessThanOrEqualToConstant: 26).isActive = true
        addChatIcon.widthAnchor.constraint(greaterThanOrEqualToConstant: 26).isActive = true
        addChatIcon.heightAnchor.constraint(greaterThanOrEqualToConstant: 26).isActive = true
        
        
        let customEditNav = UIBarButtonItem(customView: editButtonView)
//        let customAddChatNav = UIBarButtonItem(customView: addChatButtonView)

        NSLayoutConstraint.activate([
            editLabel.centerXAnchor.constraint(equalTo:   editButtonView.centerXAnchor),
            editLabel.centerYAnchor.constraint(equalTo:   editButtonView.centerYAnchor),
            addChatIcon.centerXAnchor.constraint(equalTo: addChatButtonView.centerXAnchor),
            addChatIcon.centerYAnchor.constraint(equalTo: addChatButtonView.centerYAnchor),
        ])
        
//        navigationItem.rightBarButtonItems = [customAddChatNav, customEditNav]
        navigationItem.leftBarButtonItems = [customEditNav]
        
         edit = UIBarButtonItem(title: Language.edit, style: .plain, target: self, action: #selector(onEditButtonPress))
        
         createChat = UIBarButtonItem(title: Language.new, style: .plain, target: self, action: #selector(onAddChatButtonPress))
        
        
        createChat?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppTheme.primaryColor], for: .normal)
        edit?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppTheme.primaryColor], for: .normal)
        
//        createChat.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppTheme.primaryColor], for: .normal)
        
        navigationItem.rightBarButtonItem = createChat
        navigationItem.leftBarButtonItem = edit
        
    }



    @objc func onEditButtonPress() {
        print("here")
        if chatrooms.count > 0 {
            hideOrUnhideSelection()
        }
    }

    func slidUpBottomFooter() {
        
            bottomFooterConstraint.constant = 0
            //bottomFooterView.alpha = 1
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        
    }

    func slidDownBottomFooter() {
        bottomFooterConstraint.constant = 100
        //bottomFooterView.alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }



    func hideOrUnhideSelection() {

        if isSelecting  {
            slidDownBottomFooter()
            self.title = Language.chats
            isSelecting = false
            configureTableHeader()
            self.selectedIndexPaths = []
            hasUnread = false
            configureBottomFooter()
            for (index, chatroom) in self.chatrooms.enumerated() {
                if chatroom.selected {
                    self.chatrooms[index].selected = false
                }
            }
            
            // change left navigation button title to edit
            edit?.title = Language.edit
            navigationItem.rightBarButtonItem = createChat
            
        } else {
            
            isSelecting = true
            configureTableHeader()
//            let customEditNav = UIBarButtonItem(customView: self.editButtonView)
//            self.navigationItem.rightBarButtonItems = [customEditNav]
            slidUpBottomFooter()
            
            // change left navigation button title to done
            edit?.title = Language.done
            
            navigationItem.rightBarButtonItem = nil
            
        }
        
        self.tableView.reloadData()
    }
    
        
        
        
    @objc func onAddChatButtonPress() {
        let addNewChatVC = AddNewChatVC() // Replace YourViewController with the actual view controller you want to present modally
        addNewChatVC.delegate = self
        addNewChatVC.addNewChatDelegate = self
        let navigationController = UINavigationController(rootViewController: addNewChatVC)
       
        // Present the navigationController modally
        present(navigationController, animated: true, completion: nil)
    }
    

    
    
    
    

    
    
        
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
            let searchResults = chatrooms.filter { chatRoom in
                
                let otherUserId = chatRoom.usersIds.first(where: {$0 != user.id})
                let otherUser = DataStore.shared.users.first(where: {$0.id == otherUserId})
                if let name = otherUser?.firstName {
                    return name.lowercased().contains(searchText.lowercased())
                } else {
                    return false
                }
            }
            
                if !searchResults.isEmpty {
                print("Found matching chat rooms:")
//                for chatRoom in searchResults {
//                    //print(chatRoom.name)
//                }
                
                    let vc = searchController.searchResultsController as! ChatsSearchResultsVC;
                    vc.navigation = self.navigationController
                    vc.navigationItemInstance = navigationItem
                    vc.set(searchChats: searchResults)
            }
            
            
    }
    

    
    
    
    
    func presentSearchController(_ searchController: UISearchController) {
        if isSelecting {
            slidDownBottomFooter()
            self.title = Language.chats
            isSelecting = false
            configureTableHeader()
            self.selectedIndexPaths = []
            hasUnread = false
            configureBottomFooter()
            for (index, chatroom) in self.chatrooms.enumerated() {
                if chatroom.selected {
                    self.chatrooms[index].selected = false
                }
            }
            edit?.title = Language.edit
            navigationItem.rightBarButtonItem = createChat
            self.tableView.reloadData()
        }
    }
    
    
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            //navigationItem.hidesSearchBarWhenScrolling = true
            
            let offsetY = scrollView.contentOffset.y
        
        
            //Search bar
//            if offsetY >= 1{
//                navigationItem.hidesSearchBarWhenScrolling = true
//            }
            
            // header
            if offsetY >= headerView.frame.height {
                tableView.contentInset = UIEdgeInsets(top: -headerView.frame.height, left: 0, bottom: 0, right: 0)
            } else {
                tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
        }
    
    
    func navigateToNewChat() {
        let chatroomController = ChatroomVC()
        navigationController?.pushViewController(chatroomController, animated: true)
    }
    

}






//        private func configureArchived() {
//
//            for chatRoom in chatrooms {
//                // Check if the chat room is archived
//                if chatRoom.archived {
//
//                    // Add the archived chat room to the archiveArray
//                    //DataStore.shared.archivedChatrooms.append(chatRoom)
//                    archivedChatrooms.append(chatRoom)
//                }
//
//            }
//        }






//        private func updateDate() {
//            let updateDataProtocolDelegate = UpdateDataProtocolDelegate()
//                    #if swift(>=5.5)
//                    updateDataProtocolDelegate.delegate = self
//                    #else
//                    updateDataProtocolDelegate.delegate = self as UpdateDataProtocolDelegate
//                    #endif
//        }








//            headerAddChatButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"),
//                                              style: .plain,
//                                              target: self,
//                                              action: #selector(rightHeaderButtonTapped));

//            headerEditButton = UIBarButtonItem(title: Language.edit, style: .plain, target: self, action: #selector(headerEditButtonTapped))
//            headerEditButton.tintColor = AppTheme.primaryColor
            
            //headerAddChatButton.tintColor = AppTheme.primaryColor
    
   





//    func sortChatrooms() {
//
//        chatrooms = GenerateRandomChatRooms.generate()
//        chatrooms.sort { (room1, room2) in
//            if room1.pinned && !room2.pinned {
//                return true
//            } else if !room1.pinned && room2.pinned {
//                return false
//            } else if room1.pinIndex != -1 && room2.pinIndex != -1 {
//                return room1.pinIndex < room2.pinIndex
//            } else {
//                return room1.lastMessageDate > room2.lastMessageDate
//            }
//        }
//    }




