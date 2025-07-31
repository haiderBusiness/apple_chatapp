//
//  MicView+UIConfiguration.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 21.8.2023.
//

import UIKit

// MARK: UI
extension AudioRecorderView {

    
    
    func configureUI() {
        configureBlubAndTimerView()
        configureCancelUI()
        configureMicUI()
        configureLockAndArrow()
        
        // gesture
        configureMicPanGesture()
    }
    
    func configureBlubAndTimerView() {
        self.addSubview(blubAndTimerView)
        blubAndTimerView.translatesAutoresizingMaskIntoConstraints = false
        blubAndTimerView.backgroundColor = .red
        
        NSLayoutConstraint.activate([
            blubAndTimerView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        blubAndTimerViewLeadingConstraint = blubAndTimerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -100)
        blubAndTimerViewLeadingConstraint?.isActive = true
        
        configureBlubUI()
        configureTimerUI()
    }
    
    
    func configureBlubUI() {
        
        blubAndTimerView.addSubview(blubView)
        
        blubView.translatesAutoresizingMaskIntoConstraints = false
        blubView.backgroundColor = .red
        blubView.layer.cornerRadius = 13
        blubView.clipsToBounds = true
        
        blubAndTimerView.alpha = 0
        
        NSLayoutConstraint.activate([
            blubView.leadingAnchor.constraint(equalTo: blubAndTimerView.leadingAnchor, constant: 20),
            blubView.widthAnchor.constraint(equalToConstant: 20),
            blubView.heightAnchor.constraint(equalToConstant: 20),
            blubView.centerYAnchor.constraint(equalTo: blubAndTimerView.centerYAnchor)
        ])
        
        
    }
    
    
    func configureTimerUI() {
        blubAndTimerView.addSubview(timerLabel)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.textColor = .label
        timerLabel.text = "0.00"
        timerLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        
        NSLayoutConstraint.activate([
            timerLabel.leadingAnchor.constraint(equalTo: blubView.trailingAnchor, constant: 10),
            timerLabel.centerYAnchor.constraint(equalTo: blubAndTimerView.centerYAnchor),
        ])
        
    }
    
    
    func addIconToCancel(addIcon: Bool) {
        if addIcon {
            let iconImage = UIImage(systemName: "chevron.backward")!
                    let coloredIconImage = iconImage.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
                    let iconAttachment = NSTextAttachment()
                    iconAttachment.image = coloredIconImage
                    let attributedString = NSMutableAttributedString(string: "")
                    attributedString.append(NSAttributedString(attachment: iconAttachment))

                    // Add the text to the attributed string
                    attributedString.append(NSAttributedString(string: " " + Language.cancel))
            // Create a UIButton and set its attributed title
            cancelButton.setAttributedTitle(attributedString, for: .normal)
        } else {
            
            let attributedString = NSMutableAttributedString(string: Language.cancel)
            cancelButton.setAttributedTitle(attributedString, for: .normal)
        }
        
    }
    
    func configureCancelUI() {
        
//        let iconImage = UIImage(systemName: "chevron.backward")!
//        let coloredIconImage = iconImage.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
//               let iconAttachment = NSTextAttachment()
//               iconAttachment.image = coloredIconImage
//
//               // Create an attributed string with the icon attachment
//               let attributedString = NSMutableAttributedString(string: "")
//               attributedString.append(NSAttributedString(attachment: iconAttachment))
//
//               // Add the text to the attributed string
//               attributedString.append(NSAttributedString(string: "  " + Language.cancel))
//
//
//
//        cancelLabel.translatesAutoresizingMaskIntoConstraints = false
//        cancelLabel.attributedText = attributedString
//        cancelLabel.textColor = .systemGray
//        cancelLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
//        view.addSubview(cancelLabel)
        
        


    

        addIconToCancel(addIcon: true)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        cancelButton.addTarget(self, action: #selector(onCancelButton), for: .touchUpInside)

        // Customize other properties of the UIButton as needed
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.tintColor = .systemGray

        // Add the button to your view
        self.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
//            cancelButton.leadingAnchor.constraint(equalTo: cancelLabel.leadingAnchor),
//            cancelButton.trailingAnchor.constraint(equalTo: cancelLabel.trailingAnchor),
//            cancelButton.topAnchor.constraint(equalTo: cancelLabel.topAnchor),
//            cancelButton.bottomAnchor.constraint(equalTo: cancelLabel.bottomAnchor),
            cancelButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
//            cancelButton.widthAnchor.constraint(equalToConstant: 20),
//            cancelButton.heightAnchor.constraint(equalToConstant: 20),
            
        ])
        
        cancelButtonCenterXAnchor = cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        cancelButtonCenterXAnchor?.constant = 160
        cancelButtonCenterXAnchor?.isActive = true
        
        
       
        
    }
    
