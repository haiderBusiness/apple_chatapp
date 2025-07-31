//
//  Backup saved.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 8.6.2023.
//



///         <-> movePinnedCellToOriginalPlace<->

//func movePinnedCellToOriginalPlace(cellToPinIndexPath: IndexPath) {
//    
//    let thisChat = self.chatrooms[cellToPinIndexPath.row];
//    
//    if let findChatLaterThanThis = chatrooms.filter({ !$0.pinned && $0.lastMessageDate < thisChat.lastMessageDate}).min(by: { $0.lastMessageDate > $1.lastMessageDate }) {
//        
//        if let index = chatrooms.firstIndex(where: { $0.id == findChatLaterThanThis.id }) {
//            // Chat room found, index is available
//            let pinnedCell = self.chatrooms.remove(at: cellToPinIndexPath.row)
//            chatrooms.insert(pinnedCell, at: index)
//            tableView.moveRow(at: cellToPinIndexPath, to: IndexPath(row: index, section: 0))
//            self.chatrooms[cellToPinIndexPath.row].pinnedAt = Date()
//        }
//        //print("Chat room with closest date: \(findChatLaterThanThis.name)")
//        print("first statment chat is the found chat: \(findChatLaterThanThis.name)")
//    } else if let findPinnedChatLaterThanThis = chatrooms.filter({ $0.pinned && $0.pinnedAt != nil }).min(by: { $0.pinnedAt! < $1.pinnedAt! }) {
//        
//        print("before last statment chat is the found chat: \(findPinnedChatLaterThanThis.name)")
//        
//        if let index = chatrooms.firstIndex(where: { $0.id == findPinnedChatLaterThanThis.id }) {
//            // Chat room found, index is available
//            let pinnedCell = self.chatrooms.remove(at: cellToPinIndexPath.row)
//            chatrooms.insert(pinnedCell, at: index)
//            tableView.moveRow(at: cellToPinIndexPath, to: IndexPath(row: index, section: 0))
//            self.chatrooms[cellToPinIndexPath.row].pinnedAt = Date()
//        }
//    } else {
//        print("Last statment ")
//        self.chatrooms[cellToPinIndexPath.row].pinnedAt = nil
//    }
//    
//    
//}



















///         <-> headerEditButton.addTarget <->

