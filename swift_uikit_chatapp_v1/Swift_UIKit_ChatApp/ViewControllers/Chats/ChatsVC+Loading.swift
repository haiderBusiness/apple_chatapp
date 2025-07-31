//
//  ChatsVC+configureLoading.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 25.7.2023.
//

import UIKit



extension ChatsVC {
    
    func configureNetwork() {
        
        let customTitleView = CustomTitleView()
        navigationItem.titleView = customTitleView

        switch loadingStatus {
        case .waitingForNetwork:
            customTitleView.setTitle(Language.waiting_for_network + "...")
            customTitleView.setActivityIndicator(hidden: false)
        case .connecting:
            customTitleView.setTitle(Language.connecting + "...")
            customTitleView.setActivityIndicator(hidden: false)
        case .updating:
            customTitleView.setTitle(Language.updating + "...")
            customTitleView.setActivityIndicator(hidden: false)
        case .working:
            customTitleView.setTitle(Language.chats)
            customTitleView.setActivityIndicator(hidden: true)
        }
        
        customTitleView.setTitle(Language.chats)
        customTitleView.setActivityIndicator(hidden: true)
        
        
        
        
        
        // if device goes online
        network.whenReachable = { _ in
            // after recieving network signal display connecting
            customTitleView.setTitle(Language.connecting + "...")
            customTitleView.setActivityIndicator(hidden: false)

                customTitleView.setTitle(Language.updating)
                customTitleView.setActivityIndicator(hidden: false)
                fetchSaveLoadChats() { loadingStatus in
                    switch loadingStatus {
                    case .waitingForNetwork:
                        customTitleView.setTitle(Language.waiting_for_network + "...")
                        customTitleView.setActivityIndicator(hidden: false)
                        self.loadingStatus = .waitingForNetwork
                    case .connecting:
                        customTitleView.setTitle(Language.connecting + "...")
                        customTitleView.setActivityIndicator(hidden: false)
                        self.loadingStatus = .connecting
                    case .updating:
                        customTitleView.setTitle(Language.connecting + "...")
                        customTitleView.setActivityIndicator(hidden: false)
                        self.loadingStatus = .connecting
                    case .working:
                        customTitleView.setTitle(Language.chats)
                        customTitleView.setActivityIndicator(hidden: true)
                        self.loadingStatus = .working
                    }

                }

        }
        
        
        
        // if device goes offline
        network.whenUnreachable = { _ in
            // display waiting for network when there is no network
            customTitleView.setTitle(Language.waiting_for_network + "...")
            customTitleView.setActivityIndicator(hidden: false)
            self.loadingStatus = .waitingForNetwork
        }
        
    }
    
}
