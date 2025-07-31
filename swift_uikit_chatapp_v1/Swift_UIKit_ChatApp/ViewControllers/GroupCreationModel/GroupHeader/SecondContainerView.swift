//
//  GroupOptionWidget.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 19.6.2023.
//

import UIKit



extension GroupCreationHeader {
    
    
    func configureSecondContainerView() {
        
        secondContainerView.translatesAutoresizingMaskIntoConstraints = false
        secondContainerView.layer.cornerRadius = 10
        secondContainerView.clipsToBounds = true
        secondContainerView.backgroundColor = .systemBackground
        secondContainerView.unhighlightedColor = .systemBackground
        secondContainerView.highlightedColor = .systemGray5

        //secondContainerView.highlightedColor =
        secondContainerView.addTarget(self, action: #selector(onOptionPress), for: .touchUpInside)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(onOptionPress))
        secondContainerView.addGestureRecognizer(longPressGesture)
        
        //menuInteraction = UIContextMenuInteraction(delegate: self)
//        secondContainerView.addInteraction(menuInteraction)
        //secondContainerView.inte
        addSubview(secondContainerView)
        
        NSLayoutConstraint.activate([
            secondContainerView.topAnchor.constraint(equalTo: firstContainerView.bottomAnchor, constant: 35),
            secondContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            secondContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            secondContainerView.heightAnchor.constraint(equalToConstant: 45),
            ])
        
        
        let optionTitle = UILabel()
        optionTitle.translatesAutoresizingMaskIntoConstraints = false
//        optionTitle.backgroundColor = .systemGray4
        optionTitle.textColor = .label
        
        optionTitle.text = Language.auto_disapear_messages
        
        optionTitle.font = UIFont.systemFont(ofSize: 16)
        
        optionTitle.alpha = 0.8
        
        secondContainerView.addSubview(optionTitle)
        
        NSLayoutConstraint.activate([
            optionTitle.centerYAnchor.constraint(equalTo: secondContainerView.centerYAnchor),
            optionTitle.leadingAnchor.constraint(equalTo: secondContainerView.leadingAnchor, constant: 15),
//            autoDeleteLabel.trailingAnchor.constraint(equalTo: secondContainerView.trailingAnchor, constant: -15)
            //nameTextField.heightAnchor.constraint(equalTo: )
        ])
        
        
        
        let optionIcon = ImageViewPro()
        
        optionIcon.translatesAutoresizingMaskIntoConstraints = false
        optionIcon.image = UIImage(systemName: "chevron.up.chevron.down")
        optionIcon.tintColor = .systemGray
        optionIcon.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 12)
        
        secondContainerView.addSubview(optionIcon)
        
        
        NSLayoutConstraint.activate([
            optionIcon.trailingAnchor.constraint(equalTo: secondContainerView.trailingAnchor, constant: -15),
            optionIcon.centerYAnchor.constraint(equalTo: secondContainerView.centerYAnchor),
        ])
        
        
        
        
        
        
        
        optionText.translatesAutoresizingMaskIntoConstraints = false
//        optionText.backgroundColor = .systemGray4
        optionText.textColor = .systemGray
        
        
        if option == .off {
            optionText.text = Language.off
        } else if option == .twenty4hours {
            optionText.text = Language.twenty_four_hours
        } else if option == .sevendays {
            optionText.text = Language.seven_days
        } else {
            optionText.text = Language.thirty_days
        }
        
        
        
        optionText.font = UIFont.systemFont(ofSize: 16)
        
        secondContainerView.addSubview(optionText)
        
        NSLayoutConstraint.activate([
            optionText.centerYAnchor.constraint(equalTo: secondContainerView.centerYAnchor),
            optionText.trailingAnchor.constraint(equalTo: optionIcon.leadingAnchor, constant: -5),
//            autoDeleteLabel.trailingAnchor.constraint(equalTo: secondContainerView.trailingAnchor, constant: -15)
            //nameTextField.heightAnchor.constraint(equalTo: )
        ])
        
        
        
       
        
        
        
        
        
        
       
        noteLabel.text = Language.automatically_disapear_messages_in_this_group_after_period_of_time + "."
        noteLabel.numberOfLines = 2
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
//        noteLabel.backgroundColor = .systemGray4

        noteLabel.textColor = .label
        
        noteLabel.alpha = 0.6
        
        
        noteLabel.font = UIFont.systemFont(ofSize: 13)
    
        
        addSubview(noteLabel)
        
        NSLayoutConstraint.activate([
            noteLabel.topAnchor.constraint(equalTo: secondContainerView.bottomAnchor, constant: 8),
            noteLabel.leadingAnchor.constraint(equalTo: firstContainerView.leadingAnchor, constant: 15),
            noteLabel.trailingAnchor.constraint(equalTo: firstContainerView.trailingAnchor, constant: -15)
//            noteLabel.trailingAnchor.constraint(equalTo: firstContainerView.trailingAnchor, constant: -15)
            //nameTextField.heightAnchor.constraint(equalTo: )
            
        ])
        
    }
    
    
    
    
    
    @objc func onOptionPress() {
//        self.showActionSheet()
        self.optionDelegate?.showOptionActionSheet()
        print("test")
    }
    
}
