////
////  YoutubeLinkMessage.swift
////  Swift_UIKit_ChatApp
////
////  Created by Al-Tameemi Hayder on 29.7.2023.
////
//
//import UIKit
//
//class CTRMOnlyYoutubeMessage: UITableViewCell {
//
//        static let identifier = "CTRMOnlyYoutubeMessage"
//        
//        var updateMessage: (() -> Void) = {}
//        var noInternetMessage: (() -> Void) = {}
//
//
//        let bubbleView: UIView = {
//            let view = UIView()
//            view.translatesAutoresizingMaskIntoConstraints = false
//            view.layer.cornerRadius = 15
//            view.clipsToBounds = true
//            return view
//        }();
//
//        let messageTime: UILabel = {
//            let label = UILabel()
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.numberOfLines = 1
//
//            label.font = UIFont.systemFont(ofSize: 13)
//            return label
//        }();
//
//        let messageTextLabel: UILabel = {
//            let label = UILabel()
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.numberOfLines = 0
//            label.font = UIFont.systemFont(ofSize: 18)
//            return label
//        }();
//
//
//        let messageImage: ImageViewPro = {
//            let image = ImageViewPro()
//            image.translatesAutoresizingMaskIntoConstraints = false
//            image.layer.cornerRadius = 12
//            image.clipsToBounds = true
//            return image
//        }();
//
//        let videoPlayView = UIView()
//
//        var isAuth: Bool = false
//
//        var appName: String!
//        var diskPath: String!
//        var videoDiskPath: String!
//        var photoData: PhotoMessage?
//        var videoPhotoData: VideoMessage?
//
//
//
//
//
//
//        var messageBubbleLeading: NSLayoutConstraint?
//        var messageBubbleTrailing: NSLayoutConstraint?
//        var messageImageBottomToBubbleView: NSLayoutConstraint?
//        var messageImageWidthConstraint: NSLayoutConstraint?
//        var messageImageHeightConstraint: NSLayoutConstraint?
//
//
//
//
//
//
//
//
//
//
//        override func setSelected(_ selected: Bool, animated: Bool) {
//            super.setSelected(selected, animated: animated);
//            selectionStyle = .none
//        }
//
//
//        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//            super.init(style: style, reuseIdentifier: reuseIdentifier)
//            self.backgroundColor = .systemBackground
//            configureUI();
//            //layoutIfNeeded()
//        }
//
//        override func prepareForReuse() {
//            super.prepareForReuse()
//            messageTime.text = nil
//            messageTextLabel.text = nil
//            messageImage.image = nil
//            photoData = nil
//            messageImageWidthConstraint?.isActive = false
//            messageImageWidthConstraint = nil
//            messageImageHeightConstraint?.isActive = false
//            messageImageHeightConstraint = nil
//
//        }
//
//
//
//        override func layoutSubviews() {
//            super.layoutSubviews()
//
//            if isAuth {
//                messageTextLabel.textColor = .white
//                bubbleView.backgroundColor = AppTheme.sucsessColor
//                messageBubbleTrailing?.isActive = true
//                messageBubbleLeading?.isActive = false
//
//                messageTime.textColor = .white
//                messageTime.alpha = 0.68
//
//            } else {
//                messageTextLabel.textColor = .label
//                bubbleView.backgroundColor = .systemGray6
//                messageBubbleLeading?.isActive = true
//                messageBubbleTrailing?.isActive = false
//
//                messageTime.textColor = .lightGray
//                messageTime.alpha = 1
//            }
//        }
//
//
//    func configureYoutubeView(videoID: String) {
//            let thumbnailUrlString = "https://img.youtube.com/vi/\(videoID)/0.jpg"
//            // Load the thumbnail image into the image view
//            if let thumbnailUrl = URL(string: thumbnailUrlString),
//               let imageData = try? Data(contentsOf: thumbnailUrl),
//               let image = UIImage(data: imageData) {
//                messageImage.image = image
//            }
//        }
//
//
//
//        func configure(message: Message, isSelecting: Bool) {
//
//            isAuth = message.senderId == DataStore.shared.user.id ? true : false
//            messageTime.text = getTimeStampTime(date: message.createdAt)
//
//            let text = message.textMessage!
//            messageTextLabel.text = text
//
//        }
//
//
//        func configureUI() {
//            addSubview(bubbleView)
//            contentView.addSubview(messageImage)
//            addSubview(messageImage)
//    //        addSubview(messageLocationMapView!)
//            addSubview(messageTime)
//            addSubview(messageTextLabel)
//
//            bubbleView.layer.zPosition = 0
//            messageImage.layer.zPosition = 1
//
//
//            messageTime.layer.zPosition = 3
//
//            bubbleView.isUserInteractionEnabled = false
//            messageTime.isUserInteractionEnabled = false
//
//
//            //MessageTime
//            configureMessageTime()
//
//            //messageImage
//            configureMessageImage()
//
//            //messageText
//            configureMessageText()
//
//            //messageBubble
//            configureMessageBubble()
//          }
//
//        func configureMessageTime() {
//
//            messageTime.textAlignment = .right
//
//            let messageTimeLeadingConstraint = messageTime.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 13)
//            let messageTimeTrailingConstraint = messageTime.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -13)
//
//            messageTimeLeadingConstraint.priority = .defaultLow
//            messageTimeTrailingConstraint.priority = .defaultHigh
//
//            NSLayoutConstraint.activate([
//
//                //messageTime.topAnchor.conƒstraint(equalTo: messageTextLabel.bottomAnchor, constant: 5),
//                messageTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12.5),
//                messageTimeLeadingConstraint,
//                messageTimeTrailingConstraint,
//            ])
//        }
//
//
//        func configureMessageBubble() {
//
//            let screenWidth = UIScreen.main.bounds
//            let eighty_percent = CGFloat(screenWidth.width * 0.8)
//            NSLayoutConstraint.activate([
//                bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: eighty_percent),
//                //bubbleView.widthAnchor.constraint(equalToConstant: 0),
//                bubbleView.topAnchor.constraint(equalTo: messageImage.topAnchor, constant: -2),
//                bubbleView.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor, constant: 10),
//
//            ])
//
//            messageBubbleLeading = bubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
//            messageBubbleTrailing = bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
//
//        }
//
//
//        @objc func onImageCLick() {
//
//            print("youtube link pressed")
//
//        }
//
//
//        func configureMessageImage() {
//
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onImageCLick))
//            addGestureRecognizer(tapGesture)
//
//            messageImage.isUserInteractionEnabled = true
//
//            NSLayoutConstraint.activate([
//                messageImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//                //messageImage.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -2),
//                messageImage.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 2),
//                messageImage.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -2),
//                messageImage.bottomAnchor.constraint(equalTo: messageTextLabel.topAnchor, constant: -5),
//            ])
//
//        }
//
//
//
//
//        func configureMessageText() {
//
//            NSLayoutConstraint.activate([
//                //messageTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
//                //messageTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
//                messageTextLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 13),
//                messageTextLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -13),
//                messageTextLabel.topAnchor.constraint(equalTo: messageImage.bottomAnchor, constant: 13),
//                messageTextLabel.bottomAnchor.constraint(equalTo: messageTime.topAnchor, constant: -2.5),
//
//                //messageTextLabel.widthAnchor.constraint(lessThanOrEqualToConstant: eighty_percent),
//                ])
//
//
//        }
//
//
//
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//
//}
