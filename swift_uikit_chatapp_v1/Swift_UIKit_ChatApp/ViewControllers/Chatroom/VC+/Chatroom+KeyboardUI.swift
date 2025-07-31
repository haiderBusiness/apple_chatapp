//
//  ChatroomKeyboard.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 24.6.2023.
//

import UIKit


extension ChatroomVC {
    
    
    func configureKeyboard() {
        
        self.view.addSubview(keyboardContainer)
        keyboardContainer.translatesAutoresizingMaskIntoConstraints = false
        let blur = AddBlur(toView: keyboardContainer, blurStyle: .light)
        
//        keyboardContainer.backgroundColor = .red
        keyboardContainer.addSubview(blur)
        
        
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .systemGray6
        backgroundView.alpha = 0.8
        keyboardContainer.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            keyboardContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            //keyboardContainer.bottomAnchor.constraint(equalTo: optionView.topAnchor), <- moved to option view
            keyboardContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            keyboardContainer.heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            
            //backgroundView
            backgroundView.leadingAnchor.constraint(equalTo: keyboardContainer.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: keyboardContainer.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: keyboardContainer.bottomAnchor),
            backgroundView.topAnchor.constraint(equalTo: keyboardContainer.topAnchor),
            
        ])
        
        
        
        // MARK: mivView
        micView.translatesAutoresizingMaskIntoConstraints = false
        keyboardContainer.addSubview(micView)
        
        
        
        
        
        
        
        
        
        
        
        //early add input container to be under some views
        let inputContainer = UIView()
        self.keyboardContainer.addSubview(inputContainer)
        
        
        
        
        
        
        //attachment image
        var grip_icon = UIImage(named: "plus_sequare")
        grip_icon = grip_icon?.withRenderingMode(.alwaysTemplate)
        attachmentImage.image = grip_icon
        attachmentImage.tintColor = AppTheme.primaryColor
        attachmentImage.translatesAutoresizingMaskIntoConstraints = false
        
        attachmentImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(slidUpOptions))
        attachmentImage.addGestureRecognizer(tapGesture)
        
        keyboardContainer.addSubview(attachmentImage)
        
        
        


        
        
        // message input
        messageInput.translatesAutoresizingMaskIntoConstraints = false
        messageInput.text = Language.message
        messageInput.textColor = .lightGray
        messageInput.font = UIFont.systemFont(ofSize: 16)
        self.keyboardContainer.addSubview(messageInput)
        messageInput.delegate = self
        messageInput.backgroundColor = .clear
        messageInput.isScrollEnabled = false
        //messageInput.textContainer.maximumNumberOfLines = 13
       // messageInput.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
        messageInput.selectedTextRange = messageInput.textRange(from: messageInput.beginningOfDocument, to: messageInput.beginningOfDocument)
        //messageInput.centerVertically()
//        messageInput.autocorrectionType = .no
//        messageInput.autocapitalizationType = .none
        //messageInput.textAlignment = .center
//        messageInput.backgroundColor = .systemGray6
        //messageInput.returnKeyType = .default
