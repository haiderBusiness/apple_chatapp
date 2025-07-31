//
//  AddNewChatTableHeader.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 12.6.2023.
//

import UIKit

class AddNewChatTableHeader: UITableViewHeaderFooterView {

   
    
    var headerImageView = UIView();
    
    var addNewChatDelegate: NewChatAddedProtocol!
    
    var navigationDelegate: NavigateToNewChatroomDelegate!
    
    
    
    var groupButton = HighlightedButton()
    var contactButton = HighlightedButton()
    var NewChanelButton = HighlightedButton()
    
    
    var isSelecting = false
   
    var navigation: UINavigationController? = nil
    
    var navigationItem: UINavigationItem?;
    
    
    
   
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
       
        self.backgroundColor = .systemBackground
        
        //configureImageView();
        configureGroupButton();
        configureNewContactButton()
        configureNewChannelButton()
        //configureImage();
        //configureTitle();
        //configureBottomLine();
        
    }
   
    func configureGroupButton() {
        self.contentView.addSubview(groupButton)
        groupButton.backgroundColor = .systemBackground
//        groupButton.unhighlightedColor = .systemBackground
        
        groupButton.translatesAutoresizingMaskIntoConstraints = false;
        groupButton.addTarget(self, action: #selector(onGroupButtonPress), for: .touchUpInside)
        

        NSLayoutConstraint.activate([
            groupButton.heightAnchor.constraint(equalToConstant: 47),
            groupButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            groupButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            groupButton.topAnchor.constraint(equalTo: self.contentView.topAnchor),
        ])
        
        
        //Image
        let iconImageView: ImageViewPro = {
            let iconImageView = ImageViewPro();
            iconImageView.layer.cornerRadius = 16;
            iconImageView.clipsToBounds = true;
//            iconImageView.backgroundColor = .systemGray6
            iconImageView.translatesAutoresizingMaskIntoConstraints = false;
            return iconImageView
        }();
        
        groupButton.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: groupButton.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 35),
            iconImageView.heightAnchor.constraint(equalToConstant: 35),
            //chatImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            iconImageView.leadingAnchor.constraint(equalTo: groupButton.leadingAnchor,constant: 15),
        ])
        
        
        // Assign the modified icon to an image view
        let iconImage = ImageViewPro()
        iconImage.image = UIImage(systemName: "person.2")
        iconImage.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20,weight: .light)
        iconImage.tintColor = AppTheme.primaryColor
        iconImageView.addSubview(iconImage)
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            iconImage.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor),
            iconImage.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
        ]);
        
        //Title
        let buttonTitle = UILabel();
        groupButton.addSubview(buttonTitle);
        buttonTitle.translatesAutoresizingMaskIntoConstraints = false;
        buttonTitle.numberOfLines = 1;
        buttonTitle.adjustsFontSizeToFitWidth = true;
        buttonTitle.minimumScaleFactor = 0.7;
        let font = UIFont.systemFont(ofSize: 15);
        let scaledFont = UIFontMetrics.default.scaledFont(for: font);
        buttonTitle.font = scaledFont;
        buttonTitle.text = Language.new_qroup
        buttonTitle.textColor = AppTheme.primaryColor
        buttonTitle.isUserInteractionEnabled = false;
        
        
        NSLayoutConstraint.activate([
           buttonTitle.centerYAnchor.constraint(equalTo: groupButton.centerYAnchor),
           buttonTitle.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12)
        ]);

   }
   
    
    @objc func onGroupButtonPress() {
        let addNewGroupVC = AddNewGroupVC()
        
        addNewGroupVC.addNewChatDelegate = addNewChatDelegate
        addNewGroupVC.navigationDelegate = navigationDelegate
      
       navigationItem?.backBarButtonItem = UIBarButtonItem(title: Language.back, style: .plain, target: nil, action: nil)
        
        navigation?.navigationBar.tintColor = AppTheme.primaryColor
        
        navigation?.pushViewController(addNewGroupVC, animated: true)
    }
   
   // Action method to be called when the view is tapped
   @objc func onPress() {
       
   }
   
   
   
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}




extension AddNewChatTableHeader {
    
