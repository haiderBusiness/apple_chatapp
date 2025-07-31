//
//  CustomContextMenuInteraction.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 23.9.2023.
//

import Foundation
import UIKit




var blur: UIVisualEffectView? = nil

private let contextBackgroundView: UIView = {
    let indexPath: IndexPath = IndexPath(row: 0, section: 0)
    let view = UIButton()
    view.translatesAutoresizingMaskIntoConstraints = false
    
    view.backgroundColor = .black.withAlphaComponent(0.45)
    // blur
    blur = AddBlur(toView: view, blurStyle: .light)
    
//    blur.alpha = 0.8
    view.addSubview(blur!)
    
    //view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    // backgroundButton
    return view
}()


private var previewView: UIView?
private var previewViewInitialTopAnchor: NSLayoutConstraint?
private var previewViewNewBottomAnchor: NSLayoutConstraint?
private var menuContextViewTopAnchor: NSLayoutConstraint?

private var reactionView = ChatroomReactionView()

private var reactionViewHeightConstraint: NSLayoutConstraint?
private var reactionViewWidthConstraint: NSLayoutConstraint?


private let menuView = CustomContextMenuView()
private var menuViewTopAnchorToInitialCellRect: NSLayoutConstraint?
private var menuViewTopAnchorToEditedCellRect: NSLayoutConstraint?

private var menuViewSmallHeightAnchor: NSLayoutConstraint?
private var menuViewNormalHeightAnchor: NSLayoutConstraint?
private var menuHeightConstraint: NSLayoutConstraint?
private var menuWidthConstraint: NSLayoutConstraint?


private var indexPath: IndexPath? = nil

private var message: Message? = nil

private var window: UIView!

private var contextMenuOnLongPress: ContextMenuOnLongPress!


var menuScalingCGAffineTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    .translatedBy(x: 0, y: -1800)

extension ChatroomVC {
    
    @objc func contextMenuInteraction(_ sender: ContextMenuOnLongPress) {
        
        self.longPressGestrueRecognaizer = sender
        contextMenuOnLongPress = sender
        
        
        // one of the ways to detect which cell has been tapped
        //let cell = sender.view as? CustomUITableViewCell
        
        let point = sender.location(in: tableView)
        
        guard let receivedIndexPath = tableView.indexPathForRow(at: point), let receivedMessage = sender.message else { return }
        
        
        switch sender.state {
            case .began:
            
            self.animateCell(indexPath: receivedIndexPath, completion: {
                indexPath = receivedIndexPath
                message = receivedMessage
                self.began(indexPath: receivedIndexPath)
            })
            
//          print("indexPath: ", sender.indexPath)
            case .ended, .cancelled, .failed:
            resetCellAnimation(indexPath: receivedIndexPath)
            default:
                break;
        }
    }
    
