//
//  asfdasdf.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 14.7.2023.
//

import UIKit

class PhotoWithTextMessageCell: CoreMessageCell {
    
    static let identifier = "PhotoWithTextMessageCell"

    
    
    let urlLoadingProgress = UrlLoadingProgress()
    
    let downloadImageVideoView = DownloadImageVideoView()
    
    let videoPlayView = UIView()
    
    
    
    var downloadContainerWidthConstraint : NSLayoutConstraint?
    
    
    var appName: String!
    var diskPath: String!
    var videoDiskPath: String!
    var photoData: PhotoMessage?
    var videoPhotoData: VideoMessage?
    
    
    
    
    
    
    var messageBubbleLeading: NSLayoutConstraint?
    var messageBubbleTrailing: NSLayoutConstraint?
    var messageImageBottomToBubbleView: NSLayoutConstraint?
    var messageImageWidthConstraint: NSLayoutConstraint?
    var messageImageHeightConstraint: NSLayoutConstraint?
    var messageImageLeadingAnchor: NSLayoutConstraint?
    var messageImageTrailingAnchor: NSLayoutConstraint?
    

    
    
    
    
    
    
    
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageTime.text = nil
        messageTextLabel.text = nil
        messageImage.image = nil
        photoData = nil
        //        messageImageWidthConstraint?.isActive = false
        //        messageImageWidthConstraint = nil
        //        messageImageHeightConstraint?.isActive = false
        //        messageImageHeightConstraint = nil
        messageImageWidthConstraint?.constant = 0
        messageImageHeightConstraint?.constant = 0
        
