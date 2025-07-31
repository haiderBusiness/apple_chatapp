//
//  chatroomMessageCell.swift
//  Swift_UIKit_messageApp
//
//  Created by Al-Tameemi Hayder on 23.6.2023.
//

import UIKit

class ChatroomCell: UITableViewCell {
    
    static let identifier = "ChatroomCell"
    
    
    var selectionIcon = ImageViewPro();
    
    var selectionWidthConstraint: NSLayoutConstraint?;
    
    
    var updateMessage: ((_ media: (isVideo: Bool, isPhoto: Bool)) -> Void) = { media in}
    var noInternetMessage: (() -> Void) = {}
    
    
    
    
    
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
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }();
    
    let messageTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }();
    
    
    
    let messageTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }();
    
    let messageTimeBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        let blur = BlurComponent.addBlur(toView: view, blurStyle: .dark)
        view.backgroundColor = .black
        view.alpha = 0.2
//        view.addSubview(blur)
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }();
    
    
    let messageImage: ImageViewPro = {
        let image = ImageViewPro()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }();
    
    
    
    //               var messageLocationMapView : CoreChatroomCellMap = {
    //                    let map = ChatroomCellMap()
    //                    map.overrideUserInterfaceStyle = .dark
    //                    map.layer.cornerRadius = 12
    //                    map.clipsToBounds = true
    //                    return map
    //                }()
    
    var messageLocationMapView = MapView()

    
    var messageTextLeading: NSLayoutConstraint?
    var messageTextTrailing: NSLayoutConstraint?
    var messageTextBottom: NSLayoutConstraint?
    var messageTextDefaultTop: NSLayoutConstraint?
    var messageTextbottomToTime: NSLayoutConstraint?
    var messageTextTopToLocation: NSLayoutConstraint?
    
    
    
    
    var messageBubbleLeadingToMessage: NSLayoutConstraint?
    var messageBubbleTrailingToMessage: NSLayoutConstraint?
    var messageBubbleLeadingToTime: NSLayoutConstraint?
    var messageBubbleTrailingToTime: NSLayoutConstraint?
    var messageBubbleTopToImage: NSLayoutConstraint?
    var messageBubbleTopToTextMessage: NSLayoutConstraint?
    var messageBubbleTopToMapView: NSLayoutConstraint?
    
    
    
    
    
    var messageImageLeading: NSLayoutConstraint?
    var messageImageTrailing: NSLayoutConstraint?
    var messageImageBottomToTextMessage: NSLayoutConstraint?
    var messageImageBottomToBubbleView: NSLayoutConstraint?
    var messageImageHeightConstraint: NSLayoutConstraint?
    var messageImageWidthConstraint: NSLayoutConstraint?
    
    var messageImageViewWidth: Double = 0
    
    var imageSizeIsSet = false
    
    
    

    
    var messageLocationLeading: NSLayoutConstraint?
    var messageLocationTrailing: NSLayoutConstraint?
    var messageLocationBottomToTextMessage: NSLayoutConstraint?
    var messageLocationBottomToBubbleView: NSLayoutConstraint?
    var messageLocationHeightConstraint: NSLayoutConstraint?
    var messageLocationWidthConstraint: NSLayoutConstraint?
    
    
    

    
    
    
    let deviceUinqueId = DataStore.shared.deviceUniqueIdentifier
    
    let urlLoadingProgress = UrlLoadingProgress()
    
    let downloadImageVideoView = DownloadImageVideoView()
    
    let videoPlayView = UIView()
    
    
    
    var downloadContainerWidthConstraint : NSLayoutConstraint?
    
    var isAuth: Bool = false
    
    var appName: String!
    var diskPath: String!
    var videoDiskPath: String!
    var photoData: PhotoMessage?
    var videoPhotoData: VideoMessage?
    var message: Message? = nil
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
        selectionStyle = .none
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        configureUI();
        //layoutIfNeeded()
    }
    
    
//    override func prepareForReuse() {
//        messageImage.image = nil
//        messageLocationMapView = nil
//        messageTextLabel.text = nil
//    }
    
    
    func setImageToFalse() {
        messageImageLeading?.isActive = false
        messageImageTrailing?.isActive = false
        messageImageBottomToTextMessage?.isActive = false
        messageImageBottomToBubbleView?.isActive = false
        messageImageWidthConstraint?.isActive = false
        messageImageHeightConstraint?.isActive = false
        imageSizeIsSet = false
        messageImageViewWidth = 0
    }
    
    func setLocationToFalse() {
        messageLocationLeading?.isActive = false
        messageLocationTrailing?.isActive = false
        messageLocationBottomToTextMessage?.isActive = false
        messageLocationBottomToBubbleView?.isActive = false
        messageLocationHeightConstraint?.isActive = false
        messageLocationWidthConstraint?.isActive = false
    }
    
    func setMessageBubbleToFalse() {
        messageBubbleLeadingToMessage?.isActive = false
        messageBubbleTrailingToMessage?.isActive = false
        messageBubbleLeadingToTime?.isActive = false
        messageBubbleTrailingToTime?.isActive = false
        messageBubbleTopToImage?.isActive = false
        messageBubbleTopToTextMessage?.isActive = false
        messageBubbleTopToMapView?.isActive = false
    }
    
    
    func setMessageToFalse() {
        messageTextLeading?.isActive = false
        messageTextTrailing?.isActive = false
        messageTextBottom?.isActive = false
        messageTextDefaultTop?.isActive = false
        messageTextbottomToTime?.isActive = false
        messageTextTopToLocation?.isActive = false
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()

        messageTextLabel.text = nil
        messageImage.image = nil
        videoPlayView.alpha = 0
        photoData = nil
        videoPhotoData = nil
        
        setMessageToFalse()
        setMessageBubbleToFalse()
        setImageToFalse()
        setLocationToFalse()
        
        
        //messageImage.frame.size = CGSize(width: -1, height: -1)

//        messageImage.frame = CGRect(origin: messageImage.frame.origin, size: messageImage.intrinsicContentSize)
    }

    
    
    func configureSelection() {
        
        //container.addSubview(selectionIcon)
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
        selectionWidthConstraint?.isActive = true
    }

   

   
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

}
