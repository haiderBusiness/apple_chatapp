//
//  CustomContextMenu.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 23.9.2023.
//

import UIKit

enum CustomMenuActionAttributes {
    case disabled
    case destructive
    case hidden
    case normal
}

struct CustomMenuAction {
    var title: String
    var image: UIImage? = UIImage()
    var attributes: CustomMenuActionAttributes = .normal
    var customSepratorHeight: CGFloat = CGFloat(1)
    var actionHeight: CGFloat = CGFloat(45)
    var handler: (() -> Void) = {}
}

private struct MenuCell {
    var id: String = ""
    var menuButton: HighlightedButton = HighlightedButton()
    var labelView: UILabel = UILabel()
    var imageView: UIView = UIView()
    var blur: UIVisualEffectView = UIVisualEffectView()
    var actionItems: CustomMenuAction = CustomMenuAction(title: "")
    
}


class CustomContextMenuView: UIView {
    
    
    public var whenDismissed: ((String?) -> Void) = { empty in }
    
    var menuItems: [CustomMenuAction] = [] {
        didSet {
            reset()
            configureMenuButtons()
        }
    }
    
   fileprivate var menuCells: [MenuCell] = []
    
    
    
    var blurViews: [UIVisualEffectView] = []
    
    final var menuHeight = CGFloat(0)
    
    var mainView = UIView()
    
    
    var blur = UIVisualEffectView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        reset()
        configureUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.whenDismissed(nil)
    }
    
    func reset() {
        // Remove all subviews
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        for subView in mainView.subviews {
            subView.removeFromSuperview()
        }
        
        mainView.removeFromSuperview()
        
        menuHeight = 0
        
        // Reset properties to their defaults
        self.backgroundColor = .clear // or whatever your default is
        // ... any other properties to reset ...
    }
    
    
    func configureUI() {
//        let blur = AddBlur(toView: self, blurStyle: .dark)
       
//        self.backgroundColor = .systemBackground.withAlphaComponent(0.5)

//        mainView.addSubview(blur)
    }
    
    
    
    
    func configureMenuButtons() {
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        var previousMenuButton: UIButton?
            print("here we are ")
        
        let style = window.traitCollection.userInterfaceStyle
        
        self.addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.clipsToBounds = true
        
//        self.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        
        blur = AddBlur(toView: self, blurStyle: style == .light ? .light : .dark)
        mainView.addSubview(blur)

        blur.isUserInteractionEnabled = false
        blur.layer.zPosition = 0
        
        if style == .dark {
            self.backgroundColor = .systemGray5.withAlphaComponent(0.6)
//            self.backgroundColor = .clear
        } else {
//            self.backgroundColor = .clear
//            self.backgroundColor = .systemGray6.withAlphaComponent(0.85)
            self.backgroundColor = .white.withAlphaComponent(0.8)
        }
        
        
//
//        let blur = AddBlur(toView: self, blurStyle: style == .light ? .light : .dark)
//        mainView.addSubview(blur)
//
//        blur.isUserInteractionEnabled = false
//        blur.layer.zPosition = 0
        
        for i in 0..<menuItems.count {
            
            let number = i + 1
            let menuItem = menuItems[i]
            
            menuHeight += menuItem.actionHeight + menuItem.customSepratorHeight
            
            let newMenuButton = HighlightedButton()
            newMenuButton.isUserInteractionEnabled = true
            newMenuButton.translatesAutoresizingMaskIntoConstraints = false
            newMenuButton.layer.zPosition = 2
            
            newMenuButton.addTarget(self, action: #selector(press), for: .touchUpInside)
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = menuItem.title
            label.isUserInteractionEnabled = false
            label.font = UIFont.systemFont(ofSize: 18)
            label.layer.zPosition = 1
            newMenuButton.addSubview(label)
            
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = menuItem.image
            imageView.isUserInteractionEnabled = false
            
            switch menuItem.attributes {
                case .destructive:
                label.textColor = .systemRed
                imageView.tintColor = .systemRed
                default:
                label.textColor = .label
                imageView.tintColor = .label
            }
            
            imageView.layer.zPosition = 1
            newMenuButton.addSubview(imageView)
            
//            newMenuButton.backgroundColor = .red
        
            
            mainView.addSubview(newMenuButton)
            
//            print("menuItem.title", menuItem.title)
            
            
            // other options not first and not last
            if let previousMenuButton = previousMenuButton, i > 0, number != menuItems.count {
                NSLayoutConstraint.activate([
                    newMenuButton.topAnchor.constraint(equalTo: previousMenuButton.bottomAnchor),
                    newMenuButton.heightAnchor.constraint(equalToConstant:  menuItem.actionHeight + menuItem.customSepratorHeight),
                    newMenuButton.leadingAnchor.constraint(equalTo: leadingAnchor),
                    newMenuButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                ])
                
                let bottomLineView = UIView()
                let lineHeight = (menuItem.customSepratorHeight)
                newMenuButton.addSubview(bottomLineView)
                bottomLineView.backgroundColor = .systemGray4.withAlphaComponent(0.65)
                bottomLineView.translatesAutoresizingMaskIntoConstraints = false
                bottomLineView.widthAnchor.constraint(equalTo: newMenuButton.widthAnchor).isActive = true
                bottomLineView.heightAnchor.constraint(equalToConstant: lineHeight).isActive = true
                bottomLineView.bottomAnchor.constraint(equalTo: newMenuButton.bottomAnchor).isActive = true
                bottomLineView.layer.zPosition = 2
            }
            // last option
            else if let previousMenuButton = previousMenuButton, number == menuItems.count {
//                print("here we are2")
                NSLayoutConstraint.activate([
                    newMenuButton.topAnchor.constraint(equalTo: previousMenuButton.bottomAnchor),
                    newMenuButton.heightAnchor.constraint(equalToConstant:  menuItem.actionHeight + menuItem.customSepratorHeight),
//                    newMenuButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                    newMenuButton.leadingAnchor.constraint(equalTo: leadingAnchor),
                    newMenuButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                ])
            }
            
            // first option
            else {
                NSLayoutConstraint.activate([
                    newMenuButton.topAnchor.constraint(equalTo: topAnchor),
                    newMenuButton.heightAnchor.constraint(equalToConstant:  menuItem.actionHeight + menuItem.customSepratorHeight),
//                        newMenuButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                    newMenuButton.leadingAnchor.constraint(equalTo: leadingAnchor),
                    newMenuButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                ])
                
                let bottomLineView = UIView()
                let lineHeight = (menuItem.customSepratorHeight)
                newMenuButton.addSubview(bottomLineView)
                
                bottomLineView.backgroundColor = .systemGray4.withAlphaComponent(0.65)
                bottomLineView.translatesAutoresizingMaskIntoConstraints = false
                bottomLineView.widthAnchor.constraint(equalTo: newMenuButton.widthAnchor).isActive = true
//                bottomLineView.heightAnchor.constraint(greaterThanOrEqualToConstant: menuItem.customSepratorHeight * 3 ).isActive = true
//                bottomLineView.heightAnchor.constraint(lessThanOrEqualToConstant: menuItem.customSepratorHeight * 3 ).isActive = true
                bottomLineView.heightAnchor.constraint(equalToConstant: lineHeight).isActive = true
                bottomLineView.bottomAnchor.constraint(equalTo: newMenuButton.bottomAnchor).isActive = true
                bottomLineView.layer.zPosition = 2
            }
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: newMenuButton.leadingAnchor, constant: 18),
//                label.centerYAnchor.constraint(equalTo: newMenuButton.centerYAnchor),
                label.topAnchor.constraint(equalTo: newMenuButton.topAnchor, constant: 12),
                
                imageView.trailingAnchor.constraint(equalTo: newMenuButton.trailingAnchor, constant: -18),
//                imageView.centerYAnchor.constraint(equalTo: newMenuButton.centerYAnchor),
                imageView.topAnchor.constraint(equalTo: newMenuButton.topAnchor, constant: 12),
                imageView.heightAnchor.constraint(equalToConstant: 23.5),
                imageView.widthAnchor.constraint(equalToConstant: 23.5),
            ])
            
            previousMenuButton = newMenuButton
            
            
            
