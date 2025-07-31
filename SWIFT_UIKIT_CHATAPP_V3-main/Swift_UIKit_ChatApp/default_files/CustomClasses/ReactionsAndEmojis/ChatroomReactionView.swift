//
//  ChatroomContextReactions.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 19.9.2023.
//

import UIKit

enum CustomReactionActionAttributes {
    case extra
    case disabled
    case destructive
    case hidden
    case normal
}

struct ContextReactionItem {
    var emojiString: String = ""
    var image: UIImage? = UIImage()
    var customSize: Float = Float()
    var selected: Bool = false
    var attributes: CustomReactionActionAttributes = .normal
    var handler: (() -> Void) = {}
}

private struct ReactionCell {
    var id: String = ""
    var reactionButton: UIButton = UIButton()
//    var imageView: UIView = UIView()
    var label: UILabel = UILabel()
    var imageView: UIImageView = UIImageView()
    var blur: UIVisualEffectView = UIVisualEffectView()
    var actionItems: ContextReactionItem = ContextReactionItem(emojiString: "")
}


struct BubbleLeadingConfiguration {
var anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>
var constant: CGFloat
var left: Bool
}

private var zPostion = CGFloat(3)

class ChatroomReactionView: UIView {
    
    
    public var whenDismissed: (() -> Void) = {}
    
    public var viewHeight = CGFloat(0)
    public var viewWidth = CGFloat(0)
    
    public var bubblesHeightPlusPaddings = CGFloat()
    
    var reactionItems: [ContextReactionItem] = [] {
        didSet {
            configureUI()
            configureReactionButtons()
        }
    }
    
    
    private let emojisView = EmojisView()
    

    
    public var bubbleLeadingConfiguration: BubbleLeadingConfiguration? = nil {
        didSet {
            guard let bubbleLeadingConfiguration = bubbleLeadingConfiguration else { return }
            if bubbleLeadingConfiguration.left {
                firstBubbleView.trailingAnchor.constraint(equalTo: bubbleLeadingConfiguration.anchor, constant: bubbleLeadingConfiguration.constant).isActive = true
                
                secondBubbleView.trailingAnchor.constraint(equalTo: firstBubbleView.trailingAnchor, constant: -12).isActive = true
            } else {
                firstBubbleView.leadingAnchor.constraint(equalTo: bubbleLeadingConfiguration.anchor, constant: bubbleLeadingConfiguration.constant).isActive = true
                secondBubbleView.leadingAnchor.constraint(equalTo: firstBubbleView.leadingAnchor, constant: 12).isActive = true
            }
            
        }
    }
    
    
    private let mainView = UIView()
    
    private let firstBubbleView = UIView()
    private let secondBubbleView = UIView()
    
    
    fileprivate var reactionCells: [ReactionCell] = []
    
    private var blur = UIVisualEffectView()
    
    private var firstBubbleBlur = UIVisualEffectView()
    private var secondBubbleBlur = UIVisualEffectView()
    
    private var mainViewBottomConstraint: NSLayoutConstraint?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func reset() {
        for subView in self.subviews {
            subView.removeFromSuperview()
        }
    
        for subView in mainView.subviews {
            subView.removeFromSuperview()
        }
        
//        emojisView.removeFromSuperview()
        mainView.removeFromSuperview()
        zPostion = 3
        viewHeight = 0
        viewWidth = 0
        
        mainViewBottomConstraint?.isActive = false
        mainViewBottomConstraint = nil
    }
    
    func hideReactions() {
        for cell in reactionCells {
            cell.reactionButton.alpha = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.whenDismissed()
    }
    
    func configureEmojisView() {
        
        mainView.addSubview(emojisView)
        emojisView.translatesAutoresizingMaskIntoConstraints = false
        
        emojisView.backgroundColor = .clear
        
        mainViewBottomConstraint = mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        mainViewBottomConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            emojisView.topAnchor.constraint(equalTo: mainView.topAnchor),
            emojisView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            emojisView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            emojisView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
        
    }
    
    
    func configureUI() {
        addSubview(firstBubbleView)
        firstBubbleView.translatesAutoresizingMaskIntoConstraints = false
        
        firstBubbleView.layer.zPosition = 0
        
        addSubview(secondBubbleView)
        secondBubbleView.translatesAutoresizingMaskIntoConstraints = false
        
        secondBubbleBlur.layer.zPosition = 0
        
        addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 13
        
        self.clipsToBounds = false
//        bubbleLeadingAnchorValue = self.leadingAnchor
        
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            
//            firstBubbleView.leadingAnchor.constraint(equalTo: bubbleLeadingAnchorValue ?? self.leadingAnchor),
            firstBubbleView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            firstBubbleView.widthAnchor.constraint(equalToConstant: 18),
            firstBubbleView.heightAnchor.constraint(equalToConstant: 18),
            
            
//            secondBubbleView.trailingAnchor.constraint(equalTo: firstBubbleView.trailingAnchor, constant: -12),
            secondBubbleView.topAnchor.constraint(equalTo: firstBubbleView.bottomAnchor, constant: 5),
            secondBubbleView.widthAnchor.constraint(equalToConstant: 10),
            secondBubbleView.heightAnchor.constraint(equalToConstant: 10),
            
        ])
        