        downloadContainerWidthConstraint?.isActive = false
        downloadContainerWidthConstraint = nil
        longPressRecognizer?.isEnabled = false
        
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isAuth {
            messageTextLabel.textColor = .white
            bubbleView.backgroundColor = AppTheme.sucsessColor
            
            messageImageLeadingAnchor?.isActive = false // // image leading to parent leading
            messageImageTrailingAnchor?.isActive = true // image trailing to parent trailing
            
//            if let messageBubbleTrailing = messageBubbleTrailing {
//                messageBubbleTrailing.isActive = true // bubble trailing to parent leading
//
//                messageImageTrailingAnchor?.isActive = true // image trailing to parent trailing
//
//                messageBubbleLeading?.isActive = false
//                messageBubbleLeading = bubbleView.leadingAnchor.constraint(equalTo: messageImage.leadingAnchor, constant: -2)
//                messageBubbleLeading?.isActive = true
//            }
//            messageBubbleTrailing?.isActive = true
//            messageBubbleLeading?.isActive = false

            messageTime.textColor = .white
            messageTime.alpha = 0.68

        } else {
            messageTextLabel.textColor = .label
            bubbleView.backgroundColor = .systemGray6
            
            messageImageTrailingAnchor?.isActive = false // image trailing to parent trailing
            messageImageLeadingAnchor?.isActive = true // image leading to parent trailing
            
//            if let messageBubbleLeading = messageBubbleTrailing {
//                messageBubbleLeading.isActive = true
//
//                messageBubbleTrailing?.isActive = false
//                messageBubbleTrailing = bubbleView.trailingAnchor.constraint(equalTo: messageImage.trailingAnchor, constant: -2)
//                messageBubbleTrailing?.isActive = true
//            }
//
//            messageBubbleLeading?.isActive = true
//            messageBubbleTrailing?.isActive = false
            
            messageTime.textColor = .lightGray
            messageTime.alpha = 1
        }
    }
    
    
    
    func videoOrPhoto(message: Message) {
        
        appName = DataStore.shared.appName
        diskPath = appName + "/chats/\(message.chatroomId)/images"
        videoDiskPath = appName + "/chats/\(message.chatroomId)/videos"
        
        
        let deviceUinqueId = DataStore.shared.deviceUniqueIdentifier
        
        // if message is photoMessage
        if let photoObject = message.photoMessage {
            videoPlayView.alpha = 0
            photoData = photoObject
            downloadImageVideoView.photoSizeInBytesLabel.text = photoObject.photoSizeInBytes
//            print("device unique id : ", deviceUinqueId, "saved device id: ", photoObject.savedOnDeviceId)
            if let savedOnDeviceId = photoObject.savedOnDeviceId {
    //            print("saved on device: ", savedOnDeviceId, deviceUinqueId)
                if deviceUinqueId  == savedOnDeviceId {
                    
                    downloadImageVideoView.alpha = 0
                    messageImage.LoadSaveDisplayImage(originalImageUrl: photoObject.photoUrl, placeHolderUrl: photoObject.placeHolderUrl, savePlaceHolder: false, folderName:  diskPath)
                } else {
                    downloadImageVideoView.alpha = 1
                    messageImage.LoadSaveDisplayImage(originalImageUrl: photoObject.photoUrl, placeHolderUrl: photoObject.placeHolderUrl, savePlaceHolder: true, folderName:  diskPath)
                }
            } else {
                messageImage.LoadSaveDisplayImage(originalImageUrl: photoObject.photoUrl, placeHolderUrl: photoObject.placeHolderUrl, savePlaceHolder: true, folderName:  diskPath)
            }
            
            
            
            setImageSize(size: photoObject.photoSizeInPX)
            
        }
        // else if message is a video message
        else if let videoObject = message.videoMessage {
            videoPhotoData = videoObject
            downloadImageVideoView.photoSizeInBytesLabel.text = videoObject.videoSizeInBytes
            
            if let savedOnDeviceId = videoObject.savedOnDeviceId {
    //            print("saved on device: ", savedOnDeviceId, deviceUinqueId)
                if deviceUinqueId == savedOnDeviceId {
                    videoPlayView.alpha = 1
                    downloadImageVideoView.alpha = 0
                    messageImage.LoadSaveDisplayImage(originalImageUrl: videoObject.videoImageUrl, placeHolderUrl: videoObject.videoPlaceHolderUrl, savePlaceHolder: false, folderName:  diskPath)
                    
                } else {
                    videoPlayView.alpha = 0
                    downloadImageVideoView.alpha = 1
                    messageImage.LoadSaveDisplayImage(originalImageUrl: videoObject.videoImageUrl, placeHolderUrl: videoObject.videoPlaceHolderUrl, savePlaceHolder: true, folderName:  diskPath)
                }
            } else {
                videoPlayView.alpha = 0
                downloadImageVideoView.alpha = 1
                messageImage.LoadSaveDisplayImage(originalImageUrl: videoObject.videoImageUrl, placeHolderUrl: videoObject.videoPlaceHolderUrl, savePlaceHolder: true, folderName:  diskPath)
            }
            
            setImageSize(size: videoObject.photoSizeInPX)
        }
    }
    
    
    
    func configure(message: Message, isSelecting: Bool) {
        
        isAuth = message.senderId == DataStore.shared.user.id ? true : false
        messageTime.text = getTimeStampTime(date: message.createdAt)
        
        messageTextLabel.text = "message.textMessage akldsjfölahsdföl kajsdlf asöldfjalsökdfjöalkdfjöal kdjfaölksdjf öalksdfjölaksdf jölkj "
        
//        messageImage.load(urlString: message.photoMessage!.photoUrl)
//        messageImage.load(urlString: message.photoMessage!.placeHolderUrl)
        videoOrPhoto(message: message)
        
        if message.isRead {
            checkmarkImageView.image
        }
    }
    
    
    func configureUI() {
        contentView.addSubview(mainView)
        addSubview(mainView)
        
        mainView.addSubview(bubbleView)
//        mainView.contentView.addSubview(messageImage)
        mainView.addSubview(messageImage)
//        mainView.addSubview(messageLocationMapView!)
        mainView.addSubview(messageTime)
        mainView.addSubview(messageTextLabel)
        mainView.addSubview(checkmarkImageView)
        
        bubbleView.layer.zPosition = 0
        messageImage.layer.zPosition = 1
        
        
        messageTime.layer.zPosition = 3
        checkmarkImageView.layer.zPosition = 4
        
        bubbleView.isUserInteractionEnabled = false
        messageTime.isUserInteractionEnabled = false
        
 
        // mainView
        configureMainView()
        
        //MessageTime
        configureMessageTime()
        
        //messageImage
        configureMessageImage()
        
        //messageText
        configureMessageText()
        
        //messageBubble
        configureMessageBubble()
        
        // checkmark
        configureCheckmark()
      }
    
    func configureMainView() {
        NSLayoutConstraint.activate([
            //mainView.widthAnchor.constraint(equalToConstant: 0),
            mainView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor),
            mainView.topAnchor.constraint(equalTo: bubbleView.topAnchor),
        ])
    }
    
    func configureMessageTime() {
        
        messageTime.textAlignment = .right
        
        let messageTimeLeadingConstraint = messageTime.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 13)
        let messageTimeTrailingConstraint = messageTime.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -13)
        
        messageTimeLeadingConstraint.priority = .defaultLow
        messageTimeTrailingConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
          
            //messageTime.topAnchor.conƒstraint(equalTo: messageTextLabel.bottomAnchor, constant: 5),
            messageTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.5),
            messageTimeLeadingConstraint,
            messageTimeTrailingConstraint,
        ])
    }
    

    func configureCheckmark() {
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            //messageTime.topAnchor.conƒstraint(equalTo: messageTextLabel.bottomAnchor, constant: 5),
            checkmarkImageView.centerYAnchor.constraint(equalTo: messageTime.centerYAnchor),
            checkmarkImageView.trailingAnchor.constraint(equalTo: messageTime.leadingAnchor, constant: -5),
            checkmarkImageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 15),
            checkmarkImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),
            checkmarkImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 15),
            checkmarkImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 15),
        ])
    }


    
    //MARK: MessageBubble
    func configureMessageBubble() {
        
//        let screenWidth = UIScreen.main.bounds
//        let eighty_percent = CGFloat(screenWidth.width * 0.8)
        NSLayoutConstraint.activate([
//            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: eighty_percent),
            //bubbleView.widthAnchor.constraint(equalToConstant: 0),
            bubbleView.leadingAnchor.constraint(equalTo: messageImage.leadingAnchor, constant: -2),
            bubbleView.trailingAnchor.constraint(equalTo: messageImage.trailingAnchor, constant: 2),
            
            bubbleView.topAnchor.constraint(equalTo: messageImage.topAnchor, constant: -2),
            bubbleView.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor, constant: 10),
        ])
        
