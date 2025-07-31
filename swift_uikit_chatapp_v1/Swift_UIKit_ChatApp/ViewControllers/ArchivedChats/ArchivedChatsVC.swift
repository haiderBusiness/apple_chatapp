//
//  ArchivedChatsVC.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 4.6.2023.
//

import UIKit



class ArchivedChatsVC: UIViewController, UISearchResultsUpdating, UISearchControllerDelegate {
    
    var delegate : UpdateArchivedChatsDelegate?
    let emptyLabel = UILabel();

    var navViewController = UINavigationController();
    var tableView: UITableView!
    var archivedChatrooms: [ChatRoom] = [];
    var chatrooms: [ChatRoom] = []
    var searchController = UISearchController(searchResultsController: ChatsSearchResultsVC());
    
    var rightNavigatoinButton = UIBarButtonItem()
    
    var isSelecting: Bool = false;
    var bottomFooterView = UIView()
    var bottomFooterConstraint: NSLayoutConstraint!;
    var readAllButton = UIButton(type: .system)
    var unarchiveButton = UIButton(type: .system)
    var deleteButton = UIButton(type: .system)
    var selectedIndexPaths: [IndexPath] = [];
    var selectedChats: [ChatRoom] = []
    var hasUnread = false;
    
    var limit = 80
    var offset = 0
    var fileName = "archivedChats.db"
    var diskPath: String!
    
    var user: User!

    let header = ArchivedChatsTableVH();
    
    var loadingStatus: ChatsLoadingEnum = .waitingForNetwork

    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = DataStore.shared.user
        if !archivedChatrooms.isEmpty {
            print("here we go___",archivedChatrooms[0].usersIds[1])
            print(user.firstName)
        }
        
        fetchArchivedChatrooms()
        
        view.backgroundColor = .systemBackground;
        
        title = Language.archived_chats;

        //searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        //self.createEmptyLabel()
        configureNavigation();
        sortChatrooms()
        configureTableView();
        self.createBottomFooter()
    }
    
    
    
    func fetchArchivedChatrooms() {
//        let fileName = "archivedChats.json"
        
        let appName = DataStore.shared.appName
        diskPath = "\(appName)/chats"
        
        let areArchivedChatroomsSavedToDisk = areChatroomsSavedToDisk(fileName: diskPath + "/" + fileName)

        // remove messages from disk temporerlly
//        removeMessagesFromDisk(fileNameString: "messages.json")
        
        
        if areArchivedChatroomsSavedToDisk {
            let retrievedChats = retrieveChatroomsFromDatabaseOnDisk(fileName: fileName, folderName: diskPath, limit: limit, offset: offset, tableName: DataStore.shared.archivedChatsTable)
            if let retrievedChats = retrievedChats {
                archivedChatrooms.append(contentsOf: retrievedChats)
            }
        }
        
    }
    
    
    func updateChatsInDatabaseOnDisk(chatrooms: [ChatRoom]) {
        // update multiple chatrooms in database on disk
        updateChatroomsInDatabaseOnDisk(fileName: fileName, folderName: diskPath, chatroomsToUpdate: chatrooms, tableName: DataStore.shared.archivedChatsTable)
    }
    
    
    func checkIfEmpty() {
        if archivedChatrooms.count > 0 {
            UIView.transition(with: emptyLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.emptyLabel.alpha = 0
            }, completion: nil)
        } else {
            UIView.transition(with: emptyLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.emptyLabel.alpha = 1
            }, completion: nil)
        }
    }



