//
//  AddNewGroupVC.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 14.6.2023.
//

import UIKit



class AddNewGroupVC: UIViewController {

    
    
    var addNewChatDelegate: NewChatAddedProtocol!
    
    var navigationDelegate: NavigateToNewChatroomDelegate?
    
    let headerView = GroupHeaderVC()
    
    var tableView: UITableView!
   
    var navigation: UINavigationController!;
    
    var tableHeaderView: AddNewChatTableHeader!;
    
    var users: [User] = []
    var sections: [String] = []   // Array to store section titles (letters)
    var sectionUsers: [String: [User]] = [:]   // Dictionary to store users grouped by section
    
    var selectedIndexPaths: [IndexPath] = []
    var addedUsers: [User] = []
    
    var headerHeightConstraint: NSLayoutConstraint!
    
    
//    let searchResultsVC = GroupUsersSearchResultsVC()
    
    let searchResultsVC = GroupUsersSearchView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray6
        self.title = Language.group_members
        
       
       
        configureNavigation()
        users = generateDummyUsers()
        configureTableHeader()
        configureTableView()
        setSearchBar()
        
    }
    
    

    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if #available(iOS 11.0, *) {
//            navigationItem.hidesSearchBarWhenScrolling = true
//        }
//    }
    
   
    


    func configureNavigation()  {
        
        
//        navigationItem.leftBarButtonItem =  UIBarButtonItem(title: Language.cancel, style: .plain, target: self, action: #selector(onCancelButtonPress))
//        navigationItem.leftBarButtonItem?.tintColor = AppTheme.primaryColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Language.next, style: .plain, target: self, action: #selector(onNextButtonPress))
        
        navigationItem.rightBarButtonItem?.tintColor = .systemGray4
    }
    
    @objc func onCancelButtonPress() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onNextButtonPress() {
        if(addedUsers.count > 0) {

            let creationGroupProfileVC = CreateGroupInfoVC() // Replace YourViewController with the actual view controller you want to present modally
            creationGroupProfileVC.removeUserDelegate = self
            creationGroupProfileVC.participants = addedUsers
            creationGroupProfileVC.navigationDelegate = navigationDelegate
            creationGroupProfileVC.addNewChatDelegate = addNewChatDelegate
            
              navigationItem.backBarButtonItem = UIBarButtonItem(title: Language.back, style: .plain, target: nil, action: nil)
              
              navigationController?.navigationBar.tintColor = AppTheme.primaryColor
              
              navigationController?.pushViewController(creationGroupProfileVC, animated: true)
            
//            let navigationController = UINavigationController(rootViewController: creationGroupProfileVC)
//
//
//            // Present the navigationController modally
//            present(navigationController, animated: true, completion: nil)
            
        }
       
    }
    
    
}


extension AddNewGroupVC {
    
    
    func configureTableHeader() {

        self.view.addSubview(headerView)
        headerView.backgroundColor = .systemGray6
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        headerView.alpha = 0
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 0)
        headerHeightConstraint.isActive = true
        headerView.setupCollectionView();
        headerView.updateSelectedUsersDelegate = self
        
    }
    
    
    func showHeader() {
        
        if addedUsers.count >= 1 {
            headerView.alpha = 1
            headerHeightConstraint.constant = 90
            navigationItem.rightBarButtonItem?.tintColor = AppTheme.primaryColor
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func hideHeader() {
        if addedUsers.count == 0 {
            headerView.alpha = 0
            headerHeightConstraint.constant = 0
            navigationItem.rightBarButtonItem?.tintColor = .systemGray4
            
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
}



extension AddNewGroupVC: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate  {
    
    
    
    func configureSearcResltsView () {
        view.addSubview(searchResultsVC)
        searchResultsVC.translatesAutoresizingMaskIntoConstraints = false
        
        searchResultsVC.backgroundColor = .systemGray6
        
            let constraints = [
                searchResultsVC.topAnchor.constraint(equalTo: headerView.bottomAnchor),
                //tableView.topAnchor.constraint(equalTo: view.topAnchor),
                searchResultsVC.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                searchResultsVC.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                searchResultsVC.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
            NSLayoutConstraint.activate(constraints)
        
        searchResultsVC.configureTableView()
        searchResultsVC.delegate = self
        searchResultsVC.isUserInteractionEnabled = false
    }
    
    
    func setSearchBar() {
        let searchController = UISearchController(searchResultsController: nil);
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.hidesNavigationBarDuringPresentation = false
//        navigationController?.navigationBar.isTranslucent = true
        configureSearcResltsView()
    }
    
    
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return false
    }
    
    
    
    
    func updateSearchResults(for searchController: UISearchController) {
    
        guard let searchText = searchController.searchBar.text else {
            return
        }
    
        let searchResults = users.filter { user in
            let name = user.firstName
                return name.lowercased().contains(searchText.lowercased())
        }

        if !searchResults.isEmpty {
            for user in searchResults {
                print("userData here: ________________________________________________ ", user)
            }
            searchResultsVC.set(searchUsers: searchResults)
//            searchResultsVC.tableView.reloadData()
            searchResultsVC.layer.zPosition = 2
            searchResultsVC.isUserInteractionEnabled = true
        } else {
            searchResultsVC.layer.zPosition = 0
            searchResultsVC.isUserInteractionEnabled = false
        }
    }
    
    
}



