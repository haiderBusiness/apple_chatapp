//
//  NewChatsTable.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 14.6.2023.
//

import UIKit


extension AddNewChatVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func configureTableHeader() {
        self.tableHeaderView = AddNewChatTableHeader(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 150))
        self.tableHeaderView.addNewChatDelegate = addNewChatDelegate
        self.tableHeaderView.navigationDelegate = self.delegate
        self.tableHeaderView.navigation = self.navigationController
        self.tableHeaderView.navigationItem = self.navigationItem
        self.tableHeaderView.isSelecting = false
        self.tableHeaderView.backgroundColor = .red
        tableView.tableHeaderView = tableHeaderView
        //header.delegate = self
    }
    
    func configureTableView () {
        // Create a table view
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 55;
        tableView.backgroundColor = .systemGray6
        
        tableView.register(AddNewChatCell.self, forCellReuseIdentifier: ids.add_new_chat_cell)
        
        tableView.register(AddNewChatTableHeader.self, forHeaderFooterViewReuseIdentifier: ids.add_new_chat_table_header)
        view.addSubview(tableView)
        
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
            let constraints = [
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
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
        
//        tableView.stickySectionHeadersEnabled = true
        
//        if #available(iOS 11.0, *) {
//            tableView.separatorInsetReference = .fromCellEdges
//        } else {
//            tableView.separatorStyle = .singleLineEtched
//        }

        configureTableHeader()
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
                cell.set(user: user, isSelecting: false)
           
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
    
    
    // did select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        
        if let usersInSection = sectionUsers[section] {
            let user = usersInSection[indexPath.row]
            //print("here is the first name of him",user.firstName)
            self.delegate?.navigateToNewChatroom(userData: user, Chatroom: nil)
            dismiss(animated: false, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
//        chatViewController.modalPresentationStyle = .fullScreen
//
//        navigationController?.pushViewController(chatViewController, animated: true)
        
        
    }
}

