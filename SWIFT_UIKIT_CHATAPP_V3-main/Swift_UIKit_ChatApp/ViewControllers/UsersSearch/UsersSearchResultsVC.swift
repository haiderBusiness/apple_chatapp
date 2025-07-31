//
//  UsersSearchVC.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 18.6.2023.
//

import UIKit

private struct Cells {
    static let user_cell = "user_search_cell"
}

class UsersSearchResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var tableView: UITableView!
    
    var searchedUsers: [User] = [];
    
    var delegate: NavigateToNewChatroomDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Language.users
        configureTableView();
    }
    
    
    
    
    




    private func configureTableView () {
        // Create a table view
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 55;
    
        tableView.register(CustomSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "CustomSectionHeaderView")
        tableView.register(AddNewChatCell.self, forCellReuseIdentifier: Cells.user_cell)
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)

            
        
        
        tableView.separatorStyle = .none
        
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
        return Language.search_results
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomSectionHeaderView") as? CustomSectionHeaderView
            
            // Customize the header view if needed
            
            return headerView
        }


// MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chatViewController = ChatroomVC() // Instantiate the SecondViewController
        
        let user = searchedUsers[indexPath.row]

        
        // Push the SecondViewController onto the navigation stack
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: Language.back, style: .plain, target: nil, action: nil)
        // Push the SecondViewController onto the navigation stack
        chatViewController.receivedUser = user
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.navigateToNewChatroom(userData: user, Chatroom: nil)
        dismiss(animated: false, completion: nil)
        
    }

    
    
    // MARK: - UITableViewDelegate and UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.user_cell) as! AddNewChatCell
//        let sectionTitle = sections[indexPath.section]
//        if let usersInSection = sectionUsers[sectionTitle] {
            let user = searchedUsers[indexPath.row]
                cell.set(user: user, isSelecting: false)
//
//        }
        
        if indexPath.row != 0 {
            cell.separatorHeightConstraint.constant = 0.5
        } else if indexPath.row == 0 {
            cell.separatorHeightConstraint.constant = 0
        }
        
        cell.backgroundColor = .systemBackground
        
        return cell
        
            
    }


    func set(searchUsers: [User]) {
        searchedUsers = searchUsers;
        tableView.reloadData();
    }
    
    
    


}