////headerEditButton.addTarget(self, action: #selector(headerEditButtonTapped), for: .touchUpInside)
//var headerEditButton: UIBarButtonItem!
//var headerAddChatButton: UIBarButtonItem!
//
//let editButtonView = UIButton(type: .system)
//let editLabel: UILabel = {
//    let editLabel = UILabel()
//    editLabel.translatesAutoresizingMaskIntoConstraints = false
//    editLabel.text = Language.edit
//    editLabel.textColor = AppTheme.primaryColor
//    return editLabel
//}();
//
//let addChatButtonView = UIButton(type: .system)
//
//let addChatIcon: ImageViewPro = {
//    var addChatIcon = ImageViewPro()
//    addChatIcon.translatesAutoresizingMaskIntoConstraints = false;
//    addChatIcon.image = UIImage(systemName: "square.and.pencil")
//    addChatIcon.tintColor = AppTheme.primaryColor
//    return addChatIcon
//}()
//
//
//var addChatButtonWidthConstraint: NSLayoutConstraint!;
//
//lazy var addChatButtonWidth = addChatButtonView.widthAnchor.constraint(equalToConstant: 50)
//
//
//private func configureNavigation()  {
//
//
//
////            headerAddChatButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"),
////                                              style: .plain,
////                                              target: self,
////                                              action: #selector(rightHeaderButtonTapped));
//
////            headerEditButton = UIBarButtonItem(title: Language.edit, style: .plain, target: self, action: #selector(headerEditButtonTapped))
////            headerEditButton.tintColor = AppTheme.primaryColor
//
//    //headerAddChatButton.tintColor = AppTheme.primaryColor
//
//
//    editButtonView.addTarget(self, action: #selector(onEditButtonPress), for: .touchUpInside)
//    editButtonView.addSubview(editLabel)
//
//    addChatButtonView.addTarget(self, action: #selector(onAddChatButtonPress), for: .touchUpInside)
//    addChatButtonView.addSubview(addChatIcon)
//
//    let customEditNav = UIBarButtonItem(customView: editButtonView)
//    let customAddChatNav = UIBarButtonItem(customView: addChatButtonView)
//    addChatButtonWidth.isActive = true
//
//    NSLayoutConstraint.activate([
//        editLabel.centerXAnchor.constraint(equalTo: editButtonView.centerXAnchor),
//        editLabel.centerYAnchor.constraint(equalTo: editButtonView.centerYAnchor),
//        addChatIcon.centerXAnchor.constraint(equalTo: addChatButtonView.centerXAnchor),
//        addChatIcon.centerYAnchor.constraint(equalTo: addChatButtonView.centerYAnchor),
//
//    ])
//
//    navigationItem.rightBarButtonItems = [customAddChatNav, customEditNav]
//}
//
//
//
//@objc func onEditButtonPress() {
//    print("edit click")
//    if isSelecting  {
//        isSelecting = false
////                let transition = CATransition()
////                transition.duration = 0.3
////                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
////                transition.type = CATransitionType.fade
////                textLabel.layer.add(transition, forKey: nil)
////                textLabel.text = Language.edit
//
//        UIView.transition(with: editLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
//            self.editLabel.text = Language.edit
//        }, completion: nil)
//
//        UIView.animate(withDuration: 0.5, animations: {
//            self.addChatButtonWidthConstraint.isActive = false
//            self.view.layoutIfNeeded()
//        })
//
//    } else {
//
//        isSelecting = true
//
////                let animation = CABasicAnimation(keyPath: "text")
////                animation.fromValue = textLabel.text
////                animation.toValue = Language.done
////                animation.duration = 0.5
////                animation.fillMode = .forwards
////                animation.isRemovedOnCompletion = false
////                animation.beginTime = CACurrentMediaTime()
////                textLabel.layer.add(animation, forKey: nil)
////                textLabel.text = Language.done
//
//
////                let transition = CATransition()
////                transition.duration = 0.3
////                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
////                transition.type = CATransitionType.fade
////
////                textLabel.layer.add(transition, forKey: nil)
////                textLabel.text = Language.done
//
//        UIView.transition(with: editLabel, duration: 0.5, options: .transitionCrossDissolve, animations: {
//            self.editLabel.text = Language.done
//        }, completion: nil)
//
//
//
////                UIButton.animate(withDuration: 2) {
////                    self.addChatButtonWidth.constant = 0;
////                            self.view.layoutIfNeeded()
////                        }
////                let animator = UIViewPropertyAnimator(duration: 2, curve: .linear, animations: {
////                    self.addChatButtonWidth.constant = 0;
////                        })
////
////                animator.startAnimation()
//
////                UIView.animate(withDuration: 2, animations: {
////
////                    self.view.layoutIfNeeded()
////                })
//
//        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 2, delay: 0, options: [], animations: {
//            self.addChatButtonWidth.constant = 0;
//                })
//
//
//
//
//
////                let titleAnimation = CATransition()
////                   titleAnimation.duration = 0.25
////                   titleAnimation.type = CATransitionType.push
////                   titleAnimation.subtype = CATransitionSubtype.fromRight
////                   titleAnimation.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut)
//
////                self.textLabel.layer.add(titleAnimation, forKey: "changeTitle")
//
////                UILabel.animate(withDuration: 0.25, animations: {
////                    self.textLabel.text = Language.done
////
////                })
//
//    }
//}
//
////        @objc func headerEditButtonTapped() {
////            print("Right header button clicked ")
////        }
//
//
//@objc func onAddChatButtonPress() {
//    print("Right header button clicked ")
//}





///         <-> set image size funciton <->


//    func setImageSize(size: ImageSize?) {
//        if let myImage = messageImage.image {
//
//            let screenWidth = UIScreen.main.bounds
//
//            let maxWidth = (screenWidth.width * 0.8)
//            let maxHeight = CGFloat(450)
//
//
//            let imageSize = myImage.size
//            let widthRatio  = maxWidth  / imageSize.width
//            let heightRatio = maxHeight / imageSize.height
//
//                let newImageSize = widthRatio > heightRatio ?  CGSize(width: imageSize.width * heightRatio, height: imageSize.height * heightRatio) : CGSize(width: imageSize.width * widthRatio,  height: imageSize.height * widthRatio)
//
////            let newImageSize =  CGSize(width: imageSize.width * heightRatio, height: imageSize.height * heightRatio)
//
//            messageImageWidthConstraint = messageImage.widthAnchor.constraint(equalToConstant: newImageSize.width * 0.8)
//            messageImageWidthConstraint?.isActive = true
//
//            messageImageHeightConstraint = messageImage.heightAnchor.constraint(equalToConstant: newImageSize.height * 0.8)
//            messageImageHeightConstraint?.isActive = true
//
////            imageSizeIsSet = true
//
//        }
        