        self.layoutIfNeeded()
        
        let firstBubbleViewHeight = 18 - 10
        let secondBubbleViewHeight = 10 + 12
        
        bubblesHeightPlusPaddings = CGFloat(firstBubbleViewHeight + secondBubbleViewHeight)
        
        viewHeight += CGFloat(firstBubbleViewHeight + secondBubbleViewHeight)
        
        
        firstBubbleView.layer.cornerRadius = firstBubbleView.bounds.size.width / 2
        firstBubbleView.clipsToBounds = true
        
        
        secondBubbleView.layer.cornerRadius = secondBubbleView.bounds.size.width / 2
        secondBubbleView.clipsToBounds = true
        
        mainView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        viewHeight += 48
    }
    

    
    
    func configureReactionButtons() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        var previousReactionButton: UIButton?
            print("here we are ")
        
        let style = window.traitCollection.userInterfaceStyle
        
        blur = AddBlur(toView: mainView, blurStyle: style == .light ? .light : .dark)
        mainView.addSubview(blur)

        blur.isUserInteractionEnabled = false
        blur.layer.zPosition = 0
        
        firstBubbleBlur = AddBlur(toView: firstBubbleView, blurStyle: style == .light ? .light : .dark)
        firstBubbleBlur.isUserInteractionEnabled = false
        
        
        secondBubbleBlur = AddBlur(toView: secondBubbleView, blurStyle: style == .light ? .light : .dark)
        secondBubbleBlur.isUserInteractionEnabled = false
        
        
        if style == .dark {
            mainView.backgroundColor = .systemGray5.withAlphaComponent(0.6)
            firstBubbleView.backgroundColor = .systemGray5.withAlphaComponent(0.6)
            secondBubbleView.backgroundColor = .systemGray5.withAlphaComponent(0.6)
//            mainView.backgroundColor = .clear
        } else {
//            mainView.backgroundColor = .clear
            mainView.backgroundColor = .white.withAlphaComponent(0.8)
            firstBubbleView.backgroundColor = .white.withAlphaComponent(0.8)
            secondBubbleView.backgroundColor = .white.withAlphaComponent(0.8)
        }
        
        
        var type1 = false
        
        for i in 0..<reactionItems.count {
 
            let number = i + 1
            let reactionItem = reactionItems.reversed()[i]
            
            
            let newReactionButton = UIButton()
            newReactionButton.isUserInteractionEnabled = true
            newReactionButton.translatesAutoresizingMaskIntoConstraints = false
            newReactionButton.layer.zPosition = 2
            
            let delay = CGFloat(i) * 0.01
            
           
            if type1 {
                startAnimation(view: newReactionButton, delay: delay, type: 1)
                type1 = false
            } else {
                startAnimation(view: newReactionButton, delay: delay, type: 2)
                type1 = true
            }
            
            
            
            newReactionButton.addTarget(self, action: #selector(press), for: .touchUpInside)
            
            let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
            
            if reactionItem.attributes != .extra {
                newReactionButton.addGestureRecognizer(longPressGesture)
            }
            
            
            longPressGesture.minimumPressDuration = 0.2
            
            
            
            // label
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = reactionItem.emojiString
            label.isUserInteractionEnabled = false
            label.font = UIFont.systemFont(ofSize: 32)
            label.layer.zPosition = 1
            
            newReactionButton.addSubview(label)
        
            // imageView
            let imageView = UIImageView()
            imageView.image = reactionItem.image
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = false
            imageView.layer.zPosition = 1
            
            newReactionButton.addSubview(imageView)
            
//            let imageView = UIImageView()
//            imageView.translatesAutoresizingMaskIntoConstraints = false
//            imageView.image = emojiToImage(emoji: reactionItem.emojiString, size: CGSize(width: 30, height: 30))
//            imageView.isUserInteractionEnabled = false
            
//            imageView.tintColor = .label
            
            
//            imageView.layer.zPosition = 1
//            newReactionButton.addSubview(imageView)
            
//            newMenuButton.backgroundColor = .red
        
            
            
            addSubview(newReactionButton)
            
//            print("reactionItem.emojiString", reactionItem.emojiString, i)
            
            
//            if let previousReactionButton = previousReactionButton, i > 0, number != reactionItems.count, reactionItem.emojiString == "test" {
//                print("here we are2", reactionItem)
//                NSLayoutConstraint.activate([
////                    newReactionButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
////                    newReactionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
//                    newReactionButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
//                    newReactionButton.trailingAnchor.constraint(equalTo: previousReactionButton.trailingAnchor, constant: -5),
//                    newReactionButton.leadingAnchor.constraint(equalTo: previousReactionButton.leadingAnchor, constant: 5),
//                    newReactionButton.heightAnchor.constraint(equalToConstant: 70),
//                    newReactionButton.widthAnchor.constraint(equalToConstant: 70),
//                ])
//            }
            
            // other options not first and not last
            if let previousReactionButton = previousReactionButton, i > 0, number != reactionItems.count {
                NSLayoutConstraint.activate([
//                    newReactionButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
//                    newReactionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
                    newReactionButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
                    newReactionButton.trailingAnchor.constraint(equalTo: previousReactionButton.leadingAnchor, constant: -5),
//                    newReactionButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 38),
//                    newReactionButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 38),
//                    newReactionButton.heightAnchor.constraint(lessThanOrEqualToConstant: 38),
//                    newReactionButton.widthAnchor.constraint(lessThanOrEqualToConstant: 38),
                    newReactionButton.heightAnchor.constraint(equalToConstant: 40),
                    newReactionButton.widthAnchor.constraint(equalToConstant: 40)
                ])
                
            }

            
            // last option
            else if number == reactionItems.count {
//                print("here we are2", reactionItem)
                NSLayoutConstraint.activate([
//                    newReactionButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
//                    newReactionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
                    newReactionButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
                    newReactionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
//                    newReactionButton.trailingAnchor.constraint(equalTo: previousReactionButton.leadingAnchor, constant: -5),
//                    newReactionButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 35),
//                    newReactionButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 35),
//                    newReactionButton.heightAnchor.constraint(lessThanOrEqualToConstant: 35),
//                    newReactionButton.widthAnchor.constraint(lessThanOrEqualToConstant: 35),
                    newReactionButton.heightAnchor.constraint(equalToConstant: 40),
                    newReactionButton.widthAnchor.constraint(equalToConstant: 40)
                ])
                
                viewWidth += 5
            }
            
            // first option
            else {
                NSLayoutConstraint.activate([
//                    newReactionButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
//                    newReactionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
                    newReactionButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
                    newReactionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
//                    newReactionButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 38),
//                    newReactionButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 38),
//                    newReactionButton.heightAnchor.constraint(lessThanOrEqualToConstant: 38),
//                    newReactionButton.widthAnchor.constraint(lessThanOrEqualToConstant: 38),
                    newReactionButton.heightAnchor.constraint(equalToConstant: 40),
                    newReactionButton.widthAnchor.constraint(equalToConstant: 40)
                ])
            
            }
            
            self.layoutIfNeeded()
            newReactionButton.layer.cornerRadius = newReactionButton.bounds.width / 2.3
            newReactionButton.clipsToBounds = true
            
            
            
//            NSLayoutConstraint.activate([
//                imageView.centerYAnchor.constraint(equalTo: newReactionButton.centerYAnchor),
////                imageView.centerYAnchor.constraint(equalTo: newMenuButton.centerYAnchor),
//                imageView.centerXAnchor.constraint(equalTo: newReactionButton.centerXAnchor),
//                imageView.heightAnchor.constraint(equalToConstant: 30),
//                imageView.widthAnchor.constraint(equalToConstant: 30),
//            ])
            
            NSLayoutConstraint.activate([
                label.centerYAnchor.constraint(equalTo: newReactionButton.centerYAnchor),
//                label.centerYAnchor.constraint(equalTo: newMenuButton.centerYAnchor),
                label.centerXAnchor.constraint(equalTo: newReactionButton.centerXAnchor),
                
                imageView.widthAnchor.constraint(equalToConstant: 25),
                imageView.heightAnchor.constraint(equalToConstant: 25),
                imageView.centerYAnchor.constraint(equalTo: newReactionButton.centerYAnchor),
//                label.centerYAnchor.constraint(equalTo: newMenuButton.centerYAnchor),
                imageView.centerXAnchor.constraint(equalTo: newReactionButton.centerXAnchor),
            ])
            
//            newReactionButton.bounds.size.width = 38
//            newReactionButton.bounds.size.height = 38
            
            newReactionButton.layoutIfNeeded()
            
//            print("newReactionButton.constraints",newReactionButton.constraints)
            previousReactionButton = newReactionButton
            
            
            
//            let blur = AddBlur(toView: newReactionButton, blurStyle: .dark)
//            newReactionButton.addSubview(blur)
            
//            blur.isUserInteractionEnabled = false
//            blur.layer.zPosition = 0
            
 
            
//            else if style == .dark {
////                blur.effect = UIBlurEffect(style: .dark)
//
//                newReactionButton.highlightedColor = .white.withAlphaComponent(0.2)
//                newReactionButton.unhighlightedColor = .clear
//                newReactionButton.backgroundColor = .clear
////                newMenuButton.unhighlightedColor = .systemGray5.withAlphaComponent(0.4)
////                newMenuButton.backgroundColor = .systemGray5.withAlphaComponent(0.4)
//            } else {
////                blur.effect = UIBlurEffect(style: .light)
//
//                newReactionButton.highlightedColor = .black.withAlphaComponent(0.2)
////                newMenuButton.unhighlightedColor = .systemBackground.withAlphaComponent(0.5)
////                newMenuButton.backgroundColor = .systemBackground.withAlphaComponent(0.5)
//                  newReactionButton.unhighlightedColor = .clear
//                  newReactionButton.backgroundColor = .clear
//            }
            
            
            let reactionCell = ReactionCell(id: "\(UUID())", reactionButton: newReactionButton, label: label, imageView: imageView, blur: UIVisualEffectView(), actionItems: reactionItem)
            
            if !reactionItem.selected {
                newReactionButton.backgroundColor = .clear
            }
            else if style == .dark {
                newReactionButton.backgroundColor = .white.withAlphaComponent(0.2)
            } else {
                  newReactionButton.backgroundColor = .black.withAlphaComponent(0.2)
            }
            
            
            
            if reactionItem.attributes == .extra {
//                newReactionButton.highlightedColor = style == .dark ? .white.withAlphaComponent(0.2) : .black.withAlphaComponent(0.2)
//
//                newReactionButton.unhighlightedColor = style == .dark ? .white.withAlphaComponent(0.15) : .black.withAlphaComponent(0.15)
                newReactionButton.backgroundColor = style == .dark ? .white.withAlphaComponent(0.15) : .black.withAlphaComponent(0.15)
                
                label.textColor = .label.withAlphaComponent(0.5)
                
                imageView.tintColor = .white
                
//                let blur = AddBlur(toView: newReactionButton, blurStyle: style == .light ? .light : .dark)
//                reactionCell.blur = blur
//
//                newReactionButton.addSubview(blur)
                
                
                newReactionButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
                newReactionButton.widthAnchor.constraint(equalToConstant: 34).isActive = true
                
                imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
                self.layoutIfNeeded()
                newReactionButton.layer.cornerRadius = newReactionButton.bounds.width / 2.3
            }
  
            reactionCells.append(reactionCell)
            
            
            self.layoutIfNeeded()
            print("newReactionButton.frame.width: ", newReactionButton.frame.width)
            viewWidth += reactionItem.customSize > 0 ? CGFloat(reactionItem.customSize) : newReactionButton.frame.width + 5
        }
    }
    
    
    
    
    
    func startAnimation(view: UIView, delay: CGFloat, type: Int) {
        
        if type == 1 {
        //         1. Position the view above its final position
            let finalPosition = view.frame.origin.y
            view.frame.origin.y -= self.bounds.height

    //         2. Animate to final position with bounce effect
            UIView.animate(withDuration: 0.6,
                           delay: delay,
                           usingSpringWithDamping: 0.5, // This determines the amount of bounce. 1.0 is no bounce.
                           initialSpringVelocity: 1,
                           options: [],
                           animations: {
                view.frame.origin.y = finalPosition
                view.alpha = 1
                self.layoutIfNeeded()
            }, completion: nil)
        } else {
            view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            UIView.animate(withDuration: 0.6,
                           delay: delay,
                           usingSpringWithDamping: 0.5, // This determines the amount of bounce. 1.0 is no bounce.
                           initialSpringVelocity: 1,
                           options: [],
                           animations: {
                view.transform = .identity
                self.layoutIfNeeded()
            }, completion: nil)
        }

        
    }
    
    
    @objc func press(sender: UIButton) {
        let reactionCell = reactionCells.first(where: {$0.reactionButton == sender})
//        UIView.animate(withDuration: 0.25,  delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
//            
//        })
        reactionCell?.actionItems.handler()
    }
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        
        
        
        guard let button = sender.view as? UIButton else {
                return
            }
        
        let _ = reactionCells.first(where: {$0.reactionButton == button})
        
        
        
        let _ = button.layer.zPosition
        
        
        
        zPostion += button.layer.zPosition
        button.layer.zPosition = zPostion
        
        if sender.state == .began {
            print("started")
            
            UIView.animate(withDuration: 0.7,  delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                button.transform = CGAffineTransform(scaleX: 4, y: 4)
            }, completion: { hasCompleted in
                if hasCompleted {
                    self.whenDismissed()
                }
            })
            
                
                    