    func configureNewContactButton() {
        self.contentView.addSubview(contactButton)
        
        
        
        contactButton.backgroundColor = .systemBackground
//        contactButton.unhighlightedColor = .systemBackground
        
        contactButton.translatesAutoresizingMaskIntoConstraints = false;
        contactButton.addTarget(self, action: #selector(onPress), for: .touchUpInside)
        

        NSLayoutConstraint.activate([
            contactButton.heightAnchor.constraint(equalToConstant: 48),
            contactButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            contactButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            contactButton.topAnchor.constraint(equalTo: groupButton.bottomAnchor),
        ])
        
        //image
        let iconImageView: ImageViewPro = {
            let iconImageView = ImageViewPro();
            iconImageView.layer.cornerRadius = 16;
            iconImageView.clipsToBounds = true;
//            iconImageView.backgroundColor = .systemGray6
            iconImageView.translatesAutoresizingMaskIntoConstraints = false;
            return iconImageView
        }();
        
        contactButton.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: contactButton.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 35),
            iconImageView.heightAnchor.constraint(equalToConstant: 35),
            //chatImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            iconImageView.leadingAnchor.constraint(equalTo: contactButton.leadingAnchor,constant: 15),
        ])
        
        
        // Assign the modified icon to an image view
        let iconImage = ImageViewPro()
        iconImage.image = UIImage(systemName: "person.badge.plus")
        iconImage.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 19,weight: .light)
        iconImage.tintColor = AppTheme.primaryColor
        iconImageView.addSubview(iconImage)
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            iconImage.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor),
            iconImage.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
        ]);
        
        
        //Title
        let buttonTitle = UILabel();
        contactButton.addSubview(buttonTitle);
        buttonTitle.translatesAutoresizingMaskIntoConstraints = false;
        buttonTitle.numberOfLines = 1;
        buttonTitle.adjustsFontSizeToFitWidth = true;
        buttonTitle.minimumScaleFactor = 0.7;
        let font = UIFont.systemFont(ofSize: 15);
        let scaledFont = UIFontMetrics.default.scaledFont(for: font);
        buttonTitle.font = scaledFont;
        buttonTitle.text = Language.new_contact
        buttonTitle.textColor = AppTheme.primaryColor
        buttonTitle.isUserInteractionEnabled = false;
        
        
        NSLayoutConstraint.activate([
           buttonTitle.centerYAnchor.constraint(equalTo: contactButton.centerYAnchor),
           buttonTitle.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12)
        ]);
        
        
        
        //topLine
         let topLineView = UIView()
        contactButton.addSubview(topLineView)
        topLineView.translatesAutoresizingMaskIntoConstraints = false;
        topLineView.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            topLineView.bottomAnchor.constraint(equalTo: contactButton.topAnchor),
            topLineView.leadingAnchor.constraint(equalTo: buttonTitle.leadingAnchor),
            topLineView.trailingAnchor.constraint(equalTo: contactButton.trailingAnchor),
            topLineView.heightAnchor.constraint(greaterThanOrEqualToConstant: 1)
        ])
        
        
        //bottomLine
         let bottomLineView = UIView()
        contentView.addSubview(bottomLineView)
        bottomLineView.translatesAutoresizingMaskIntoConstraints = false;
        bottomLineView.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            bottomLineView.bottomAnchor.constraint(equalTo: contactButton.bottomAnchor),
            bottomLineView.leadingAnchor.constraint(equalTo: buttonTitle.leadingAnchor),
            bottomLineView.trailingAnchor.constraint(equalTo: contactButton.trailingAnchor),
            bottomLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    
    
    
    func configureNewChannelButton() {
        self.contentView.addSubview(NewChanelButton)
        NewChanelButton.backgroundColor = .systemBackground
        NewChanelButton.unhighlightedColor = .systemBackground
        
        NewChanelButton.translatesAutoresizingMaskIntoConstraints = false;
        NewChanelButton.addTarget(self, action: #selector(onPress), for: .touchUpInside)
        

        NSLayoutConstraint.activate([
            NewChanelButton.heightAnchor.constraint(equalToConstant: 48),
            NewChanelButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            NewChanelButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            NewChanelButton.topAnchor.constraint(equalTo: contactButton.bottomAnchor),
        ])
        
        
        let iconImageView: ImageViewPro = {
            let iconImageView = ImageViewPro();
            iconImageView.layer.cornerRadius = 16;
            iconImageView.clipsToBounds = true;
//            iconImageView.backgroundColor = .systemGray6
            iconImageView.translatesAutoresizingMaskIntoConstraints = false;
            return iconImageView
        }();
        
        NewChanelButton.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: NewChanelButton.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 35),
            iconImageView.heightAnchor.constraint(equalToConstant: 35),
            //chatImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            iconImageView.leadingAnchor.constraint(equalTo: NewChanelButton.leadingAnchor,constant: 15),
        ])
        
        
        // Assign the modified icon to an image view
        let iconImage = ImageViewPro()
        iconImage.image = UIImage(systemName: "person.3")
        iconImage.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 18,weight: .light)
        iconImage.tintColor = AppTheme.primaryColor
        iconImageView.addSubview(iconImage)
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            iconImage.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor),
            iconImage.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
        ]);
        
        
        
        
        
        
        //Title
        let buttonTitle = UILabel();
        NewChanelButton.addSubview(buttonTitle);
        buttonTitle.translatesAutoresizingMaskIntoConstraints = false;
        buttonTitle.numberOfLines = 1;
        buttonTitle.adjustsFontSizeToFitWidth = true;
        buttonTitle.minimumScaleFactor = 0.7;
        let font = UIFont.systemFont(ofSize: 15);
        let scaledFont = UIFontMetrics.default.scaledFont(for: font);
        buttonTitle.font = scaledFont;
        buttonTitle.text = "New Chanel"
        buttonTitle.textColor = AppTheme.primaryColor
        buttonTitle.isUserInteractionEnabled = false;
        
        
        NSLayoutConstraint.activate([
           buttonTitle.centerYAnchor.constraint(equalTo: NewChanelButton.centerYAnchor),
           buttonTitle.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12)
        ]);
    }
}
