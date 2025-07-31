//
//  GroupHeaderVC.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 15.6.2023.
//

import UIKit


class GroupHeaderVC: UIView {
    
//class GroupHeaderVC: UITableViewHeaderFooterView {
    
    static let identifier = ids.table_header;

        var collectionView: UICollectionView!

        var users: [User] = []
    
        var updateSelectedUsersDelegate: UpdateSelectedUsersProtocol?
        
        let itemCellIdentifier = "ItemCell"
    
        var mainView: UITableViewHeaderFooterView!

        
//    override init(reuseIdentifier: String?) {
//        super.init(reuseIdentifier: reuseIdentifier)
//            setupCollectionView();
//        }
//    
    
    
        func setupCollectionView() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.backgroundColor = .systemGray6

            collectionView.delegate = self
            collectionView.dataSource = self
            
            collectionView.register(GroupHeaderCell.self, forCellWithReuseIdentifier: itemCellIdentifier)
            
            collectionView.showsHorizontalScrollIndicator = false
            
            // space to end and begening of the scrolling
            collectionView.contentInset = UIEdgeInsets(top: 0, left:8, bottom: 0, right: 12)
            
            addSubview(collectionView)
   
            NSLayoutConstraint.activate([
                        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                        collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
                        collectionView.heightAnchor.constraint(equalToConstant: 90)
                    ])
        }
    
    
    
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
}


extension GroupHeaderVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as! GroupHeaderCell
        let user = users[indexPath.item]

        cell.configure(with: user)
//        cell.backgroundColor = .red
        cell.backgroundColor = .systemGray6
        
        cell.removeButtonAction = { [weak self] in
            guard let indexPath = self?.collectionView.indexPath(for: cell) else {
                   return
               }
               self?.removeItem(at: indexPath)
               
           }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
//        if indexPath.row == 0 {
//            self.layoutIfNeeded()
//             itemWidth = CGFloat(90)
//        } else if indexPath.row == users.count - 1 {
//            self.layoutIfNeeded()
//            itemWidth = CGFloat(78)
//        }
//        else {
//            self.layoutIfNeeded()
//            itemWidth = CGFloat(60)
//        }
        
        //  Adjust the item width as per your requirements
        let itemWidth = CGFloat(60)
        let itemHeight = CGFloat(90)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    
    
    func addNewUser(newItem: User) {
        self.users.append(newItem)
        //print("here are the users: ", users[self.users.count - 1].firstName)
        // Step 2: Insert a new item
        let indexPath = IndexPath(item: self.users.count - 1, section: 0)
        
        //print("here is the IndexPath: ", indexPath)
        collectionView.insertItems(at: [indexPath])
    }

}




extension GroupHeaderVC: RemoveGroupUserProtocl {
    
    
    func removeItem(at indexPath: IndexPath) {
        // Perform the removal of the item from your data source
        // Update the table view accordingly, e.g., remove the item from the data array
        //self.users[indexPath.item].isSelected = false
        //print("here is the update from delegate: ", self.updateSelectedUsersDelegate ?? "no function found")
        //print("here is the row: ",indexPath.item)
        let user = self.users[indexPath.item]
        
        self.users.remove(at: indexPath.item)
        self.updateSelectedUsersDelegate?.removeSelection(user:user, fromAll: false)
        // Update the table view with the removal
        collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [indexPath])
            }, completion: nil)
        
    }
    
    
}