    private func began(indexPath: IndexPath) {
        
       
        let cell = self.tableView.cellForRow(at: indexPath) as! CoreMessageCell
        cell.alpha = 1
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        let style = window.traitCollection.userInterfaceStyle
        if style == .dark {
            contextBackgroundView.backgroundColor = .clear
            blur?.effect = UIBlurEffect(style: .dark)
        } else {
            contextBackgroundView.backgroundColor = .black.withAlphaComponent(0.45)
            blur?.effect = UIBlurEffect(style: .light)
        }
        contextBackgroundView.alpha = 1
        menuView.alpha = 1
        reactionView.alpha = 1
        contextBackgroundView.isUserInteractionEnabled = true
        
        configureContextBackgroundView(indexPath: indexPath)
        
        configureMenu()
        
        reactionView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        
        menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
//        menuView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        
        
        menuView.alpha = 0
        
        // reset the anchorPoint
        self.setAnchorPoint(CGPoint(x: 0.5, y: 0.5), forView: menuView)
        
//
        window.layoutIfNeeded()
        
        
        
        
        
        

        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
//        UIView.animate(withDuration: 0.25,  delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            
            previewViewInitialTopAnchor?.isActive = false
            previewViewNewBottomAnchor?.isActive = true
            
            menuViewTopAnchorToEditedCellRect?.isActive = true
            menuViewTopAnchorToInitialCellRect?.isActive = false
            
            
            reactionView.transform = .identity

            
//            menuContextViewTopAnchor?.constant += 95
            window.layoutIfNeeded()
        }, completion: { hasCompleted in
            if hasCompleted {
               // TODO:
            }
        })
        

        
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            
            menuView.alpha = 1
            
            menuView.transform = .identity
            
            let menuItemsHeight = CGFloat(Int(menuView.menuHeight))
            menuHeightConstraint?.constant = menuItemsHeight
            menuWidthConstraint?.constant = 260
            window.layoutIfNeeded()
        })
        
        

        
    }
    
    
    
    
    
    private func configureContextBackgroundView(indexPath: IndexPath) {
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
//            window.layoutIfNeeded()
        window.addSubview(contextBackgroundView)
        contextBackgroundView.isUserInteractionEnabled = true

        let backgroundButton = UIButton()
        backgroundButton.frame = view.bounds
        backgroundButton.addTarget(self, action: #selector(onBackgroundPress), for: .touchDown)
        contextBackgroundView.addSubview(backgroundButton)
        
        NSLayoutConstraint.activate([
            contextBackgroundView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            contextBackgroundView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            contextBackgroundView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
            contextBackgroundView.topAnchor.constraint(equalTo: window.topAnchor),
        ])
        
    }
    
    @objc func onBackgroundPress() {
        print("pressed")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        guard let receivedIndexPath = indexPath else {
            return
        }
        
        let cell = self.tableView.cellForRow(at: receivedIndexPath) as! CoreMessageCell
        
        
        
        
        
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            menuView.alpha = 0
            reactionView.alpha = 0
            
            previewViewInitialTopAnchor?.isActive = true
            previewViewNewBottomAnchor?.isActive = false
            
            
            menuViewTopAnchorToEditedCellRect?.isActive = true
            menuViewTopAnchorToInitialCellRect?.isActive = false
            
            window.layoutIfNeeded()
        }, completion: { hasCompleted in
            if hasCompleted {
                indexPath = nil
                message = nil
                
                //menu
                menuHeightConstraint?.isActive = false
                menuHeightConstraint = nil
                
                menuWidthConstraint?.isActive = false
                menuWidthConstraint = nil
                
                menuView.reset()
                
                menuView.removeFromSuperview()

                
                // reaction view
                reactionViewHeightConstraint?.isActive = false
                reactionViewHeightConstraint = nil
                
                reactionView.reset()
                reactionView.removeFromSuperview()
            
                
                
            
                previewView?.removeFromSuperview()
                
                contextBackgroundView.removeFromSuperview()
                
                cell.alpha = 1
                contextBackgroundView.alpha = 0
//                window.layoutIfNeeded()
        //            menuContextViewTopAnchor?.constant += 95

            }
        })
        
        // reset the anchorPoint
        window.layoutIfNeeded()
        self.setAnchorPoint(CGPoint(x: 0.5, y: 0.0), forView: menuView)
        
        
//        let scaleFactor: CGFloat = 0.1

        // Calculate translation needed based on scale
//        let translateAmount = menuView.bounds.height * (1 - scaleFactor) / 2
        
//        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            
            
            menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//            menuView.mainView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
//            menuHeightConstraint?.constant = 0
//            menuWidthConstraint?.constant = 0
            
            window.layoutIfNeeded()
