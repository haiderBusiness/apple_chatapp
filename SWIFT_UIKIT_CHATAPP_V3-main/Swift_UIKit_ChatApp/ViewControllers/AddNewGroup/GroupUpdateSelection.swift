//
//  UpdateSelection.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 18.6.2023.
//

import UIKit





extension AddNewGroupVC: UpdateSelectedUsersProtocol {
    
    
    func checkSearchResults(user: User) {
        let foundIndex = self.searchResultsVC.searchedUsers.firstIndex(where: {$0.id == user.id})
        
        //print("user removed: ", user.firstName, user.isSelected)
        
        if let index = foundIndex {
            let cell = self.searchResultsVC.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! AddNewChatCell
            
            self.searchResultsVC.searchedUsers[index].isSelected = user.isSelected
            cell.set(user: searchResultsVC.searchedUsers[index], isSelecting: true)
        }
    }
    
    
    func specifcDeselectUser(_ user: User, indexPath: IndexPath) {
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
        }
    }
    
    func removeSelection(user: User, fromAll: Bool) {
       
//        let origianlUserIndex = users.firstIndex(where: { $0.id == user.id })
//        if let unWrapedUserIndex = origianlUserIndex {
//            users[unWrapedUserIndex].isSelected = false
//        }
        //print("user first letter: ", user.firstName.prefix(1).uppercased())
        let sectionIndex = self.sections.firstIndex(where: {$0.hasPrefix(user.firstName.prefix(1).uppercased())});
        
        let section = self.sections.first(where: {$0.hasPrefix(user.firstName.prefix(1).uppercased())});
        
       // print("here is the section's users: ", section ?? "no section title found, ", sectionIndex ?? "no section index found")
       
        if let unWrapedSection = section, let sectionIndex = sectionIndex {
            
            //print("here is the section's users: ", unWrapedSection, sectionIndex)
            
            if let usersInSection = sectionUsers[unWrapedSection] {
                if let userIndex = usersInSection.firstIndex(where: {$0.id == user.id}) {
                    
                    let indexPath = IndexPath(row: userIndex, section: sectionIndex)
                    
                    if fromAll {
                        self.deselectUser(user, indexPath: indexPath)
                    } else {
                        specifcDeselectUser(user, indexPath: indexPath)
                    }
                   
                }
            }
        }

    }
}







protocol AddUserProtocol {
    func selectUser(user: User, isSelected: Bool)
}

extension AddNewGroupVC: AddUserProtocol {
    
    
    
    func selectUser(user: User, isSelected: Bool) {
       
//        let origianlUserIndex = users.firstIndex(where: { $0.id == user.id })
//        if let unWrapedUserIndex = origianlUserIndex {
//            users[unWrapedUserIndex].isSelected = false
//        }
        //print("user first letter: ", user.firstName.prefix(1).uppercased())
        let sectionIndex = self.sections.firstIndex(where: {$0.hasPrefix(user.firstName.prefix(1).uppercased())});
        
        let section = self.sections.first(where: {$0.hasPrefix(user.firstName.prefix(1).uppercased())});
        
       // print("here is the section's users: ", section ?? "no section title found, ", sectionIndex ?? "no section index found")
       
        if let unWrapedSection = section, let sectionIndex = sectionIndex {
            
            //print("here is the section's users: ", unWrapedSection, sectionIndex)
            
            if let usersInSection = sectionUsers[unWrapedSection] {
                if let userIndex = usersInSection.firstIndex(where: {$0.id == user.id}) {
                    
                    let indexPath = IndexPath(row: userIndex, section: sectionIndex)
                    if isSelected {
                        selectUser(user, indexPath: indexPath)
                    } else {
                        deselectUser(user, indexPath: indexPath)
                    }
                   
                }
            }
        }

    }
}