//            reactionCell?.actionItems.handler()
        }
        else if sender.state == .ended {
            
            UIView.animate(withDuration: 1,  delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                button.transform = .identity
            }, completion: { hasCompleted in
                if hasCompleted {
                    button.layer.zPosition = 2
                }
            })
        }
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Update the map style when the system theme changes
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            if traitCollection.userInterfaceStyle == .dark {
                
                
                
                
                mainView.backgroundColor = .systemGray5.withAlphaComponent(0.6)
                firstBubbleView.backgroundColor = .systemGray5.withAlphaComponent(0.6)
                secondBubbleView.backgroundColor = .systemGray5.withAlphaComponent(0.6)
                
                blur.effect = UIBlurEffect(style: .dark)
                firstBubbleBlur.effect = UIBlurEffect(style: .dark)
                secondBubbleBlur.effect = UIBlurEffect(style: .dark)
                
                for reactionCell in reactionCells {
                    reactionCell.blur.effect = UIBlurEffect(style: .dark)
                    
                    
//                    reactionCell.reactionButton.highlightedColor = .white.withAlphaComponent(0.2)
                    
                    if !reactionCell.actionItems.selected {
                        reactionCell.reactionButton.backgroundColor = .clear
                    } else {
                        reactionCell.reactionButton.backgroundColor = .white.withAlphaComponent(0.2)
                    }
                    
                    
                    if reactionCell.actionItems.attributes == .extra {
//                        reactionCell.reactionButton.highlightedColor = .white.withAlphaComponent(0.2)
//
//                        reactionCell.reactionButton.unhighlightedColor =  .white.withAlphaComponent(0.15)
                        reactionCell.reactionButton.backgroundColor =  .white.withAlphaComponent(0.15)
                        
                    }
                }

            } else {
                
                firstBubbleView.backgroundColor = .white.withAlphaComponent(0.8)
                secondBubbleView.backgroundColor = .white.withAlphaComponent(0.8)
                mainView.backgroundColor = .white.withAlphaComponent(0.8)
                
                blur.effect = UIBlurEffect(style: .light)
                firstBubbleBlur.effect = UIBlurEffect(style: .light)
                secondBubbleBlur.effect = UIBlurEffect(style: .light)
                
                for reactionCell in reactionCells {
                    reactionCell.blur.effect = UIBlurEffect(style: .light)
                    
                    
                    
//                    reactionCell.reactionButton.highlightedColor = .black.withAlphaComponent(0.2)
                    
                    if !reactionCell.actionItems.selected {
                        reactionCell.reactionButton.backgroundColor = .clear
                    } else {
                        reactionCell.reactionButton.backgroundColor = .black.withAlphaComponent(0.2)
                    }
                    
                    
                    if reactionCell.actionItems.attributes == .extra  {
//                        reactionCell.reactionButton.highlightedColor = .black.withAlphaComponent(0.2)
//
//                        reactionCell.reactionButton.unhighlightedColor = .black.withAlphaComponent(0.15)
                        reactionCell.reactionButton.backgroundColor = .black.withAlphaComponent(0.15)
                        
                    }
                }
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