//            menuView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        })
        
    }
    
    
    
    
    
    
    
    
    
    
    private func setAnchorPoint(_ anchorPoint: CGPoint, forView view: UIView) {
        let newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
        let oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)

        let newPointTransformed = newPoint.applying(view.transform)
        let oldPointTransformed = oldPoint.applying(view.transform)

        var position = view.layer.position

        position.x -= oldPointTransformed.x
        position.x += newPointTransformed.x

        position.y -= oldPointTransformed.y
        position.y += newPointTransformed.y
        
        view.layer.position = position
        view.layer.anchorPoint = anchorPoint
    }
    
    
    
    
    
    
    
    
    
    
    // MARK: Configure Menu UI
    
    
    func configureMenu() {

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let localWindow = windowScene.windows.first else {
            return
        }
        
        window = localWindow
        
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.layer.cornerRadius = 15
        menuView.clipsToBounds = true
        
        reactionView.translatesAutoresizingMaskIntoConstraints = false
        reactionView.layer.cornerRadius = 13
        reactionView.clipsToBounds = true
        
        guard let indexPath = indexPath else {
            return
        }

        guard let previewShowInfo = prepareCellForShow(indexPath: indexPath, view: window) else { return }
            
//            guard let message = message else {
//                return
//            }

//            cell.configure(message: message, isSelecting: false)
            
            let cellRectInWindow = previewShowInfo.cellPosition
            
            let snapshot = previewShowInfo.snapshot
            snapshot.isHidden = false
            snapshot.translatesAutoresizingMaskIntoConstraints = false
            snapshot.layer.zPosition = 2
        
            contextBackgroundView.addSubview(menuView)
            contextBackgroundView.addSubview(snapshot)
            contextBackgroundView.addSubview(reactionView)
            
            
            previewView = snapshot
            let previewWidth = previewShowInfo.cellWidth
            let previewHeight = previewShowInfo.cellHeight
            
            
            
            
            configureMenuItems(cellRectInWindow: cellRectInWindow)
            configureReactionItems(cellRectInWindow: cellRectInWindow)
        
            
            
            var heightToCell = cellRectInWindow.origin.y
        
            let menuItemsHeight = CGFloat(Int(menuView.menuHeight))
//            let reactionItemsWidth = CGFloat(Int(reactionView.reactionItems.count * (45) + 5))
            let reactionItemsWidth = reactionView.viewWidth
            let reactionViewHeight: CGFloat = reactionView.viewHeight
            
            let space = snapshot.bounds.height + 12
            
        
            menuScalingCGAffineTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            .translatedBy(x: 0, y: (cellRectInWindow.origin.y + menuItemsHeight) * -3)
            

            if cellRectInWindow.origin.y + menuItemsHeight + space > window.safeAreaLayoutGuide.layoutFrame.maxY {
                
                let extra = cellRectInWindow.origin.y + menuItemsHeight - window.safeAreaLayoutGuide.layoutFrame.maxY
                heightToCell -= extra + space
            }
        
            // top safe aread
            else if cellRectInWindow.origin.y - reactionViewHeight < window.safeAreaLayoutGuide.layoutFrame.minY {
//                let extra = window.safeAreaLayoutGuide.layoutFrame.minY + (cellRectInWindow.origin.y - reactionViewHeight)
                let extra = reactionViewHeight - cellRectInWindow.origin.y + window.safeAreaLayoutGuide.layoutFrame.minY
                print("true: cellRectInWindow.origin.y", cellRectInWindow.origin.y, extra, window.safeAreaLayoutGuide.layoutFrame.minY)
                menuScalingCGAffineTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    .translatedBy(x: 0, y: -(1800 + (extra * 5)))
                heightToCell += extra
            }
        
        



            
        if previewShowInfo.isAuth {
            snapshot.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12).isActive = true
            
            menuView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -12).isActive = true
            reactionView.trailingAnchor.constraint(equalTo: snapshot.trailingAnchor).isActive = true
            
            reactionView.bubbleLeadingConfiguration = BubbleLeadingConfiguration(anchor: snapshot.leadingAnchor, constant: 2, left: true)
        } else {
            snapshot.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12).isActive = true
            
            menuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 12).isActive = true
            reactionView.leadingAnchor.constraint(equalTo: snapshot.leadingAnchor).isActive = true
            
            reactionView.bubbleLeadingConfiguration = BubbleLeadingConfiguration(anchor: snapshot.trailingAnchor, constant: -2, left: false)
        }
        
        
        
        
        // preview view
        previewViewInitialTopAnchor = snapshot.topAnchor.constraint(equalTo: contextBackgroundView.topAnchor, constant: cellRectInWindow.origin.y)
        previewViewInitialTopAnchor?.isActive = true
        
        previewViewNewBottomAnchor = snapshot.topAnchor.constraint(equalTo: contextBackgroundView.topAnchor, constant: heightToCell)
        previewViewNewBottomAnchor?.isActive = false
        
        
        
        menuViewTopAnchorToEditedCellRect = menuView.topAnchor.constraint(equalTo: snapshot.bottomAnchor, constant: 8)
//        menuViewTopAnchorToInitialCellRect = menuView.topAnchor.constraint(equalTo:  window.topAnchor, constant: cellRectInWindow.origin.y)
        
        menuViewTopAnchorToEditedCellRect?.isActive = true
        menuViewTopAnchorToInitialCellRect?.isActive = false
        
        
        // menu height
        menuHeightConstraint = menuView.heightAnchor.constraint(equalToConstant: menuItemsHeight)