//        messageBubbleLeading = bubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
//        messageBubbleTrailing = bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        
    }
    
    
    
    //MARK: MessageImage
    func configureMessageImage() {
        
 
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onImageCLick))
        addGestureRecognizer(tapGesture)
        
        messageImage.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            messageImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            //messageImage.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -2),
            
            
            
            //FIXME: commented 2 lines
//            messageImage.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 2),
//            messageImage.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -2),
//            messageImage.bottomAnchor.constraint(equalTo: messageTextLabel.topAnchor, constant: 0),
        ])
        
        messageImageTrailingAnchor = messageImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        messageImageLeadingAnchor = messageImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        
        
        messageImageWidthConstraint = messageImage.widthAnchor.constraint(equalToConstant: 40)
        messageImageWidthConstraint?.isActive = true
                    
        messageImageHeightConstraint = messageImage.heightAnchor.constraint(equalToConstant: 40)
        messageImageHeightConstraint?.isActive = true
        
        self.configureBlurView()
        
    }
    
    
    
    //MARK: MessageText
    func configureMessageText() {
        
        
        NSLayoutConstraint.activate([
            //messageTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            //messageTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            
            //FIXME: old befored fixme commented
//            messageTextLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 13),
//            messageTextLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -13),
            
            //FIXME: new
            messageTextLabel.leadingAnchor.constraint(equalTo: messageImage.leadingAnchor, constant: 8),
            messageTextLabel.trailingAnchor.constraint(equalTo: messageImage.trailingAnchor, constant: -8),
            

            messageTextLabel.topAnchor.constraint(equalTo: messageImage.bottomAnchor, constant: 8),
            messageTextLabel.bottomAnchor.constraint(equalTo: messageTime.topAnchor, constant: -2.5),
            
            //messageTextLabel.widthAnchor.constraint(lessThanOrEqualToConstant: eighty_percent),
            ])
        
            
    }
    
    
    
    //MARK: ImageTap
    @objc func onImageCLick() {
        
            if downloadImageVideoView.customProgressView.alpha == 1 {
                self.setDownloadInfoViewToDefault()
            }
            
            else if let photoObject = photoData {
                downloadImageVideoView.showHideIndicator(show: true)
                // if same device id load image from disk
                if let savedOnDeviceId = photoObject.savedOnDeviceId {
                    if DataStore.shared.deviceUniqueIdentifier != savedOnDeviceId {
                        downloadImage(originalImageUrl: photoObject.photoUrl, placeHolderUrl: photoObject.placeHolderUrl, folderName: diskPath)
                    }
                } else {
                    // download image from server
                    downloadImageVideoView.showHideIndicator(show: true)
                    if let photoData = photoData {
                        downloadImage(originalImageUrl: photoData.photoUrl, placeHolderUrl: photoData.placeHolderUrl, folderName: diskPath)
                    }
                }
                
            } else if let videoObject = videoPhotoData {
                downloadImageVideoView.showHideIndicator(show: true)
                // if same device id load only image not video from disk (video wil be displayied elsewhere)
                if let savedOnDeviceId = videoObject.savedOnDeviceId {
                    if DataStore.shared.deviceUniqueIdentifier != savedOnDeviceId {
                        downloadImage( originalImageUrl: videoObject.videoImageUrl, placeHolderUrl: videoObject.videoPlaceHolderUrl, folderName: diskPath)
                    }
                } else {
                    // download image and video from server
                    downloadImageVideoView.showHideIndicator(show: true)
                    downloadImage(videoUrl: videoObject.videoUrl, originalImageUrl: videoObject.videoImageUrl, placeHolderUrl: videoObject.videoPlaceHolderUrl, folderName: diskPath)
                }
                
            }
        
    }
    
    
    
    

    

    
    func setImageSize(size: ImageSizeInPX?) {
        if let size = size {
            let screenWidth = UIScreen.main.bounds
            
            let maxWidth = (screenWidth.width * 0.8)
            let maxHeight = CGFloat(450)
            
            let imageSize = size
            let widthRatio  = maxWidth  / imageSize.width
            let heightRatio = maxHeight / imageSize.height

            let newImageSize = widthRatio > heightRatio ?  CGSize(width: imageSize.width * heightRatio, height: imageSize.height * heightRatio) : CGSize(width: imageSize.width * widthRatio,  height: imageSize.height * widthRatio)
               
//            let newImageSize =  CGSize(width: imageSize.width * heightRatio, height: imageSize.height * heightRatio)
            
//            messageImageWidthConstraint = messageImage.widthAnchor.constraint(equalToConstant: newImageSize.width * 0.8)
//            messageImageWidthConstraint?.isActive = true
            
//            messageImageHeightConstraint = messageImage.heightAnchor.constraint(equalToConstant: newImageSize.height * 0.8)
//            messageImageHeightConstraint?.isActive = true
            
            messageImageWidthConstraint?.constant = newImageSize.width * 0.8
            messageImageHeightConstraint?.constant = newImageSize.height * 0.8
        }
        
        else {
//            messageImageWidthConstraint = messageImage.widthAnchor.constraint(equalToConstant: 300)
//            messageImageWidthConstraint?.isActive = true
//
//            messageImageHeightConstraint = messageImage.heightAnchor.constraint(equalToConstant: 300)
//            messageImageHeightConstraint?.isActive = true
            
//            imageSizeIsSet = false
            
            messageImageWidthConstraint?.constant = 300
            messageImageHeightConstraint?.constant = 300
        }
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


