//
//  PhotoWithText+Download.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 28.7.2023.
//

import UIKit


extension PhotoWithTextMessageCell {
    
    func configureBlurView() {
        
        
        
        messageImage.addSubview(downloadImageVideoView)
        downloadImageVideoView.translatesAutoresizingMaskIntoConstraints = false
        downloadImageVideoView.backgroundColor = .clear
        downloadImageVideoView.customProgressView.strokColor = .white
        downloadImageVideoView.customProgressView.circleProgress = 0.05
        downloadImageVideoView.customProgressView.lineWidth = 2
        
        
        
        NSLayoutConstraint.activate([
            downloadImageVideoView.topAnchor.constraint(equalTo: messageImage.topAnchor),
            downloadImageVideoView.bottomAnchor.constraint(equalTo: messageImage.bottomAnchor),
            downloadImageVideoView.leadingAnchor.constraint(equalTo: messageImage.leadingAnchor),
            downloadImageVideoView.trailingAnchor.constraint(equalTo: messageImage.trailingAnchor),
        ])
        
        configureVideoPlayer()
    }
    
    func hideBlur() {
        UIView.animate(withDuration: 0.0) {
            self.downloadImageVideoView.alpha = 0
            self.layoutIfNeeded()
        }
    }
    
    func setDownloadInfoViewToDefault() {
        downloadImageVideoView.customProgressView.stopCircling()
        downloadImageVideoView.customProgressView.circleProgress = 0.05
        downloadImageVideoView.showHideIndicator(show: false)
    }
    
    
    func loadMedia(isVideo: Bool, videoUrl: String = "", imageUrl: String = "", folderName: String, placeHolderUrl: String, completion: @escaping ((Bool) -> Void)) {
        
        let mediaUrl = isVideo ? videoUrl : imageUrl
        
        urlLoadingProgress.loadImage(from: mediaUrl) { data, progress in
            DispatchQueue.global().async { [weak self] in
                
                // video progress here before the data is completed to get progress as it completes
                DispatchQueue.main.async {
                    if progress != 1.0 {
                        self?.downloadImageVideoView.customProgressView.setProgressValue(toValue: progress, animated: true)
                    }
                }
                
                
                if let data = data {
//                    self?.downloadImageVideoView.customProgressView.setProgressValue(fromValue: 0.0, toValue: 1.0, animated: true)
                    if isVideo {
                        //  save video to disk (saving video file method is the same as saving image method)
                        saveImageToDisk(imageData: data, fileName: videoUrl, folderName: folderName)
                        if progress == 1.0 {
                            completion(true)
                        }
    
                    } else {
                        
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                
                                // Remove placeholder
                                removeImageFromDisk(fileName: placeHolderUrl, folderName: folderName)
                                
                                // Save original image
                                saveImageToDisk(imageData: data, fileName: imageUrl, folderName: folderName)
                                
                                // Set the loaded image to the image view
                                self?.messageImage.image = image
                                
                                if progress == 1.0 {
                                    
                                    // when its video
                                    if self?.downloadImageVideoView.customProgressView.isCircling == false {
                                        print("here")
                                        completion(true)
                                    }
                                    // when its image
                                    else {
                                        self?.downloadImageVideoView.customProgressView.stopCircling()
                                        self?.hideBlur()
                                        self?.downloadImageVideoView.showHideIndicator(show: false)
                                        self?.updateMessage()
                                        completion(true)
                                    }
                                    
                                }
                               



                                // Update the progress view based on the progress
    //                            let timeInterval = 0.0
    //                            self?.progressView.setProgress(duration: timeInterval, to: progress)
    //                            self?.downloadImageVideoView.customProgressView.stopCircling()
    //                            self?.downloadImageVideoView.customProgressView.setProgressValue(fromValue: 0.0, toValue: progress, animated: true)



                                // Call the completion handler if provided
                               
                            }
                        }
                    }
                    
                } else {
                    // Handle the case when data is nil (no internet or invalid URL)
//                    DispatchQueue.main.async {
//                        self?.downloadImageVideoView.showHideIndicator(show: false)
//                        print("Error: Failed to load image data.")
//                    }
                    
                }
            }
        }
    }
    
    
    
    func downloadImage(videoUrl: String? = nil, originalImageUrl: String, placeHolderUrl: String, folderName: String, completion: (() -> Void)? = nil)  {
        // start download progress animation
        
        
        if isThereInternetConnectionSignal() == false {
            setDownloadInfoViewToDefault()
            self.noInternetMessage()
            return
        }
        
        
        if let videoUrl = videoUrl {
            downloadImageVideoView.customProgressView.circleProgress = 0.01
            downloadImageVideoView.customProgressView.progress = 0.01
            loadMedia(isVideo: true, videoUrl: videoUrl, folderName: videoDiskPath, placeHolderUrl: placeHolderUrl) {
                didDownloadVideo in
                if didDownloadVideo {
                    // now download image after video is downloaded
                    self.loadMedia(isVideo: false, imageUrl: originalImageUrl, folderName: self.diskPath, placeHolderUrl: placeHolderUrl) { didDownloadImage in
                        if didDownloadImage {
                            self.showVideoAnimation()
                        }
                    }
                }
            }
        } else {
            downloadImageVideoView.customProgressView.startCircling()
            loadMedia(isVideo: false, imageUrl: originalImageUrl, folderName: diskPath, placeHolderUrl: placeHolderUrl) { didDownloadPhoto in
                if didDownloadPhoto {
                    print(true)
                }
            }
        }
        
        
        
        
//        print("no image url connection error: ", customProgressView.alpha)
        // The download has started.
        
    }
    
    func showVideoAnimation() {

        self.downloadImageVideoView.customProgressView.setProgressValue(toValue: 1.0, animated: true)
        
        self.hideBlur()
        self.downloadImageVideoView.showHideIndicator(show: false)
        self.updateMessage()
        videoPlayView.alpha = 1
        downloadImageVideoView.customProgressView.circleProgress = 0.01
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            self.hideBlur()
//            self.downloadImageVideoView.showHideIndicator(show: false)
//            self.updateMessage()
//        }
        
    }
    
    
    func configureVideoPlayer() {
    //        frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        videoPlayView.translatesAutoresizingMaskIntoConstraints = false
        messageImage.addSubview(videoPlayView)
        
        
        
        let videoViewBackground = UIView()
        videoViewBackground.translatesAutoresizingMaskIntoConstraints = false
        videoViewBackground.backgroundColor = .black
        videoViewBackground.alpha = 0.4
        videoViewBackground.isUserInteractionEnabled = false
        videoViewBackground.layer.cornerRadius = 25
//        progressViewBackground.clipsToBounds = true
        videoPlayView.addSubview(videoViewBackground)
        
        
        let videoPlayerImage = UIImageView()
        videoPlayerImage.image = UIImage(systemName: "play.fill")
        videoPlayerImage.tintColor = .white
        videoPlayerImage.translatesAutoresizingMaskIntoConstraints = false
        
        videoPlayView.addSubview(videoPlayerImage)
        
        NSLayoutConstraint.activate([
            videoPlayView.topAnchor.constraint(equalTo: messageImage.topAnchor),
            videoPlayView.bottomAnchor.constraint(equalTo: messageImage.bottomAnchor),
            videoPlayView.leadingAnchor.constraint(equalTo: messageImage.leadingAnchor),
            videoPlayView.trailingAnchor.constraint(equalTo: messageImage.trailingAnchor),
            
            videoViewBackground.centerYAnchor.constraint(equalTo: messageImage.centerYAnchor),
            videoViewBackground.centerXAnchor.constraint(equalTo: messageImage.centerXAnchor),
            videoViewBackground.widthAnchor.constraint(equalToConstant: 50),
            videoViewBackground.heightAnchor.constraint(equalToConstant: 50),
            
//            progressView.centerXAnchor.constraint(equalTo: downloadContainer.centerXAnchor),
//            progressView.centerYAnchor.constraint(equalTo: downloadContainer.centerYAnchor),
//            progressView.widthAnchor.constraint(equalToConstant: 40),
//            progressView.heightAnchor.constraint(equalToConstant: 40),
            
            videoPlayerImage.centerXAnchor.constraint(equalTo: videoViewBackground.centerXAnchor),
            videoPlayerImage.centerYAnchor.constraint(equalTo: videoViewBackground.centerYAnchor),
            videoPlayerImage.widthAnchor.constraint(equalToConstant: 25),
            videoPlayerImage.heightAnchor.constraint(equalToConstant: 25)
        ])
        
    }
    
}
