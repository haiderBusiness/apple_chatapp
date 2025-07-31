//
//  ChatsSearchResultsVC.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 2.6.2023.
//

import UIKit

private struct Cells {
    static let chat_room_cell = "chat_room_search_cell"
}

class ChatsSearchResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tableView: UITableView!
    
    var searchedChats: [ChatRoom] = [];
    
    var navigation: UINavigationController?
    var navigationItemInstance: UINavigationItem?;

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView();
    }
    
    
    
    
    




    private func configureTableView () {
        // Create a table view
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100;
        
        tableView.register(ChatsCell.self, forCellReuseIdentifier: Cells.chat_room_cell)
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
            let constraints = [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
        
    }


    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
     }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Set the height of the section header
        return 30
    }
    
    // title for header in section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Language.chats
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
//
//        let padding = CGFloat(15)
//
//        let titleLabel = UILabel(frame: CGRect(x: padding, y: 0, width: headerView.bounds.width - 2 * padding, height: headerView.bounds.height))
//        titleLabel.text = Language.chats
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
//
//        headerView.addSubview(titleLabel)
//
//        return headerView
//    }



// MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        let userId = searchedChats[indexPath.row].usersIds.first(where: {$0 != DataStore.shared.user.id})
        let user = DataStore.shared.users.first(where: {$0.id == userId})
        // Push the SecondViewController onto the navigation stack
 
        navigationItemInstance?.backBarButtonItem = UIBarButtonItem(
            title: Language.back, style: .plain, target: nil, action: nil)
        
        let chatViewController = ChatroomVC() // Instantiate the SecondViewController
        chatViewController.receivedUser = user
        
        tableView.deselectRow(at: indexPath, animated: true)
        navigation?.pushViewController(chatViewController, animated: true)
    }

    
    
    // MARK: - UITableViewDelegate and UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedChats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.chat_room_cell) as! ChatsCell;
        
        let userId = searchedChats[indexPath.row].usersIds.first(where: {$0 != DataStore.shared.user.id})
        let user = DataStore.shared.users.first(where: {$0.id == userId})
        
        if let userData = user {
            let chat = searchedChats[indexPath.row]
            cell.set(chat: chat,user: userData, isSelecting: false)
            return cell
        } else {
            return UITableViewCell()
        }
        
            
    }


    func set(searchChats: [ChatRoom]) {
        searchedChats = searchChats;
        tableView.reloadData();
    }
    
    
    


}