//        menuHeightConstraint?.constant = 0
        menuHeightConstraint?.isActive = true
        
        // menu width
        menuWidthConstraint = menuView.widthAnchor.constraint(equalToConstant: 260)
//        menuWidthConstraint?.constant = 0
        menuWidthConstraint?.isActive = true
        
        reactionViewHeightConstraint = reactionView.heightAnchor.constraint(equalToConstant: reactionViewHeight)
        reactionViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            
            
//            reactionView.heightAnchor.constraint(equalToConstant: reactionViewHeight),
            
            reactionView.widthAnchor.constraint(equalToConstant: reactionItemsWidth),
//                reactionView.bottomAnchor.constraint(equalTo: window.topAnchor, constant: (heightToCell - 12)),
            reactionView.bottomAnchor.constraint(equalTo: snapshot.topAnchor, constant: -(8 - reactionView.bubblesHeightPlusPaddings)),
//                reactionView.trailingAnchor.constraint(equalTo: cell.mainView.trailingAnchor),
//                reactionView.centerXAnchor.constraint(equalTo: cell.mainView.centerXAnchor, constant: -previewWidth),
            
            snapshot.widthAnchor.constraint(equalToConstant: CGFloat(previewWidth)),
            snapshot.heightAnchor.constraint(equalToConstant: CGFloat(previewHeight)),
            
        ])
        
//        reactionViewHeightConstraint = reactionView.heightAnchor.constraint(equalToConstant: reactionViewHeight)
//        reactionViewHeightConstraint?.isActive = true
//
//        reactionViewWidthConstraint = reactionView.widthAnchor.constraint(equalToConstant: reactionItemsWidth)
//        reactionViewWidthConstraint?.isActive = true
            
        reactionView.layer.zPosition = 1
        menuView.layer.zPosition = 1
        
        reactionView.whenDismissed = { reaction in
            
            if let reaction = reaction {
                print("reaction: ", reaction)
            }
            self.onBackgroundPress()
        }
        
        menuView.whenDismissed = { _ in
            self.onBackgroundPress()
        }
        
        
        
        reactionView.layer.zPosition = 10
        
    }
    
    
    

    

    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Update the map style when the system theme changes
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            if traitCollection.userInterfaceStyle == .dark {
                contextBackgroundView.backgroundColor = .clear
                blur?.effect = UIBlurEffect(style: .dark)
                
            } else {
                contextBackgroundView.backgroundColor = .black.withAlphaComponent(0.45)
                blur?.effect = UIBlurEffect(style: .light)
                
            }
           
        }
    }
    
    
}













// MARK: CONFIGURE REACTION ITEMS
extension ChatroomVC {
    
