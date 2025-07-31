//
//  DownloadImageVideoButton.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 22.7.2023.
//

import UIKit

class DownloadImageVideoView: UIView {
    
    
    let imageDownloadMainView = UIView()
    
    let customProgressView = CustomProgressView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
//    let progressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 40, height: 40), lineWidth: 3, rounded: false)
    let progressViewBackground = UIView()
    
    let downloadContainer = UIView()
    let downloadBackground = UIView()
    
    let photoSizeInBytesLabel = UILabel()
    
    var mainWidthConstraint: NSLayoutConstraint?
    

    override init(frame: CGRect) {
        self.progressViewBackground.alpha = 0
        self.customProgressView.alpha = 0
        self.progressViewBackground.alpha = 0
        self.downloadContainer.alpha = 1
        mainWidthConstraint?.constant = 0
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        self.progressViewBackground.alpha = 0
        self.customProgressView.alpha = 0
        self.progressViewBackground.alpha = 0
        self.downloadContainer.alpha = 1
        mainWidthConstraint?.constant = 0
        super.init(coder: coder)
    }
    
    func configureUI() {
//        addSubview(imageDownloadMainView)
//        translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = .clear
        
        self.backgroundColor = .red
        
        let blurView = UIView()
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = 12
        blurView.clipsToBounds = true
        
        
        
        let blur = AddBlur(toView: blurView, blurStyle: .dark)

        blurView.alpha = 0.6
        blurView.addSubview(blur)
        blurView.isUserInteractionEnabled = false
        
        addSubview(blurView)
        
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            //messageImage.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -2),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),

//            topAnchor.constraint(equalTo: self.topAnchor),
//            //messageImage.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -2),
//            bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        
        
        configureDownloadButton()
        
        
    }
    
    
    func configureDownloadButton() {

        downloadContainer.translatesAutoresizingMaskIntoConstraints = false
        downloadContainer.backgroundColor = .clear
        downloadContainer.isUserInteractionEnabled = false
        downloadContainer.layer.cornerRadius = 14
        downloadContainer.clipsToBounds = true
        addSubview(downloadContainer)
        
        
        downloadBackground.backgroundColor = .black
        downloadBackground.alpha = 0.4
        downloadBackground.isUserInteractionEnabled = false
        downloadBackground.translatesAutoresizingMaskIntoConstraints = false
        downloadContainer.layer.cornerRadius = 14
        downloadContainer.clipsToBounds = true
        downloadContainer.addSubview(downloadBackground)
        
        

        photoSizeInBytesLabel.translatesAutoresizingMaskIntoConstraints = false
        photoSizeInBytesLabel.numberOfLines = 1
        photoSizeInBytesLabel.font = UIFont.systemFont(ofSize: 15)
        photoSizeInBytesLabel.textColor = .white
        downloadContainer.addSubview(photoSizeInBytesLabel)
        
        let iconImage = UIImageView()
        iconImage.image = UIImage(systemName: "arrow.down.circle.fill")
//        iconImage.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30 ,weight: .light)
        iconImage.tintColor = .white
        downloadContainer.addSubview(iconImage)
        
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            downloadContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            downloadContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
//            downloadContainer.trailingAnchor.constraint(equalTo: photoSizeInBytesLabel.trailingAnchor, constant: 5),
//            downloadContainer.leadingAnchor.constraint(equalTo: iconImage.leadingAnchor, constant: -5),
            downloadContainer.heightAnchor.constraint(equalToConstant: 50),
            downloadBackground.topAnchor.constraint(equalTo: downloadContainer.topAnchor),
            downloadBackground.bottomAnchor.constraint(equalTo: downloadContainer.bottomAnchor),
            downloadBackground.leadingAnchor.constraint(equalTo: downloadContainer.leadingAnchor),
            downloadBackground.trailingAnchor.constraint(equalTo: downloadContainer.trailingAnchor),
            
            photoSizeInBytesLabel.centerYAnchor.constraint(equalTo: downloadContainer.centerYAnchor),
            photoSizeInBytesLabel.trailingAnchor.constraint(equalTo: downloadContainer.trailingAnchor, constant: -15),
            photoSizeInBytesLabel.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor, constant: 10),
            
            iconImage.centerYAnchor.constraint(equalTo: downloadContainer.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: downloadContainer.leadingAnchor, constant: 15),
            iconImage.widthAnchor.constraint(equalToConstant: 30),
            iconImage.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        mainWidthConstraint = downloadContainer.widthAnchor.constraint(equalToConstant: 120)
        mainWidthConstraint?.isActive = true
        
        configureLoadingIndicator()
    }

    func configureLoadingIndicator() {
        
 
        progressViewBackground.translatesAutoresizingMaskIntoConstraints = false
        progressViewBackground.backgroundColor = .black
        progressViewBackground.alpha = 0.4
        progressViewBackground.isUserInteractionEnabled = false
        progressViewBackground.layer.cornerRadius = 25
//        progressViewBackground.clipsToBounds = true
        addSubview(progressViewBackground)
        
        
        
        progressViewBackground.alpha = 0
        
        customProgressView.alpha = 0
        customProgressView.strokColor = .white
        customProgressView.progress = 0.1
        customProgressView.lineWidth = 2
        customProgressView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(customProgressView)
        
        
        NSLayoutConstraint.activate([
            progressViewBackground.topAnchor.constraint(equalTo: downloadContainer.topAnchor),
            progressViewBackground.bottomAnchor.constraint(equalTo: downloadContainer.bottomAnchor),
            progressViewBackground.leadingAnchor.constraint(equalTo: downloadContainer.leadingAnchor),
            progressViewBackground.trailingAnchor.constraint(equalTo: downloadContainer.trailingAnchor),
            
//            progressView.centerXAnchor.constraint(equalTo: downloadContainer.centerXAnchor),
//            progressView.centerYAnchor.constraint(equalTo: downloadContainer.centerYAnchor),
//            progressView.widthAnchor.constraint(equalToConstant: 40),
//            progressView.heightAnchor.constraint(equalToConstant: 40),
            
            customProgressView.centerXAnchor.constraint(equalTo: downloadContainer.centerXAnchor),
            customProgressView.centerYAnchor.constraint(equalTo: downloadContainer.centerYAnchor),
            customProgressView.widthAnchor.constraint(equalToConstant: 40),
            customProgressView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
//        customProgressView.startCircling()
//        customProgressView.startCircling()
//        customProgressView.stopCircling()
//        customProgressView.setProgressValue(toValue: 0.2, animated: true)
//        customProgressView.startCircling()
        
//        progressView.startCircling()
    }
    
    
    

    
    
    func showHideIndicator(show: Bool) {
        
        if show {

            self.mainWidthConstraint?.constant = 50
            UIView.animate(withDuration: 0.3) {
                self.customProgressView.alpha = 1
                self.progressViewBackground.alpha = 0.4
                self.downloadContainer.alpha = 0
                self.layoutIfNeeded()
            }
        } else {
            
            self.mainWidthConstraint?.constant = 120
//            UIView.animate(withDuration: 0.2) {
//                self.layoutIfNeeded()
//            }
            
            UIView.animate(withDuration: 0.3) {
                // Move the view to the left and right (adjust the value to control the vibration range)
//                self.center.x -= 20
                self.customProgressView.alpha = 0
                self.progressViewBackground.alpha = 0
                self.downloadContainer.alpha = 1
                self.layoutIfNeeded()
            }
        }
        
    }
}