//        messageInput.font = .systemFont(ofSize: 16)
        //messageInput.textContainerInset = UIEdgeInsets(top: 6, left: 4, bottom: 3, right: 4)
        
        
       
        
        //sticker
        var stickerIcon = UIImage(named: "sticker")
        stickerIcon = stickerIcon?.withRenderingMode(.alwaysTemplate)
        stickerImage.image = stickerIcon
        stickerImage.tintColor = AppTheme.primaryColor
        stickerImage.translatesAutoresizingMaskIntoConstraints = false
        keyboardContainer.addSubview(stickerImage)
        
        
        
        //input container
        inputContainer.layer.cornerRadius = 60 * 0.20
        inputContainer.clipsToBounds = true
        inputContainer.backgroundColor = .white
        inputContainer.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        // mic image
        var micIcon = UIImage(named: "mic")
        micIcon = micIcon?.withRenderingMode(.alwaysTemplate)
        micImage.translatesAutoresizingMaskIntoConstraints = false
        micImage.image = micIcon
        micImage.tintColor = AppTheme.primaryColor
        micImage.alpha = 0
        keyboardContainer.addSubview(micImage)
        
        
        

        
        
        sendImageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        sendImageBackgroundView.backgroundColor = AppTheme.primaryColor
        sendImageBackgroundView.unhighlightedColor = AppTheme.primaryColor
        sendImageBackgroundView.layer.cornerRadius = 25 * 0.45
        
        sendImageBackgroundView.addTarget(self, action: #selector(onSendImageBackgroundView), for: .touchUpInside)
        keyboardContainer.addSubview(sendImageBackgroundView)
        
        sendImageBackgroundView.isUserInteractionEnabled = false
        sendImageBackgroundView.alpha = 0
        sendImageBackgroundView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        
        var send_icon = UIImage(named: "ios_arrow_up")
        send_icon = send_icon?.withRenderingMode(.alwaysTemplate)
        sendImage.translatesAutoresizingMaskIntoConstraints = false
        sendImage.image = send_icon
        sendImage.tintColor = .white
        sendImage.isUserInteractionEnabled = false
        sendImageBackgroundView.addSubview(sendImage)
        
        
        
        // MARK: micView setup
        micView.onLongPressStart = { [weak self] in
            guard let self = self else {return}
            inputContainer.alpha = 0
            self.stickerImage.alpha = 0
            self.attachmentImage.alpha = 0
            self.messageInput.alpha = 0
        }
        
        micView.onLongPressEnd = { [weak self] in
            guard let self = self else {return}
            inputContainer.alpha = 1
            self.stickerImage.alpha = 1
            self.attachmentImage.alpha = 1
            self.messageInput.alpha = 1
        }
        
        micView.AudioRecordingDelegate = self
        
        
        NSLayoutConstraint.activate([
            micView.leadingAnchor.constraint(equalTo: keyboardContainer.leadingAnchor),
            micView.trailingAnchor.constraint(equalTo: keyboardContainer.trailingAnchor),
            micView.topAnchor.constraint(equalTo: keyboardContainer.topAnchor),
            micView.bottomAnchor.constraint(equalTo: keyboardContainer.bottomAnchor, constant: -20),
        ])
        
        
        
        
//        messageInputTopConstraint = messageInput.topAnchor.constraint(equalTo: keyboardContainer.topAnchor, constant: 10)
//        messageInputTopConstraint.isActive = true
        

        NSLayoutConstraint.activate([
            
            
            //attachment image
            attachmentImage.leadingAnchor.constraint(equalTo: keyboardContainer.leadingAnchor, constant: 15),
            attachmentImage.bottomAnchor.constraint(equalTo: messageInput.bottomAnchor, constant: -3),
            attachmentImage.widthAnchor.constraint(equalToConstant: 25),
            attachmentImage.heightAnchor.constraint(equalToConstant: 25),
            
            
            //sticker image
//            stickerImage.bottomAnchor.constraint(equalTo: messageInput.bottomAnchor, constant: -7),
            //stickerImage.centerYAnchor.constraint(equalTo: messageInput.centerYAnchor),
            stickerImage.widthAnchor.constraint(equalToConstant: 18),
            stickerImage.heightAnchor.constraint(equalToConstant: 18),
            stickerImage.bottomAnchor.constraint(equalTo: messageInput.bottomAnchor, constant: -6),

            
            
            //message input
            messageInput.trailingAnchor.constraint(equalTo: stickerImage.leadingAnchor, constant: 0),
            messageInput.leadingAnchor.constraint(equalTo: attachmentImage.trailingAnchor, constant: 15),
            messageInput.topAnchor.constraint(equalTo: keyboardContainer.topAnchor, constant: 8),
            messageInput.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            messageInput.heightAnchor.constraint(lessThanOrEqualToConstant: 265),
            messageInput.bottomAnchor.constraint(equalTo: keyboardContainer.bottomAnchor, constant: -30),
            
            //input container
            inputContainer.leadingAnchor.constraint(equalTo: messageInput.leadingAnchor, constant: -2),
            inputContainer.topAnchor.constraint(equalTo: messageInput.topAnchor, constant: -1),
            inputContainer.bottomAnchor.constraint(equalTo: messageInput.bottomAnchor, constant: 4),
            inputContainer.trailingAnchor.constraint(equalTo: stickerImage.trailingAnchor, constant: 8),
            
            
            micImage.trailingAnchor.constraint(equalTo: keyboardContainer.trailingAnchor, constant: -15),
            micImage.bottomAnchor.constraint(equalTo: messageInput.bottomAnchor, constant: -3),
            micImage.widthAnchor.constraint(equalToConstant: 25),
            micImage.heightAnchor.constraint(equalToConstant: 25),
            stickerImage.trailingAnchor.constraint(equalTo: micImage.leadingAnchor, constant:-20),
            
            
            sendImageBackgroundView.trailingAnchor.constraint(equalTo: keyboardContainer.trailingAnchor, constant: -15),
            sendImageBackgroundView.bottomAnchor.constraint(equalTo: messageInput.bottomAnchor, constant: -3),
            sendImageBackgroundView.widthAnchor.constraint(equalToConstant: 28.5),
            sendImageBackgroundView.heightAnchor.constraint(equalToConstant: 28.5),
            
            sendImage.leadingAnchor.constraint(equalTo: sendImageBackgroundView.leadingAnchor, constant: 0),
            sendImage.topAnchor.constraint(equalTo: sendImageBackgroundView.topAnchor, constant: 0),
            sendImage.bottomAnchor.constraint(equalTo: sendImageBackgroundView.bottomAnchor, constant: 0),
            sendImage.trailingAnchor.constraint(equalTo: sendImageBackgroundView.trailingAnchor, constant: 0),
            //messageInput.trailingAnchor.constraint(equalTo: micImage.leadingAnchor, constant: -15)
        ])
        
    }
    
    
    @objc func showActionSheet() {
         print("pressed")
        actionSheet()
    }
    
    @objc func onSendImageBackgroundView() {
        sendMessage(text: self.messageInput.text)
    }
   
}
