//
//  CTRMPhotoMessageCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 14.7.2023.
//


import UIKit

class PhotoMessageCell: CoreMessageCell {
    
    static let identifier = "PhotoMessageCell"
    
    
    
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
            bubbleView.backgroundColor = AppTheme.sucsessColor
            messageBubbleTrailing?.isActive = true
            messageBubbleLeading?.isActive = false
        } else {
            bubbleView.backgroundColor = .systemGray6
            messageBubbleLeading?.isActive = true
            messageBubbleTrailing?.isActive = false
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
            if let savedOnDeviceId = photoObject.savedOnDeviceId {
    //            print("saved on device: ", savedOnDeviceId, deviceUinqueId)
                if deviceUinqueId  == savedOnDeviceId {
                    downloadImageVideoView.alpha = 0
                    messageImage.LoadSaveDisplayImage(originalImageUrl: photoObject.photoUrl, placeHolderUrl: photoObject.placeHolderUrl, savePlaceHolder: false, folderName:  diskPath)
                } else {
                    downloadImageVideoView.alpha = 1
                    messageImage.LoadSaveDisplayImage(originalImageUrl: photoObject.photoUrl, placeHolderUrl: photoObject.placeHolderUrl, savePlaceHolder: true, folderName:  diskPath)
                }
            }
            else {
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
                if deviceUinqueId  == savedOnDeviceId {
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
//        messageImage.load(urlString: message.photoMessage!.photoUrl)
//        messageImage.load(urlString: message.photoMessage!.placeHolderUrl)

        videoOrPhoto(message: message)
        
    }
    
    
    func configureUI() {
        contentView.addSubview(mainView)
        addSubview(mainView)
        
        mainView.addSubview(bubbleView)
//        contentView.addSubview(messageImage)
        mainView.addSubview(messageImage)
//        addSubview(messageLocationMapView!)
        mainView.addSubview(messageTimeBackground)
        mainView.addSubview(messageTime)
        
        bubbleView.layer.zPosition = 0
        messageImage.layer.zPosition = 1
        
        messageTimeBackground.layer.zPosition = 2
        messageTime.layer.zPosition = 3
        
        bubbleView.isUserInteractionEnabled = false
        messageTime.isUserInteractionEnabled = false
        messageTimeBackground.isUserInteractionEnabled = false
        
        
        // mainView
        configureMainView()
 
        //MessageTime
        configureMessageTime()
        
        //messageImage
        configureMessageImage()
        
        //messageBubble
        configureMessageBubble()
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
        
        messageTimeBackground.alpha = 0.3
        messageTime.alpha = 1
        messageTime.textColor = .white
        
        messageTime.textAlignment = .right
        
        let messageTimeLeadingConstraint = messageTime.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 13)
        let messageTimeTrailingConstraint = messageTime.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -13)
        
        messageTimeLeadingConstraint.priority = .defaultLow
        messageTimeTrailingConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            messageTimeBackground.leadingAnchor.constraint(equalTo: messageTime.leadingAnchor, constant: -2),
            
            messageTimeBackground.trailingAnchor.constraint(equalTo: messageTime.trailingAnchor, constant: 2),
            //messageTimeBackground.topAnchor.constraint(equalTo: messageTime.topAnchor, constant: 25),
            messageTimeBackground.topAnchor.constraint(equalTo: messageTime.topAnchor, constant: -2),
            //messageTimeBackground.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor,constant: -10)
            messageTimeBackground.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor, constant: 2),
            
            //messageTime.topAnchor.conƒstraint(equalTo: messageTextLabel.bottomAnchor, constant: 5),
            
            // FIXME: now
            messageTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.5),
            
            messageTimeLeadingConstraint,
            messageTimeTrailingConstraint,
        ])
        
        
    }

    
    func configureMessageBubble() {
        
        let screenWidth = UIScreen.main.bounds
        let eighty_percent = CGFloat(screenWidth.width * 0.8)
        NSLayoutConstraint.activate([
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: eighty_percent),
            //bubbleView.widthAnchor.constraint(equalToConstant: 0),
            bubbleView.topAnchor.constraint(equalTo: messageImage.topAnchor, constant: -2),
            bubbleView.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor, constant: 10),
        ])
        
        messageBubbleLeading = bubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        messageBubbleTrailing = bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        
    }
    
    
    
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
    
    
    func configureMessageImage() {
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onImageCLick))
        addGestureRecognizer(tapGesture)
        
        messageImage.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            //FIXME: here 
            //messageImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            //messageImage.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -2),
            messageImage.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 2),
            messageImage.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -2),
            messageImage.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -2)
        ])
        
        messageImageWidthConstraint = messageImage.widthAnchor.constraint(equalToConstant: 0)
        messageImageWidthConstraint?.isActive = true
                    
        messageImageHeightConstraint = messageImage.heightAnchor.constraint(equalToConstant: 0)
        messageImageHeightConstraint?.isActive = true
        
        self.configureBlurView()
        
//        messageImageBottomToBubbleView = messageImage.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -2)
        
//        messageImageWidthConstraint = messageImage.widthAnchor.constraint(equalToConstant: 300)
//        messageImageHeightConstraint = messageImage.heightAnchor.constraint(equalToConstant: 300)
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






