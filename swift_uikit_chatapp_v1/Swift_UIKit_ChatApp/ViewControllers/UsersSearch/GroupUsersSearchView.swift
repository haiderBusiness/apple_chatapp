//
//  GroupUsersSearchVC.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 18.6.2023.
//

import UIKit

private struct Cells {
    static let user_cell = "user_search_cell"
}



class GroupUsersSearchView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    
    var tableView: UITableView!
    
    var searchedUsers: [User] = [];
    
    var delegate: AddUserProtocol?


    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.title = Language.users
//        configureTableView();
//    }
    
    
    
    
    




     func configureTableView () {
        // Create a table view
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 55;
    
        tableView.register(CustomSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "CustomSectionHeaderView")
        tableView.register(AddNewChatCell.self, forCellReuseIdentifier: Cells.user_cell)
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
            let constraints = [
                tableView.topAnchor.constraint(equalTo: topAnchor),
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
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


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        
            let user = searchedUsers[indexPath.row]
        
            let cell = tableView.cellForRow(at: indexPath) as! AddNewChatCell
            
            // Check if the selected state has changed
            if user.isSelected {
                // Deselect the user
//                deselectUser(user, indexPath: indexPath)
                searchedUsers[indexPath.row].isSelected = false
                cell.set(user: searchedUsers[indexPath.row], isSelecting: true)
                delegate?.selectUser(user: searchedUsers[indexPath.row], isSelected: false)
                
            } else {
                // Select the user
                searchedUsers[indexPath.row].isSelected = true
                cell.set(user: searchedUsers[indexPath.row], isSelecting: true)
                delegate?.selectUser(user: searchedUsers[indexPath.row], isSelected: true)
//                selectUser(user, indexPath: indexPath)
            }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func selectUser(_ user: User, indexPath: IndexPath) {
//        guard let index = searchedUsers.firstIndex(where: { $0.id == user.id }) else {
//            return
//        }
        
        searchedUsers[indexPath.row].isSelected = true
        //print("here is the user we are selecting: ",users[index].firstName)
        // Batch updates
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    func deselectUser(_ user: User, indexPath: IndexPath) {
        
            searchedUsers[indexPath.row].isSelected = false
            
        }

    
    
    // MARK: - UITableViewDelegate and UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.user_cell) as! AddNewChatCell

        let user = searchedUsers[indexPath.row]
        cell.set(user: user, isSelecting: true)
        
        
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



