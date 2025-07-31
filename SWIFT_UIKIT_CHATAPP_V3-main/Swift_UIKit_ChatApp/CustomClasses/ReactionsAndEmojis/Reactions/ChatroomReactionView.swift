//
//  ChatroomContextReactions.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 19.9.2023.
//

import UIKit

private var zPostion = CGFloat(3)

class ChatroomReactionView: UIView {
    
    
    public var whenDismissed: ((String?) -> Void) = {empty in}
    
    public var pressedString: String? = nil
    
    public var viewHeight = CGFloat(0)
    public var viewWidth = CGFloat(0)
    
    public var bubblesHeightPlusPaddings = CGFloat()
    
    var reactionItems: [ContextReactionItem] = [] {
        didSet {
            configureUI()
            configureReactionButtons()
        }
    }
    
    
    internal let emojisView = EmojisView()
    

    
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
    
    
    internal let mainView = UIView()
    
    internal let firstBubbleView = UIView()
    internal let secondBubbleView = UIView()
    
    
    var reactionCells: [ReactionCell] = []
    
    internal var blur = UIVisualEffectView()
    
    internal var firstBubbleBlur = UIVisualEffectView()
    internal var secondBubbleBlur = UIVisualEffectView()
    
    internal var mainViewHeightConstraint: NSLayoutConstraint?
    
    
    
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
        
        
        emojisView.removeFromSuperview()
        mainView.removeFromSuperview()
        zPostion = 3
        viewHeight = 0
        viewWidth = 0
        
        mainViewHeightConstraint?.isActive = false
        mainViewHeightConstraint = nil
        
        emojisView.reset()
    }
    
    func hideReactions() {
        for cell in reactionCells {
            cell.reactionButton.alpha = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.whenDismissed(nil)
    }
    
    func configureEmojisView() {
        
        mainView.addSubview(emojisView)
        emojisView.translatesAutoresizingMaskIntoConstraints = false
        
        emojisView.backgroundColor = .clear
        
        mainViewHeightConstraint?.isActive = false
        mainViewHeightConstraint = mainView.heightAnchor.constraint(equalToConstant: 280)
        mainViewHeightConstraint?.isActive = true
        
        emojisView.whenDismissed = { [weak self] emoji in
            self?.whenDismissed(emoji)
            self?.reset()
        }
        
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
        
        
        self.clipsToBounds = false // to make content show even if emojis is bigger then the content
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
        
        
        mainViewHeightConstraint?.isActive = false
        mainViewHeightConstraint = mainView.heightAnchor.constraint(equalToConstant: 48)
        mainViewHeightConstraint?.isActive = true
        
        viewHeight += 48
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
        guard let reactionCell = reactionCells.first(where: {$0.reactionButton == sender}) else { return }
        reactionCell.actionItems.handler(reactionCell.label.text)
    }
    
    
    
    
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        
        guard let button = sender.view as? UIButton else {
            return
        }
        
        guard let cell = reactionCells.first(where: {$0.reactionButton == button}) else { return }

        
        let _ = button.layer.zPosition
        
        
        zPostion += button.layer.zPosition
        button.layer.zPosition = zPostion
        
        if sender.state == .began {
            
            UIView.animate(withDuration: 0.7,  delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                button.transform = CGAffineTransform(scaleX: 4, y: 4)
            }, completion: { hasCompleted in
                if hasCompleted {
                    self.whenDismissed(cell.label.text)
                }
            })
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
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
