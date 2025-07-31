//
//  AddNewChatViewController.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 12.6.2023.
//

import UIKit



class AddNewChatVC: UIViewController {
    
    var delegate : NavigateToNewChatroomDelegate?
    
    var addNewChatDelegate: NewChatAddedProtocol!
    
   
    var tableView: UITableView!
   
    var navigation: UINavigationController!;
    
    var tableHeaderView: AddNewChatTableHeader!;
    
    var users: [User] = []
    var sections: [String] = []   // Array to store section titles (letters)
    var sectionUsers: [String: [User]] = [:]   // Dictionary to store users grouped by section
    
    
    let searchResultsVC = UsersSearchResultsVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        self.title = Language.new_chat
        setSearchBar()
        configureNavigation()
        users = DataStore.shared.users
        self.configureTableView()
    }
    
    
    
    
    func setSearchBar() {
        searchResultsVC.delegate = delegate
        let searchController = UISearchController(searchResultsController: searchResultsVC);
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
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
    
    
    
    var headerCancelButton: UIBarButtonItem!
    var headerAddChatButton: UIBarButtonItem!
    
    let cancelButtonView = UIButton(type: .system)
    let cancelLabel: UILabel = {
        let cancelLabel = UILabel()
        cancelLabel.translatesAutoresizingMaskIntoConstraints = false
        cancelLabel.text = Language.cancel
        cancelLabel.textColor = AppTheme.primaryColor
        let font = UIFont.systemFont(ofSize: 17)
        let scaledFont = UIFontMetrics.default.scaledFont(for: font)
        cancelLabel.font = scaledFont
        return cancelLabel
    }();
    

    


    

    func configureNavigation()  {
        
//        cancelButtonView.addTarget(self, action: #selector(onCancelButtonPress), for: .touchUpInside)
//        cancelButtonView.addSubview(cancelLabel)
//
//        let customCancelNav = UIBarButtonItem(customView: cancelButtonView)
//
//
//        NSLayoutConstraint.activate([
//            cancelButtonView.widthAnchor.constraint(equalTo: cancelLabel.widthAnchor, constant: 5),
//            cancelLabel.leadingAnchor.constraint(equalTo: cancelButtonView.leadingAnchor, constant: 5)
//        ])
        
        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: Language.cancel, style: .plain, target: self, action: #selector(onCancelButtonPress))
        navigationItem.leftBarButtonItem?.tintColor = AppTheme.primaryColor
    }
    
    @objc func onCancelButtonPress() {
        dismiss(animated: true, completion: nil)
    }
    
    
}



extension AddNewChatVC: UISearchResultsUpdating, UISearchControllerDelegate {
    
    
    func updateSearchResults(for searchController: UISearchController) {
    
        guard let searchText = searchController.searchBar.text else {
            return
        }
    
        let searchResults = users.filter { user in
            let name = user.firstName
                return name.lowercased().contains(searchText.lowercased())
        }

        if !searchResults.isEmpty {
        
            let vc = searchController.searchResultsController as! UsersSearchResultsVC;
            vc.set(searchUsers: searchResults)
       }
    }
    
    
}

