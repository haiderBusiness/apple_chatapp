//
//  HomeViewController.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 1.6.2023.
//

import UIKit

class HomeViewController: UIViewController {

    //var moveToChatButton: UIButton();
    
    var store: Store!
    
    var setButtonWidth: NSLayoutConstraint!;
    
    let moveToChatButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home Scren"
        self.view.backgroundColor = AppTheme.primaryColor
        
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        
//        setNavigationAppearance()
//
        
//        let chatrooms = GenerateRandomChatrooms.generate()
//        DataStore.shared.chatrooms = chatrooms
        //update chatrooms
        //store = Store(initialState: AppState(chatrooms: [], archivedChatrooms: []))
        //store.dispatch(action: .updateChatrooms(newData: chatrooms));
        setStore()
        
        
        configureMoveToChatButton()
        setUserData()
        
//        removeImageFromDisk(fileName: "", folderName: "1111_images", removeFolder: true)
       
        
        // Do any additional setup after loading the view.
    }
    

    
    
    func setStore() {
        
    }
    

    
    
    
    func configureMoveToChatButton() {
       
        self.view.addSubview(moveToChatButton);
        moveToChatButton.setTitle("Move to chats", for: .normal)
        moveToChatButton.backgroundColor = .white;
        moveToChatButton.setTitleColor(AppTheme.primaryColor, for: .normal);
        
        moveToChatButton.translatesAutoresizingMaskIntoConstraints = false;
        
        moveToChatButton.layer.cornerRadius = 10;
        moveToChatButton.layer.masksToBounds = true;
        moveToChatButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        moveToChatButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            //moveToChatButton.widthAnchor.constraint(equalToConstant: 200),
        moveToChatButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        setButtonWidth = moveToChatButton.widthAnchor.constraint(equalToConstant: 200)
        setButtonWidth.isActive = true
        
        moveToChatButton.addTarget(self, action: #selector(moveToChatsVC), for: .touchUpInside)
    }
    
    

    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        Animation()
//    }
    
    
         func Animation() {
            self.setButtonWidth.constant = 200
            UIButton.animate(withDuration: 1, animations: {
                self.view.layoutIfNeeded()
            })
        
//        let animation = CABasicAnimation(keyPath: "constant")
//               animation.fromValue = CGRect(x: 0, y: 0, width: 0, height: 25)
//               animation.toValue = CGRect(x: 0, y: 0, width: 25, height: 25)
//               animation.duration = 2
//        animation.beginTime = CACurrentMediaTime()
               //self.setButtonWidth.constant = 200
//               moveToChatButton.layer.add(animation, forKey: "selectionAnimation")
    }
    
    @objc func moveToChatsVC() {
        
            
            
          // Set the navigation bar's tintColor to a dynamic system color
           if #available(iOS 13.0, *) {
               navigationController?.navigationBar.tintColor = UIColor { (traitCollection) -> UIColor in
                   return traitCollection.userInterfaceStyle == .dark ? AppTheme.primaryColor : AppTheme.primaryColor
               }
           } else {
               // Fallback for older iOS versions
               navigationController?.navigationBar.tintColor = AppTheme.primaryColor
           }
            
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Home", style: .plain, target: nil, action: nil)
        
        
        let chatsVC = ChatsVC();
        self.navigationController?.pushViewController(chatsVC, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension HomeViewController {
    
   
    
    
}



extension HomeViewController {
    
    func setNavigationAppearance() {
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            navigationBarAppearance.backgroundColor = UIColor.blue
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            
            let tabBarApperance = UITabBarAppearance()
            tabBarApperance.configureWithOpaqueBackground()
            tabBarApperance.backgroundColor = UIColor.blue
            UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
            UITabBar.appearance().standardAppearance = tabBarApperance
        }
    }
}