//        if let size = size {
//            let screenWidth = UIScreen.main.bounds
//
//            let maxWidth = (screenWidth.width * 0.8)
//            let maxHeight = CGFloat(450)
//
//
//            let imageSize = size
//            let widthRatio  = maxWidth  / imageSize.width
//            let heightRatio = maxHeight / imageSize.height
//
//                let newImageSize = widthRatio > heightRatio ?  CGSize(width: imageSize.width * heightRatio, height: imageSize.height * heightRatio) : CGSize(width: imageSize.width * widthRatio,  height: imageSize.height * widthRatio)
//
////            let newImageSize =  CGSize(width: imageSize.width * heightRatio, height: imageSize.height * heightRatio)
//
//            messageImageWidthConstraint = messageImage.widthAnchor.constraint(equalToConstant: newImageSize.width * 0.8)
//            messageImageWidthConstraint?.isActive = true
//
//            messageImageHeightConstraint = messageImage.heightAnchor.constraint(equalToConstant: newImageSize.height * 0.8)
//            messageImageHeightConstraint?.isActive = true
//        }
//
//        else {
//            messageImageWidthConstraint = messageImage.widthAnchor.constraint(equalToConstant: 300)
//            messageImageWidthConstraint?.isActive = true
//
//            messageImageHeightConstraint = messageImage.heightAnchor.constraint(equalToConstant: 300)
//            messageImageHeightConstraint?.isActive = true
//
//        }
//
//
//    }




////  <-> ImageViewPro
//var imageCache = NSCache<AnyObject, AnyObject>();
//
//class ImageViewPro: UIImageView {
//
//    func load(urlString: String, completion: (() -> Void)? = nil) {
//
//            //check if image is cached
//            if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
//                self.image = image;
//                if let _ = completion {
//                    completion!()
//                }
//                return
//            }
//
//            // check if received string prop is valid make it of type URL
//            guard let url = URL(string: urlString) else{
//                return
//            }
//
//
//
//            // load web image
//            DispatchQueue.global().async { [weak self] in
//                if let data = try? Data(contentsOf: url) {
//                    if let image = UIImage(data: data) {
//                        DispatchQueue.main.async {
//                            imageCache.setObject(image, forKey: urlString as NSString)
//                            self?.image = image
//                            if let _ = completion {
//                                completion!()
//                            }
//                        }
//                    }
//                }
//            }
//        }
//
//
//    func LoadSaveDisplayImage(originalImageUrl: String , placeHolderUrl: String, placeHolder: Bool, saveImage: Bool, folderName: String, completion: ((Bool) -> Void)? = nil) {
//
//
//        if placeHolder {
//            // load placeHolder
//            if let image = loadImageFromDisk(fileName: placeHolderUrl, folderName: folderName) {
//                self.image = image
//                if let _ = completion {
//                    completion!(true)
//                }
//                return
//            } else if let image = loadImageFromDisk(fileName: originalImageUrl, folderName: folderName) {
//                self.image = image
//                if let _ = completion {
//                    completion!(true)
//                }
//
//                return
//            }
//
//        } else {
//            // load original image
//            if let image = loadImageFromDisk(fileName: originalImageUrl, folderName: folderName) {
//                self.image = image
//                if let _ = completion {
//                    completion!(true)
//                }
//            }
//
//            return
//        }
//
//
//        let imageUrl = placeHolder ? placeHolderUrl : originalImageUrl
//
//        guard let url = URL(string: imageUrl) else{
//            return
//        }
//
//
//
//        // load web image
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//
//                        if saveImage {
//                            if placeHolder {
//                                // save placeHolder
//                                saveImageToDisk(imageData: data, fileName: placeHolderUrl, folderName: folderName)
//                            } else {
//                                // remove placeHolder
//                                removeImageFromDisk(fileName: placeHolderUrl, folderName: folderName)
//                                // save origianl image
//                                saveImageToDisk(imageData: data, fileName: originalImageUrl, folderName: folderName)
//                            }
//                        }
//
//
//                        self?.image = image
//                        if let _ = completion {
//                            completion!(true)
//                        }
//                    }
//                }
//            }
//        }
//
//
//    }
//
//
//
//
//
//        func icon() {
//            self.image = Empty.image
//        }
//}




