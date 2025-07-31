//
//  LoadingScreen.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 23.7.2023.
//

import UIKit




class LoadingScreen: UIViewController {

    let LoadingImageView = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        doSomeWork()
    }
    
    func configureUI() {
        view.addSubview(LoadingImageView)
        LoadingImageView.translatesAutoresizingMaskIntoConstraints = false
        LoadingImageView.image = UIImage(named: "Telegram_logo_landscape")
        
        NSLayoutConstraint.activate([
            LoadingImageView.topAnchor.constraint(equalTo: view.topAnchor),
            LoadingImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            LoadingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            LoadingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
 
    
    func doSomeWork() {
        // pre load map view
        MapViewManager.shared.preloadMapView()
//        let testVC = TestViewController()
//        navigationController?.pushViewController(testVC, animated: false)
//        let testImage = UIImage(named: "ManImage")
//        if let testImage = testImage {
//            print("image new size: ", testImage.jpegData(compressionQuality: 0.72) ?? "nil")
//        }
        
        
        
        fetchSaveLoadChats() { loadingStatus in
            self.navigateToChats(loadingStatus: loadingStatus)
        }
//        SaveMessagesToDiskTest()
//        showMessage(self: self, title: "Test Done", message: "test done", okActionText: "ok", onActionPress: nil)
        
//        setUserData()
//        self.navigateToChats()
    }
    
    
    
    
    func navigateToChats(loadingStatus: ChatsLoadingEnum) {
            let chatsVC = ChatsVC()
    //        chatsVC.waitingForNetwork = waitingForNetwork
    //        chatsVC.connecting = connecting
            chatsVC.loadingStatus = loadingStatus
            navigationItem.backBarButtonItem = UIBarButtonItem(
                title: nil, style: .done, target: nil, action: nil)
            navigationItem.hidesBackButton = true
            navigationController?.navigationBar.tintColor = AppTheme.primaryColor
    //            self.navigationItem.backBarButtonItem = nil
            self.navigationController?.pushViewController(chatsVC, animated: false)
    }
    
    
}



