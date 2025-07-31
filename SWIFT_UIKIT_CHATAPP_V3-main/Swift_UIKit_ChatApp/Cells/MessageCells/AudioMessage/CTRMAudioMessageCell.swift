//
//  CTRMVoiceMessageCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 29.7.2023.
//


import UIKit

class CTRMAudioMessageCell: CoreMessageCell {


    var onAudioClick: (() -> Void) = {}
    
    
    static let identifier = "CTRMAudioMessageCell"
    
    
    
    
    
    let audioPlayerView = AudioPlayerView();
    
    var messageBubbleLeading: NSLayoutConstraint?
    var messageBubbleTrailing: NSLayoutConstraint?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
        selectionStyle = .none
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated:false);
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI();
//        setupHiddenView();
        self.backgroundColor = .clear
        //layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageTime.text = nil
        audioPlayerView.audioUrlObject = nil
        audioPlayerView.resetToDefault()
        longPressRecognizer?.isEnabled = false
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isAuth {
            audioPlayerView.playButtonColor = .white
            audioPlayerView.wavesColor = UIColor.white.withAlphaComponent(0.65)
            audioPlayerView.wavesProgressColor = .white
            audioPlayerView.durationLabelColor = .white
            audioPlayerView.pointerColor = .white
            
            audioPlayerView.audioSpeedButtonColor = .white
            audioPlayerView.audioSpeedTextColor = AppTheme.sucsessColor
            
            checkmarkImageView.tintColor = UIColor.white.withAlphaComponent(0.7)
            bubbleView.backgroundColor = AppTheme.sucsessColor
            messageBubbleTrailing?.isActive = true
            messageBubbleLeading?.isActive = false

            messageTime.textColor = .white.withAlphaComponent(0.7)

        } else {
//            audioPlayerView.playButtonColor = .label
//            audioPlayerView.wavesColor = UIColor.label.withAlphaComponent(0.65)
//            audioPlayerView.wavesProgressColor = .label
//            audioPlayerView.durationLabelColor = .label
//            audioPlayerView.pointerColor = .label
            audioPlayerView.playButtonColor = .systemGray2
            audioPlayerView.wavesColor = .systemGray4
            audioPlayerView.wavesProgressColor = .systemGray2
            audioPlayerView.durationLabelColor = .systemGray2
            audioPlayerView.pointerColor = .systemGray2
            
            audioPlayerView.audioSpeedButtonColor = .systemGray2
            audioPlayerView.audioSpeedTextColor = .systemGray6
            

            checkmarkImageView.tintColor = UIColor.label.withAlphaComponent(0.4)
            
            bubbleView.backgroundColor = .systemGray6
            messageBubbleLeading?.isActive = true
            messageBubbleTrailing?.isActive = false
            
            messageTime.textColor = .lightGray
        }
        
    }
    
    
    
    
    func configure(message: Message, isSelecting: Bool) {
        
        isAuth = message.senderId == DataStore.shared.user.id ? true : false
        messageTime.text = getTimeStampTime(date: message.createdAt)
        
        let appName = DataStore.shared.appName
        let diskPath = appName + "/chats/\(message.chatroomId)/audios"
        
        audioPlayerView.audioUrlObject = AudioUrlObject(audioFolderName: diskPath, audioFileName: message.audioMessage!)
    }
    
    
    func configureUI() {
        
        contentView.addSubview(mainView)
        addSubview(mainView)
        mainView.backgroundColor = .clear
        
        mainView.addSubview(bubbleView)
        mainView.addSubview(messageTime)
        mainView.addSubview(audioPlayerView)
        mainView.addSubview(audioPlayerView)
        
//        bubbleView.layer.zPosition = 0
//        messageTime.layer.zPosition = 3
        
        bubbleView.isUserInteractionEnabled = false
        messageTime.isUserInteractionEnabled = false
        
        
        // mainView
        configureMainView()
 
        //MessageTime
        configureMessageTime()
        
        //messageText
        configureAudioPlayer()
        
        
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
        
        configureCheckmark()
    }
    
    func configureCheckmark() {
        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        mainView.addSubview(checkmarkImageView)
        
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
    
    func configureAudioPlayer() {
        audioPlayerView.translatesAutoresizingMaskIntoConstraints = false
        audioPlayerView.showPointer = true
        
        let screenWidth = UIScreen.main.bounds
        let seventy_percent = CGFloat(screenWidth.width * 0.70)
        
        NSLayoutConstraint.activate([
            //messageTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            //messageTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
            audioPlayerView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 13),
            audioPlayerView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -13),
            audioPlayerView.bottomAnchor.constraint(equalTo: messageTime.topAnchor, constant: 5),
            audioPlayerView.topAnchor.constraint(equalTo: topAnchor, constant: 12.5),
            audioPlayerView.widthAnchor.constraint(lessThanOrEqualToConstant: seventy_percent),
            audioPlayerView.widthAnchor.constraint(greaterThanOrEqualToConstant: seventy_percent),
            audioPlayerView.heightAnchor.constraint(equalToConstant: 50),
            //messageTextLabel.widthAnchor.constraint(lessThanOrEqualToConstant: eighty_percent),
            ])
    }
    
    

    
    
    
    
    func configureMessageBubble() {
        
        let screenWidth = UIScreen.main.bounds
        let eighty_percent = CGFloat(screenWidth.width * 0.8)
        NSLayoutConstraint.activate([
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: eighty_percent),
            //bubbleView.widthAnchor.constraint(equalToConstant: 0),
            bubbleView.bottomAnchor.constraint(equalTo: messageTime.bottomAnchor, constant: 10),
            bubbleView.topAnchor.constraint(equalTo: audioPlayerView.topAnchor, constant: -10)
        ])
        
        messageBubbleLeading = bubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        messageBubbleTrailing = bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        
    }
    
    
    
    
    let hiddenView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
        }()

    private func setupHiddenView() {
        contentView.addSubview(hiddenView)
        hiddenView.translatesAutoresizingMaskIntoConstraints = false

        hiddenView.backgroundColor = .red

        NSLayoutConstraint.activate([
            hiddenView.widthAnchor.constraint(equalToConstant: 0),
            hiddenView.heightAnchor.constraint(equalToConstant: 0),
            hiddenView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI();
//        setupHiddenView();
        self.backgroundColor = .clear
//        fatalError("init(coder:) has not been implemented")
        
//        setupHiddenView()
    }
    
    
}
