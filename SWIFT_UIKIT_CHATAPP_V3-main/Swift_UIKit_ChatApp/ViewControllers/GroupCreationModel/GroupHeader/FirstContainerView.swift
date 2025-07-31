//
//  GroupNameWidget.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 19.6.2023.
//

import UIKit




extension GroupCreationHeader {
    
    
    func configureFirstContainerView() {
        
        
        firstContainerView.translatesAutoresizingMaskIntoConstraints = false
        firstContainerView.layer.cornerRadius = 10
        firstContainerView.clipsToBounds = true
        firstContainerView.backgroundColor = .systemBackground
    
        
        
        addSubview(firstContainerView)
        
        NSLayoutConstraint.activate([
            firstContainerView.topAnchor.constraint(equalTo: topAnchor),
            firstContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            firstContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            firstContainerView.heightAnchor.constraint(equalToConstant: 150),
            //nameTextField.heightAnchor.constraint(equalTo: )
            
        ])
        
        
        
        let imageView = HighlightedButton()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 55 * 0.40
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray6
        imageView.unhighlightedColor = .systemGray6
        
        imageView.addTarget(self, action: #selector(onImagePress), for: .touchUpInside)
        
        firstContainerView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: firstContainerView.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: firstContainerView.leadingAnchor, constant: 15),
            imageView.widthAnchor.constraint(equalToConstant: 55),
            imageView.heightAnchor.constraint(equalToConstant: 55),
            //nameTextField.heightAnchor.constraint(equalTo: )
        ])
        
        
        
        
        
        
        
        
        // group image
        let groupDefaultImage = ImageViewPro()
        groupDefaultImage.translatesAutoresizingMaskIntoConstraints = false
        groupDefaultImage.image = UIImage(systemName: "camera")
        groupDefaultImage.tintColor = AppTheme.primaryColor
        groupDefaultImage.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20)
        groupDefaultImage.layer.zPosition = 1
        //groupDefaultImage.contentMode = .scaleAspectFit
//        groupDefaultImage.load(urlString: "https://randomuser.me/api/portraits/men/2.jpg")
        
        imageView.addSubview(groupDefaultImage)
        
        
        NSLayoutConstraint.activate([
            groupDefaultImage.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            groupDefaultImage.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ])
        
        
        
        
        
        
        groupImage.translatesAutoresizingMaskIntoConstraints = false
        groupImage.layer.cornerRadius = 55 * 0.40
        groupImage.clipsToBounds = true
        groupImage.translatesAutoresizingMaskIntoConstraints = false
        groupImage.backgroundColor = .systemGray6
        groupImage.layer.zPosition = 0
        
        imageView.addSubview(groupImage)
        
        NSLayoutConstraint.activate([
            groupImage.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            groupImage.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            groupImage.widthAnchor.constraint(equalToConstant: 55),
            groupImage.heightAnchor.constraint(equalToConstant: 55),
            //nameTextField.heightAnchor.constraint(equalTo: )
        ])
        
        
        
        
        nameTextField.placeholder = Language.group_name
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
//        nameTextField.backgroundColor = .systemGray4
        nameTextField.textColor = .label
        
        
        
        nameTextField.font = UIFont.systemFont(ofSize: 18)
    
        
        firstContainerView.addSubview(nameTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 25),
            nameTextField.trailingAnchor.constraint(equalTo: firstContainerView.trailingAnchor, constant: -15)
            //nameTextField.heightAnchor.constraint(equalTo: )
        ])
        
        
        
        let noteLabel = UILabel()
        noteLabel.text = ". " + Language.personal_and_group_messages_are_end_to_end_encrypted
        noteLabel.numberOfLines = 2
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
//        noteLabel.backgroundColor = .systemGray4

        noteLabel.textColor = .systemGray
        
        
        noteLabel.font = UIFont.systemFont(ofSize: 13)
    
        
        firstContainerView.addSubview(noteLabel)
        
        NSLayoutConstraint.activate([
            noteLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            noteLabel.leadingAnchor.constraint(equalTo: firstContainerView.leadingAnchor, constant: 15),
            noteLabel.trailingAnchor.constraint(equalTo: firstContainerView.trailingAnchor, constant: -15)
//            noteLabel.trailingAnchor.constraint(equalTo: firstContainerView.trailingAnchor, constant: -15)
            //nameTextField.heightAnchor.constraint(equalTo: )
            
        ])
        
        
        let noteLabel2 = UILabel()
        noteLabel2.text = ". " + Language.up_to + " 385 " + Language.membersSmallLetter
        noteLabel2.numberOfLines = 2
        noteLabel2.translatesAutoresizingMaskIntoConstraints = false
//        noteLabel2.backgroundColor = .systemGray4

        noteLabel2.textColor = .systemGray
        
        
        noteLabel2.font = UIFont.systemFont(ofSize: 13)
    
        
        firstContainerView.addSubview(noteLabel2)
        
        NSLayoutConstraint.activate([
            noteLabel2.topAnchor.constraint(equalTo: noteLabel.bottomAnchor, constant: 10),
            noteLabel2.leadingAnchor.constraint(equalTo: firstContainerView.leadingAnchor, constant: 15),
            noteLabel2.trailingAnchor.constraint(equalTo: firstContainerView.trailingAnchor, constant: -15)
//            noteLabel.trailingAnchor.constraint(equalTo: firstContainerView.trailingAnchor, constant: -15)
            //nameTextField.heightAnchor.constraint(equalTo: )
            
        ])
        
        
        
        
    }
    
    
    func setNewImage(image: UIImage) {
            groupImage.image = image
            groupImage.layer.zPosition = 1
    }
    
    @objc func onImagePress() {
        self.photoDelegate?.showPhotoActionSheet()
    }
}
