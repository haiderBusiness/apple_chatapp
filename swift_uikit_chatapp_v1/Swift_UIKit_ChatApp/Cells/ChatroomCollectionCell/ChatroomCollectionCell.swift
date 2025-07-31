//
//  ChatroomCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 27.6.2023.
//

import UIKit


class ChatroomCollectionCell: UICollectionViewCell {
    
    
    var selectionIcon = ImageViewPro();
    
    var selectionWidthConstraint: NSLayoutConstraint!;
    
    
//    let profileImageView: ImageViewPro = {
//        let imageView = ImageViewPro()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.image = UIImage(systemName: "person")
//        imageView.tintColor = .label
//        imageView.layer.cornerRadius = 16
//
//        return imageView
//    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let chatTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    var textLeading: NSLayoutConstraint!
    var textTrailing: NSLayoutConstraint!
    
    var imageLeading: NSLayoutConstraint!
    var imageTrailing: NSLayoutConstraint!
    
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        configureUI();
        
        layoutIfNeeded()

           let bubleHeight = bubbleView.bounds.height
           bubbleView.layer.cornerRadius = bubleHeight * 0.45
           bubbleView.clipsToBounds = true
    }
    
    
    func configureSelection() {
            
//        container.addSubview(selectionIcon)
        selectionIcon.translatesAutoresizingMaskIntoConstraints = false
        selectionIcon.layer.cornerRadius = 12;
        selectionIcon.layer.masksToBounds = true
        selectionIcon.tintColor = .systemGray3
        selectionIcon.image = UIImage(systemName: "circle")
        
        selectionIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        selectionIcon.widthAnchor.constraint(lessThanOrEqualToConstant: 25).isActive = true
        selectionIcon.heightAnchor.constraint(lessThanOrEqualToConstant: 25).isActive = true
        selectionIcon.widthAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        selectionIcon.heightAnchor.constraint(greaterThanOrEqualToConstant: 25).isActive = true
        selectionIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        selectionWidthConstraint = selectionIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -25)
        selectionWidthConstraint.isActive = true
    }

    private func configureUI() {
        addSubview(bubbleView)
        addSubview(chatTextLabel)
        
        
        
        let eighty_percent = CGFloat(UIScreen.main.bounds.width * 0.8)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            chatTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            chatTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            chatTextLabel.widthAnchor.constraint(lessThanOrEqualToConstant: eighty_percent),
            
            bubbleView.topAnchor.constraint(equalTo: chatTextLabel.topAnchor, constant: -10),
            bubbleView.leadingAnchor.constraint(equalTo: chatTextLabel.leadingAnchor, constant: -10),
            bubbleView.trailingAnchor.constraint(equalTo: chatTextLabel.trailingAnchor, constant: 10),
            bubbleView.bottomAnchor.constraint(equalTo: chatTextLabel.bottomAnchor, constant: 10),
        ])
        
        textLeading = chatTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22)
        textTrailing = chatTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -22)
    }

    func set(message:Message, isSelecting: Bool) {
        let isAuth = message.senderId == DataStore.shared.user.id ? true : false
        
        if let textMessage = message.textMessage {
            chatTextLabel.text = textMessage
        } else {
            chatTextLabel.text = nil
        }
        
        
        if isAuth {
            chatTextLabel.textColor = .white
            
            bubbleView.backgroundColor = AppTheme.sucsessColor
            //imageTrailing.isActive = true
            textTrailing.isActive = true
            
            //imageLeading.isActive = false
            textLeading.isActive = false
        } else {
            chatTextLabel.textColor = .label
            //chatTextLabel.textColor = .label
            bubbleView.backgroundColor = .systemGray6
            //imageLeading.isActive = true
            textLeading.isActive = true
            
            //imageTrailing.isActive = false
            textTrailing.isActive = false
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func height() -> CGFloat {
        self.layoutIfNeeded()
        let bubleHeight = bubbleView.bounds.height
        return bubleHeight
    }
    
    

}

