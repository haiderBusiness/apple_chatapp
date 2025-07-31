//
//  Navigations.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 24.6.2023.
//

import UIKit

class ChatroomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .systemGray6
            
            // Disable large title display mode
            navigationBar.prefersLargeTitles = false
            
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationBar.tintColor = .systemGray6
        }
    }
    
}