    func configureReactionItems(cellRectInWindow: CGRect) {
        
        let imageIconConfiguration = UIImage.SymbolConfiguration(pointSize: 28, weight: .semibold , scale: .large)
        
            let 🤣 : ContextReactionItem = {
                let option = ContextReactionItem (
                    emojiString: "🤣"
                ) { emojiString in
                    // Handle off action
    //                self.addToArchived(indexPath: indexPath);
                    if let emojiString = emojiString {
                        print("emojiString: ", emojiString)
                    }
                    
                }
                return option
            }()
        
               
            let heart: ContextReactionItem = {
                let option = ContextReactionItem (
                    emojiString: "❤️"
                ) { emojiString in
                    // Handle off action
    //                self.addToArchived(indexPath: indexPath);
                    if let emojiString = emojiString {
                        print("emojiString: ", emojiString)
                    }
                    
                }
                return option
            }()
        
            let 😮 : ContextReactionItem = {
                let option = ContextReactionItem (
                    emojiString: "😮"
                ) { emojiString in
                    // Handle off action
    //                self.addToArchived(indexPath: indexPath);
                    if let emojiString = emojiString {
                        print("emojiString: ", emojiString)
                    }
                    
                }
                return option
            }()
        
            let 🙏🏻 : ContextReactionItem = {
                let option = ContextReactionItem (
                    emojiString: "🙏🏻"
                ) { emojiString in
                    // Handle off action
    //                self.addToArchived(indexPath: indexPath);
                    if let emojiString = emojiString {
                        print("emojiString: ", emojiString)
                    }
                    
                }
                return option
            }()
        
            let 👍🏻: ContextReactionItem = {
                let option = ContextReactionItem (
                    emojiString: "👍🏻"
                ) { emojiString in
                    // Handle off action
    //                self.addToArchived(indexPath: indexPath);
                    if let emojiString = emojiString {
                        print("emojiString: ", emojiString)
                    }
                    
                }
                return option
            }()
        
        let 😥 : ContextReactionItem = {
            let option = ContextReactionItem (
                emojiString: "😥"
            ) { emojiString in
                // Handle off action
//                self.addToArchived(indexPath: indexPath);
                if let emojiString = emojiString {
                    print("emojiString: ", emojiString)
                }
                
            }
            return option
        }()
        
        let 🤔 : ContextReactionItem = {
            let option = ContextReactionItem (
                emojiString: "🤔"
            ) { emojiString in
                // Handle off action
//                self.addToArchived(indexPath: indexPath);
                if let emojiString = emojiString {
                    print("emojiString: ", emojiString)
                }
                
            }
            return option
        }()
        
        
        let more: ContextReactionItem = {
            let option = ContextReactionItem (
                emojiString: "",
                image: UIImage(systemName: "chevron.down", withConfiguration: imageIconConfiguration),
                attributes: .extra
            ) { _ in
                // Handle off action
//                self.addToArchived(indexPath: indexPath);
                
                guard let snapshot = previewView else {
                    return
                }
                
                
                
                
                var heightToCell = cellRectInWindow.origin.y
            
                let menuItemsHeight = CGFloat(Int(menuView.menuHeight))

                let space = snapshot.bounds.height + 12
                
            
                menuScalingCGAffineTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                .translatedBy(x: 0, y: (cellRectInWindow.origin.y + menuItemsHeight) * -3)
                

                if cellRectInWindow.origin.y + space > window.safeAreaLayoutGuide.layoutFrame.maxY {

                    let extra = cellRectInWindow.origin.y - window.safeAreaLayoutGuide.layoutFrame.maxY
                    heightToCell -= extra + space
                }
            
                // top safe aread
                else
                    if cellRectInWindow.origin.y - 310 < window.safeAreaLayoutGuide.layoutFrame.minY {
    //                let extra = window.safeAreaLayoutGuide.layoutFrame.minY + (cellRectInWindow.origin.y - reactionViewHeight)
                    let extra = 310 - cellRectInWindow.origin.y + window.safeAreaLayoutGuide.layoutFrame.minY
                    heightToCell += extra
                }
                
                
                reactionView.configureEmojisView()
                
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    reactionView.hideReactions()
//                    reactionView.heightAnchor.constraint(equalToConstant: 600).isActive = true
                    reactionViewHeightConstraint?.constant = 310
                    previewViewNewBottomAnchor?.constant =  heightToCell
                    menuView.alpha = 0
                    
                    
                    window.layoutIfNeeded()
                }, completion: nil)
                
                
            }
            return option
        }()
        
        reactionView.reactionItems = [🤣, heart, 😮, 🙏🏻, 👍🏻, 😥, 🤔, more]
    }
}














// MARK: CONFIGURE MENU ITEMS
extension ChatroomVC {
    
    func configureMenuItems(cellRectInWindow: CGRect) {
        
        let imageIconConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .medium)
        
                let archiveOption : CustomMenuAction = {
                    let title = Language.reply
                    let option = CustomMenuAction(
                        title: title,
                        image: UIImage(systemName: "arrowshape.turn.up.left", withConfiguration: imageIconConfiguration),
                        customSepratorHeight: 7
                    ) {
                        // Handle off action
        //                self.addToArchived(indexPath: indexPath);
                        print(Language.reply)
                    }
                    return option
                }()
        
                let readUnReadOption : CustomMenuAction = {
                    let title = Language.copy
                    let option = CustomMenuAction(title: title, image: UIImage(systemName: "doc.on.doc", withConfiguration: imageIconConfiguration)) {
                        // Handle off action
        //                self.markUnread(indexPath: indexPath);
                        print(Language.copy)
                    }
                    return option
                }()
        
        
        
                let pinUnpinOption : CustomMenuAction = {
                    let title = Language.edit
                    let option = CustomMenuAction(title: title,image: UIImage(systemName: "square.and.pencil", withConfiguration: imageIconConfiguration)) {
                        // Handle off action
        //                self.pinChat(indexPath: indexPath);
                        print(Language.edit)
                    }
                    return option
                }()
        
