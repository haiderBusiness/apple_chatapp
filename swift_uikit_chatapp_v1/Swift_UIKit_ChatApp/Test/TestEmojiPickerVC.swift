//
//  TestEmojiPickerVC.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 1.11.2023.
//

import UIKit


class TestEmojiPickerVC: UIViewController {
     
    let emojisView = EmojisView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
        configureEmojisView()
    }
    
    func configureEmojisView() {
        emojisView.translatesAutoresizingMaskIntoConstraints = false
        
        emojisView.backgroundColor = .black.withAlphaComponent(0.7)
        
        self.view.addSubview(emojisView)
        
        NSLayoutConstraint.activate([
            emojisView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emojisView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            emojisView.widthAnchor.constraint(equalToConstant: 300),
            emojisView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }
        
}

extension TestEmojiPickerVC {
    
}
