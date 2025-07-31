//
//  TableVH.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 4.6.2023.
//

import UIKit

class ArchivedChatsTableVH: UITableViewHeaderFooterView, UIGestureRecognizerDelegate {
    
    static let identifier = ids.archived_table_header;
    
    var headerTitle = UILabel();
    let button = UIButton();
    let archivedChatrooms: [ChatRoom] = []
    var navigation: UINavigationController? = nil
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        
        self.backgroundColor = .systemBackground
        configureButton();
        configureTitle();
    }
   
   func configureButton() {
       self.contentView.addSubview(button)
       
       button.backgroundColor = .systemBackground
       button.translatesAutoresizingMaskIntoConstraints = false;
       button.addTarget(self, action: #selector(onPress), for: .touchUpInside)
       //button.addTarget(self, action: #selector(viewTapped), for: .touchDown)
       //button.addTarget(self, action: #selector(viewPressEnded), for: .touchUpInside)
       //button.setBackground(target: self, defaultBackgrond: .systemGray, highlightBackground: .systemBackground)
       
       NSLayoutConstraint.activate([
           button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
           button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
           button.topAnchor.constraint(equalTo: self.contentView.topAnchor),
           button.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
       ])
   }
   
   
   // Action method to be called when the view is tapped
   @objc func onPress() {
       print("View tapped!")
   }
   
   @objc func viewPressEnded() {
       // Reset the background color
       contentView.backgroundColor = .systemBackground
   }
   
   
   
    
  
   
   
  
    
    func configureTitle() {
        button.addSubview(headerTitle);
        headerTitle.translatesAutoresizingMaskIntoConstraints = false;
        headerTitle.numberOfLines = 0;
        headerTitle.adjustsFontSizeToFitWidth = true;
        headerTitle.minimumScaleFactor = 0.7;
        headerTitle.textAlignment = .center
        let font = UIFont.systemFont(ofSize: 13);
        let scaledFont = UIFontMetrics.default.scaledFont(for: font);
        headerTitle.font = scaledFont;
        headerTitle.text = Language.these_chats_stay_archived_even_when_new_messages_are_received + "."
        headerTitle.isUserInteractionEnabled = false;
        headerTitle.alpha = 0.6
        NSLayoutConstraint.activate([
           headerTitle.centerYAnchor.constraint(equalTo: button.centerYAnchor),
           headerTitle.centerXAnchor.constraint(equalTo: button.centerXAnchor),
           headerTitle.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 20),
           headerTitle.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -20)
        ]);
    }
   
   
   
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