    func configureMicUI() {
        
        // mic button
        self.addSubview(micButton)
        micButton.translatesAutoresizingMaskIntoConstraints = false
        micIconImage.tintColor = .systemGray2
//        micButton.backgroundColor = .systemBlue
        micButton.layer.cornerRadius = 45
        micButton.clipsToBounds = true
        micButton.layer.zPosition = 1
        
//        micButton.addTarget(self, action: #selector(recordVoice), for: .touchUpInside)
        
        micButton.addSubview(micIconImage)
        
        micIconImage.isUserInteractionEnabled = false
        micButton.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            micButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            micIconImage.centerXAnchor.constraint(equalTo: micButton.centerXAnchor),
            micIconImage.centerYAnchor.constraint(equalTo: micButton.centerYAnchor),
            micIconImage.widthAnchor.constraint(equalToConstant: 25),
            micIconImage.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        micButtonTrailingConstraint = micButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3)
        micButtonTrailingConstraint?.isActive = true
        
        micButtonWidthConstraint = micButton.widthAnchor.constraint(equalToConstant: 50)
        micButtonWidthConstraint?.isActive = true
        micButtonHeightConstraint = micButton.heightAnchor.constraint(equalToConstant: 50)
        micButtonHeightConstraint?.isActive = true
    }
    
    
    func configureLockAndArrow() {
        
        // lock and arrow button
        self.addSubview(lockAndArrowButton)
        lockAndArrowButton.translatesAutoresizingMaskIntoConstraints = false
        lockAndArrowButton.layer.zPosition = 0
        
        // lock and arrow background view
        
        lockAndArrowButton.addSubview(lockAndArrowBackgroundView)
        lockAndArrowBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        lockAndArrowBackgroundView.backgroundColor = .systemBackground
        
        lockAndArrowBackgroundView.layer.cornerRadius = 10
        lockAndArrowBackgroundView.clipsToBounds = true
        
        lockAndArrowBackgroundView.layer.zPosition = 0
        lockAndArrowBackgroundView.isUserInteractionEnabled = false
        
        // lock icon
        lockAndArrowButton.addSubview(lockIconImage)
        lockIconImage.translatesAutoresizingMaskIntoConstraints = false
        lockIconImage.isUserInteractionEnabled = false
        
        lockIconImage.layer.zPosition = 0
        
        lockAndArrowButton.addSubview(arrowIconImage)
        arrowIconImage.translatesAutoresizingMaskIntoConstraints = false
        arrowIconImage.layer.zPosition = 0
        arrowIconImage.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            //lockAndArrowButton
            lockAndArrowButton.centerXAnchor.constraint(equalTo: micButton.centerXAnchor),
            
            // lock icon
            lockIconImage.centerXAnchor.constraint(equalTo: lockAndArrowButton.centerXAnchor),
            lockIconImage.widthAnchor.constraint(equalToConstant: 25),
            lockIconImage.heightAnchor.constraint(equalToConstant: 25),
            // arrow icon
            arrowIconImage.centerXAnchor.constraint(equalTo: lockAndArrowButton.centerXAnchor),
            arrowIconImage.widthAnchor.constraint(equalToConstant: 25),
            arrowIconImage.heightAnchor.constraint(equalToConstant: 25),
            
            // lock and arrow button
            lockAndArrowBackgroundView.leadingAnchor.constraint(equalTo: lockIconImage.leadingAnchor, constant: -5),
            lockAndArrowBackgroundView.trailingAnchor.constraint(equalTo: lockIconImage.trailingAnchor, constant: 5),
            lockAndArrowBackgroundView.topAnchor.constraint(equalTo: lockIconImage.topAnchor, constant: -5),
            lockAndArrowBackgroundView.bottomAnchor.constraint(equalTo: arrowIconImage.bottomAnchor, constant: 5)
        ])
        
        arrowIconImageTopConstraint = arrowIconImage.topAnchor.constraint(equalTo: lockIconImage.bottomAnchor, constant: 1)
        arrowIconImageTopConstraint?.isActive = false
        
        lockIconImageBottomConstraint = lockIconImage.bottomAnchor.constraint(equalTo: arrowIconImage.topAnchor,constant:  -6)
        lockIconImageBottomConstraint?.isActive = true
        
        lockAndArrowButtonBottomConstraint = lockAndArrowButton.bottomAnchor.constraint(equalTo: micButton.topAnchor, constant: 80)
        
        lockAndArrowButtonBottomConstraint?.isActive = true

    }
    
    
}