                let muteUnMuteOption : CustomMenuAction = {
                    let title = Language.pin
                    let option = CustomMenuAction(
                        title: title, image: UIImage(systemName: IconStrings.pin, withConfiguration: imageIconConfiguration)) {
                        // Handle off action
        //                self.muteChat(indexPath: indexPath)
                        print(Language.pin)
                    }
                    return option
                }()
        
                let forward : CustomMenuAction = {
                    let title = Language.forward
                    let option = CustomMenuAction(
                        title: title,
                        image: UIImage(systemName: "arrowshape.turn.up.right", withConfiguration: imageIconConfiguration)
                    ) {
                        // Handle off action
            //                self.muteChat(indexPath: indexPath)
                        print(Language.forward)
                    }
                    return option
                }()
        
                let select : CustomMenuAction = {
                    let title = Language.select
                    let option = CustomMenuAction(
                        title: title,
                        image: UIImage(systemName: "checkmark.circle", withConfiguration: imageIconConfiguration),
                        customSepratorHeight: 7
                    ) {
                        // Handle off action
            //                self.muteChat(indexPath: indexPath)
                        print(Language.select)
                    }
                    return option
                }()
                
                let deleteForMe : CustomMenuAction = {
                    let title = Language.delete_for_me
                    let option = CustomMenuAction(
                        title: title,
                        image: UIImage(),
                        attributes: .destructive)  {
                            // Handle off action
                            
                            guard let indexPath = indexPath, let message = message else {
                                return
                            }
                            
                            self.onBackgroundPress()
//                            self.onCellRemove(indexPath: indexPath)
                            self.deleteMessage(message: message, indexPath: indexPath)
                        
                        }
                    return option
                }()
        
        
                let deleteForAll : CustomMenuAction = {
                    let title = Language.delete_for_all
                    let option = CustomMenuAction(
                        title: title,
                        image: UIImage(),
                        attributes: .destructive)  {
                            // Handle off action
                            
                            guard let indexPath = indexPath, let message = message else {
                                return
                            }
                            
                            self.onBackgroundPress()
//                            self.onCellRemove(indexPath: indexPath)
                            self.deleteMessage(message: message, indexPath: indexPath)
                        }
                    return option
                }()
        
                let DeleteExitGroupOption : CustomMenuAction = {
                    let title = Language.delete
                    let option = CustomMenuAction(
                        title: title,
                        image: UIImage(systemName: IconStrings.trash, withConfiguration: imageIconConfiguration),
                        attributes: .destructive)  {
                            // Handle off action
                            
                            guard let previewView = previewView else {
                                return
                            }
                            
                            var heightToCell = cellRectInWindow.origin.y
                            let space = previewView.bounds.height + 12
                            
                            let reactionViewHeight: CGFloat = reactionView.viewHeight
                            
                            menuView.menuItems = [deleteForMe, deleteForAll]
                            
                            
                            
                            let menuItemsHeight = CGFloat(Int(menuView.menuHeight))
                            menuHeightConstraint?.constant = menuItemsHeight
                            
                            if cellRectInWindow.origin.y + menuItemsHeight + space > window.safeAreaLayoutGuide.layoutFrame.maxY {
                                let extra = cellRectInWindow.origin.y + menuItemsHeight - window.safeAreaLayoutGuide.layoutFrame.maxY
                                heightToCell -= extra + space
                            }
                            // top safe area
                            else if cellRectInWindow.origin.y - reactionViewHeight  < window.safeAreaLayoutGuide.layoutFrame.minY {
                                let extra = cellRectInWindow.origin.y - window.safeAreaLayoutGuide.layoutFrame.minY
                                heightToCell -= extra
                            }
                            
                            
//                            print("message: ", message?.createdAt, indexPath?.row)
                            
                            UIView.animate(withDuration: 0.2 ) {
                                previewViewNewBottomAnchor?.constant = heightToCell
                                reactionView.alpha = 0
                                window.layoutIfNeeded()
                            }
                            
                             
                            print(Language.delete)
                        }
                    return option
                }()
        
        menuView.menuItems = [archiveOption, readUnReadOption, pinUnpinOption, muteUnMuteOption, forward, select, DeleteExitGroupOption]
    }
}





