func sortChatrooms() {
    
    if archivedChatrooms.count > 0 {
        UIView.transition(with: emptyLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.emptyLabel.alpha = 0
        }, completion: nil)
        archivedChatrooms.sort { (room1, room2) in
            if room1.pinned && !room2.pinned {
                return true
            } else if !room1.pinned && room2.pinned {
                return false
            } else if room1.pinned && room2.pinned {
                return room1.pinnedAt > room2.pinnedAt
            } else {
                return room1.lastMessageDate > room2.lastMessageDate
            }
        }
    }
    
}

    
    
    var headerEditButton: UIBarButtonItem!
    
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
    



    func configureNavigation()  {
        
        editButtonView.addTarget(self, action: #selector(onEditButtonPress), for: .touchUpInside)
        editButtonView.addSubview(editLabel)
        
        let customEditNav = UIBarButtonItem(customView: editButtonView)

        NSLayoutConstraint.activate([
            editLabel.centerXAnchor.constraint(equalTo:   editButtonView.centerXAnchor),
            editLabel.centerYAnchor.constraint(equalTo:   editButtonView.centerYAnchor),
        ])
        
        navigationItem.rightBarButtonItems = [customEditNav]
    }



    @objc func onEditButtonPress() {
       hideOrUnhideSelection()
        
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
            self.selectedIndexPaths = []
            hasUnread = false
            self.configureBottomFooter()
            for (index, chatroom) in self.archivedChatrooms.enumerated() {
                if chatroom.selected {
                    self.archivedChatrooms[index].selected = false
                }
            }
            
            UIView.transition(with: editLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.editLabel.text = Language.edit
            }, completion: nil)
            
        } else {
            isSelecting = true
            slidUpBottomFooter()
            UIView.transition(with: editLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.editLabel.text = Language.done
            }, completion: nil)

        }
        
        self.tableView.reloadData()
    }
    




    private func configureTableView () {
        // Create a table view
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100;
        tableView.backgroundColor = .systemBackground
        
        tableView.register(ChatsCell.self, forCellReuseIdentifier: ids.chat_room_cell)
        
        tableView.register(ChatsTableHeader.self, forHeaderFooterViewReuseIdentifier: ids.archived_table_header)
        
        
        view.addSubview(tableView)
        
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
            let constraints = [
                tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
        
    }

    



    func updateSearchResults(for searchController: UISearchController) {
    
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
            
            let searchResults = archivedChatrooms.filter { chatRoom in
                
                let otherUserId = chatRoom.usersIds.first(where: {$0 != user.id})
                let otherUser = DataStore.shared.users.first(where: {$0.id == otherUserId})
                if let name = otherUser?.firstName {
                    return name.lowercased().contains(searchText.lowercased())
                } else {
                    return false
                }
               
            }
            
                if !searchResults.isEmpty {
                //print("Found matching chat rooms:")
//                for chatRoom in searchResults {
//                    print(chatRoom.name)
//                }
                
                    let vc = searchController.searchResultsController as! ChatsSearchResultsVC;
                    vc.navigation = self.navigationController
                    vc.navigationItemInstance = navigationItem
                    vc.set(searchChats: searchResults)
            }
        
        
    }
    
    
    func presentSearchController(_ searchController: UISearchController) {
        if isSelecting  {
            slidDownBottomFooter()
            self.title = Language.archived_chats
            isSelecting = false
            self.selectedIndexPaths = []
            hasUnread = false
            self.configureBottomFooter()
            for (index, chatroom) in self.chatrooms.enumerated() {
                if chatroom.selected {
                    self.chatrooms[index].selected = false
                }
            }
            
            UIView.transition(with: editLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.editLabel.text = Language.edit
            }, completion: nil)
            self.tableView.reloadData()
        }
    }


}


extension ArchivedChatsVC {
    
    func createEmptyLabel() {
        self.view.addSubview(self.emptyLabel)
        emptyLabel.text = "There are no active chats you have";
        emptyLabel.textColor = .systemGray4
        let font = UIFont.systemFont(ofSize: 17)
        let scaledFont = UIFontMetrics.default.scaledFont(for: font)
        emptyLabel.font = scaledFont
        emptyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}

extension ArchivedChatsVC {
    
    func updateChatsToDisk() {
        // update archived chats to disk
        let appName = DataStore.shared.appName
        let diskPath = "\(appName)/chats"
        let fileName = "archivedChats.json"
        saveChatroomsToDisk(archivedChatrooms, fileName: fileName, folderName: diskPath)
    }
}