//            let blur = AddBlur(toView: newMenuButton, blurStyle: .dark)
//            newMenuButton.addSubview(blur)
//
//            blur.isUserInteractionEnabled = false
//            blur.layer.zPosition = 0
            
            
            
            if style == .dark {
//                blur.effect = UIBlurEffect(style: .dark)
//                newMenuButton.highlightedColor = .white.withAlphaComponent(1)
                newMenuButton.highlightedColor = .white.withAlphaComponent(0.2)
                newMenuButton.unhighlightedColor = .clear
                newMenuButton.backgroundColor = .clear
//                newMenuButton.unhighlightedColor = .systemGray5.withAlphaComponent(0.4)
//                newMenuButton.backgroundColor = .systemGray5.withAlphaComponent(0.4)
            } else {
//                blur.effect = UIBlurEffect(style: .light)
                newMenuButton.highlightedColor = .black.withAlphaComponent(0.2)
//                newMenuButton.unhighlightedColor = .systemBackground.withAlphaComponent(0.5)
//                newMenuButton.backgroundColor = .systemBackground.withAlphaComponent(0.5)
                  newMenuButton.unhighlightedColor = .clear
                  newMenuButton.backgroundColor = .clear
                
            }
            
            
            let menuCell = MenuCell(id: "\(UUID())", menuButton: newMenuButton, labelView: label, imageView: imageView, blur: UIVisualEffectView(), actionItems: menuItem)
            
            menuCells.append(menuCell)
        }
    }
    
    
    @objc func press(sender: HighlightedButton) {
        let menuCell = menuCells.first(where: {$0.menuButton == sender})
        menuCell?.actionItems.handler()
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Update the map style when the system theme changes
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            if traitCollection.userInterfaceStyle == .dark {
                
                self.backgroundColor = .systemGray5.withAlphaComponent(0.6)
                blur.effect = UIBlurEffect(style: .dark)
                
                
                for menuCell in menuCells {
                    menuCell.blur.effect = UIBlurEffect(style: .dark)
                    menuCell.menuButton.highlightedColor = .white.withAlphaComponent(0.2)
                }
            } else {
                
//                self.backgroundColor = .systemBackground.withAlphaComponent(0.85)
                blur.effect = UIBlurEffect(style: .light)
                self.backgroundColor = .white.withAlphaComponent(0.8)
                
                for menuCell in menuCells {
                    
                    menuCell.blur.effect = UIBlurEffect(style: .light)
                    menuCell.menuButton.highlightedColor = .black.withAlphaComponent(0.2)
                }
            }
           
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
