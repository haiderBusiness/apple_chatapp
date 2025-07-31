//
//  NewGroupTable.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 14.6.2023.
//

import UIKit


extension AddNewGroupVC: UITableViewDelegate, UITableViewDataSource {
    
    
  
    func configureTableView () {
        // Create a table view
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 55;
        tableView.backgroundColor = .systemGray6
        tableView.layer.zPosition = 1
        
        tableView.register(AddNewChatCell.self, forCellReuseIdentifier: ids.add_new_chat_cell)
        
//        tableView.register(GroupHeaderVC.self, forHeaderFooterViewReuseIdentifier: ids.add_new_chat_table_header)
//        tableView.tableHeaderView = headerView
        
        view.addSubview(tableView)
        
        
//        if let navigationController = navigationController {
//            print("here")
//            let searchBarHeight = searchController.searchBar.frame.height
//            tableView.contentInset = UIEdgeInsets(top: navigationController.navigationBar.frame.height + searchBarHeight, left: 0, bottom: 0, right: 0)
//               tableView.scrollIndicatorInsets = tableView.contentInset
//        }
        
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
            let constraints = [
                tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
                //tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
        
        
        //let tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 100))
                // Add and configure your three buttons within the tableHeaderView
                
                // Set the custom table header view
       
        
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
//        configureTableHeader()
        setupSectionsAndUsers()
        
    }
    
    
    
    
    
    func setupSectionsAndUsers() {
        // Sort users by first name
        let sortedUsers = users.sorted { $0.firstName < $1.firstName }
        
        // Group users by first letter of their first name
        let groupedUsers = Dictionary(grouping: sortedUsers) { String($0.firstName.prefix(1)).uppercased() }
        
        // Store section titles (letters) in an array
        sections = Array(groupedUsers.keys).sorted()
        
        // Store users under each section letter
        sectionUsers = groupedUsers
        
    }

    
    //MARK: - header view
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//            return self.header;
//    }
    

    // number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    // number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle = sections[section]
        return sectionUsers[sectionTitle]?.count ?? 0
    }
    
    
    
    // cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ids.add_new_chat_cell) as! AddNewChatCell
        let sectionTitle = sections[indexPath.section]
        if let usersInSection = sectionUsers[sectionTitle] {
            let user = usersInSection[indexPath.row]
                cell.set(user: user, isSelecting: true)
           
        }
        
        if indexPath.row != 0 {
            cell.separatorHeightConstraint.constant = 0.5
        } else if indexPath.row == 0 {
            cell.separatorHeightConstraint.constant = 0
        }
        
        cell.backgroundColor = .systemBackground
        
        return cell
    }
    
    
    
    
    // title for header in section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    //section index titles
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections
    }
    
    // section height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    
//    func configureTableHeader() {
//        headerView = GroupHeaderVC(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 90))
////        headerView.users = self.users
//        headerView.backgroundColor = .systemGray6
//        tableView.tableHeaderView = headerView
//        headerView.updateSelectedUsersDelegate = self
//    }
    
    
    
    // did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        
        if let usersInSection = sectionUsers[section] {
            let user = usersInSection[indexPath.row]
            
            // Check if the selected state has changed
            if user.isSelected {
                // Deselect the user
                deselectUser(user, indexPath: indexPath)
            } else {
                // Select the user
                selectUser(user, indexPath: indexPath)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func selectUser(_ user: User, indexPath: IndexPath) {
        guard let index = users.firstIndex(where: { $0.id == user.id }) else {
            return
        }
        
        users[index].isSelected = true
        setupSectionsAndUsers()
        //print("here is the user we are selecting: ",users[index].firstName)
        addedUsers.append(user)
        self.showHeader()
        checkSearchResults(user: users[index])
        title = addedUsers.count > 0 ? "\(addedUsers.count) \(Language.selected)" : Language.group_members
        
        // Batch updates
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
        
        headerView.addNewUser(newItem: user)
    }

    func deselectUser(_ user: User, indexPath: IndexPath) {
        guard let index = users.firstIndex(where: { $0.id == user.id }) else {
            return
        }
        
        users[index].isSelected = false
        setupSectionsAndUsers()
        
        if let addedIndex = addedUsers.firstIndex(where: { $0.id == user.id }) {
            addedUsers.remove(at: addedIndex)
            self.hideHeader()
            checkSearchResults(user: users[index])
            title = addedUsers.count > 0 ? "\(addedUsers.count) \(Language.selected)" : Language.group_members
            
            // Batch updates
            
            
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            headerView.removeItem(at: IndexPath(item: addedIndex, section: 0))
        }
    }
}




