//
//  GroupCreationTableView.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 19.6.2023.
//

import UIKit

private struct Cell {
    static var cell_id = "cell_id"
}

extension CreateGroupInfoVC: UITableViewDataSource, UITableViewDelegate {
    
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        if let unwrapedHeaderView = self.headerView {
            unwrapedHeaderView.nameTextField.resignFirstResponder()
        }
    }
    
    
    
    func configureTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 55;
        tableView.backgroundColor = .systemGray6
        
//        tableView.isScrollEnabled = false
        
        tableView.register(CreationGroupParticipantCell.self, forCellReuseIdentifier: Cell.cell_id)
        
        
        headerView = GroupCreationHeader(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 300))
        tableView.tableHeaderView = headerView
        if let unwrapedHeaderView = headerView {
            unwrapedHeaderView.configureUI()
            
            unwrapedHeaderView.nameTextField.becomeFirstResponder()
            unwrapedHeaderView.optionDelegate = self
            unwrapedHeaderView.photoDelegate = self
            unwrapedHeaderView.nameTextField.delegate = self
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
               view.addGestureRecognizer(tapGesture)
        }
       
        
        
        self.view.addSubview(tableView)
        
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.cell_id) as! CreationGroupParticipantCell
        
        let user = participants[indexPath.row]
       
        cell.set(user: user)
        
        if indexPath.row != 0 {
            cell.configureSeparator()
        }
        
        //cell.configureColor()
        
        cell.backgroundColor = .systemGray6
        cell.removeButtonAction = { [weak self] in
            guard let indexPath = self?.tableView.indexPath(for: cell) else {
                   return
               }
               self?.removeItem(at: indexPath)
               
           }
//        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    func removeItem(at indexPath: IndexPath) {
        let user = self.participants[indexPath.item]
        
        self.participants.remove(at: indexPath.item)
        self.removeUserDelegate?.removeSelection(user:user, fromAll: true)
        
        
        
        // Update the table view with the removal
        tableView.performBatchUpdates({
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }, completion: nil)
        
    }
    
}



