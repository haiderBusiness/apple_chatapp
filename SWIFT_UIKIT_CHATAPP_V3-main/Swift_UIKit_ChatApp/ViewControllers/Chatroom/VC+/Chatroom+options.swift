//
//  Chatroom+options.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 7.7.2023.
//

import UIKit


extension ChatroomVC {
    
    func createButton(iconName: String, title: String, titleColor: UIColor?, backgroundColor: UIColor?, upperView: UIView?, mainView: UIView) -> HighlightedButton {
        let optionButton = HighlightedButton()
        optionButton.translatesAutoresizingMaskIntoConstraints = false
        
        
       
        if let backgroundColor = backgroundColor {
            optionButton.backgroundColor = backgroundColor
//            optionButton.unhighlightedColor = backgroundColor
        } else {
            optionButton.backgroundColor = .systemGray6
//            optionButton.unhighlightedColor = .systemGray6
        }
        
        optionButton.highlightedColor = .systemGray4
        
        let bottomLineView = UIView()
        optionButton.addSubview(bottomLineView)
        bottomLineView.backgroundColor = .systemGray5
        bottomLineView.translatesAutoresizingMaskIntoConstraints = false
        bottomLineView.widthAnchor.constraint(equalTo: optionButton.widthAnchor).isActive = true
        bottomLineView.heightAnchor.constraint(equalToConstant: 1.5 ).isActive = true
        bottomLineView.bottomAnchor.constraint(equalTo: optionButton.bottomAnchor).isActive = true
        
        
        mainView.addSubview(optionButton)
        
//        let blur = BlurComponent.addBlur(toView: optionView, blurStyle: .light)
//        blur.isUserInteractionEnabled = false
//        optionButton.addSubview(blur)
        

//        let backgroundView = UIView()
//        backgroundView.translatesAutoresizingMaskIntoConstraints = false
//        backgroundView.backgroundColor = .systemGray6
//        backgroundView.alpha = 1
//        backgroundView.isUserInteractionEnabled = false
//        optionButton.addSubview(backgroundView)
        
        
       
        
       
        let optionTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            label.font = UIFont.systemFont(ofSize: 18)
            
            if let titleColor = titleColor {
                label.textColor = titleColor
            } else {
                label.textColor = .label
            }
            
            return label
        }();
        
        optionTitle.text = title
        
        optionButton.addSubview(optionTitle)
        
        
        //Image
        let iconImageView: ImageViewPro = {
            let iconImageView = ImageViewPro();
            iconImageView.layer.cornerRadius = 16;
            iconImageView.clipsToBounds = true;
//            iconImageView.backgroundColor = .systemGray6
            iconImageView.translatesAutoresizingMaskIntoConstraints = false;
            return iconImageView
        }();
        
        optionButton.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: optionButton.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 35),
            iconImageView.heightAnchor.constraint(equalToConstant: 35),
            //chatImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            iconImageView.leadingAnchor.constraint(equalTo: optionButton.leadingAnchor,constant: 15),
        ])
        
        
        // Assign the modified icon to an image view
        let iconImage = ImageViewPro()
        iconImage.image = UIImage(systemName: iconName)
        iconImage.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20,weight: .light)
        iconImage.tintColor = AppTheme.primaryColor
        iconImageView.addSubview(iconImage)
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            iconImage.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor),
            iconImage.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
        ]);
        

        

        NSLayoutConstraint.activate([
            optionButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            optionButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            optionButton.heightAnchor.constraint(equalToConstant: 50),
            optionTitle.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            optionTitle.centerYAnchor.constraint(equalTo: optionButton.centerYAnchor),
            
            
            //backgroundView
//            backgroundView.leadingAnchor.constraint(equalTo: optionButton.leadingAnchor),
//            backgroundView.trailingAnchor.constraint(equalTo: optionButton.trailingAnchor),
//            backgroundView.bottomAnchor.constraint(equalTo: optionButton.bottomAnchor),
//            backgroundView.topAnchor.constraint(equalTo: optionButton.topAnchor),
        ])
        
        if let upperView = upperView {
            optionButton.topAnchor.constraint(equalTo: upperView.bottomAnchor).isActive = true
        } else {
            optionButton.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        }
        
        return optionButton
    }
    
    
    
    
    func cancelButton(title: String, titleColor: UIColor?, backgroundColor: UIColor?, upperView: UIView, mainView: UIView) -> HighlightedButton {
        let optionButton = HighlightedButton()
        optionButton.layer.cornerRadius = 12
        optionButton.clipsToBounds = true
        optionButton.translatesAutoresizingMaskIntoConstraints = false
        
        optionButton.unhighlightedColor = .systemBackground
        optionButton.highlightedColor = .systemGray5
        optionButton.backgroundColor = .systemBackground
        
        mainView.addSubview(optionButton)
        
//        let blur = BlurComponent.addBlur(toView: optionView, blurStyle: .light)
//        blur.isUserInteractionEnabled = false
//        optionButton.addSubview(blur)
        

//        let backgroundView = UIView()
//        backgroundView.translatesAutoresizingMaskIntoConstraints = false
//        backgroundView.backgroundColor = .systemGray6
//        backgroundView.alpha = 0.9
//        backgroundView.isUserInteractionEnabled = false
//        optionButton.addSubview(backgroundView)
        
        
       
        
       
        let optionTitle: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)

            if let titleColor = titleColor {
                label.textColor = titleColor
            } else {
                label.textColor = .label
            }
            
            return label
        }();
        
        optionTitle.text = title
        
        optionButton.addSubview(optionTitle)
        
       

        NSLayoutConstraint.activate([
            optionButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            optionButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            optionButton.heightAnchor.constraint(equalToConstant: 50),
            optionTitle.centerXAnchor.constraint(equalTo: optionButton.centerXAnchor),
            optionTitle.centerYAnchor.constraint(equalTo: optionButton.centerYAnchor),
            
            
            //backgroundView
//            backgroundView.leadingAnchor.constraint(equalTo: optionButton.leadingAnchor),
//            backgroundView.trailingAnchor.constraint(equalTo: optionButton.trailingAnchor),
//            backgroundView.bottomAnchor.constraint(equalTo: optionButton.bottomAnchor),
//            backgroundView.topAnchor.constraint(equalTo: optionButton.topAnchor),
        ])
        
        optionButton.topAnchor.constraint(equalTo: upperView.bottomAnchor, constant: 6.5).isActive = true
     
        
        return optionButton
    }
}
