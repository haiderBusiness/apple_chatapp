//
//  MicView+PangGesture.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 22.8.2023.
//

import UIKit



extension AudioRecorderView: UIGestureRecognizerDelegate {
    
    func configureMicPanGesture() {
        cancelButton.alpha = 0
        lockAndArrowButton.alpha = 0
        
        let dragingPan = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture))
        dragingPan.delegate = self
        micButton.addGestureRecognizer(dragingPan)
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 0.3 // Set the minimum duration of the long press
        
        micButton.addGestureRecognizer(longPressGesture)
        
        micButton.addTarget(self, action: #selector(onMicPress), for: .touchUpInside)
        
    }
    
    
    
    @objc func onMicPress() {
        if isRecordingLocked {
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: { [weak self] in
                guard let self = self else {return}
                
                self.onLongPressEnd()
                
                if let audioFullPathURL = self.audioFullPathURL, let fileName = self.audioFileName {
                    self.AudioRecordingDelegate?.onAudioRecordingEnded(audioFullPathURL: audioFullPathURL, fileName: fileName)
                }
                self.restProperties()
                self.layoutIfNeeded()
            }, completion: { [weak self] hasCompleted in
                guard let self = self else {return}
                if hasCompleted {
                    self.lockIconImage.image = UIImage(systemName: "lock.open.fill")
                }
            })
        } else {
            self.AudioRecordingDelegate?.onAudioRecordingEnded(audioFullPathURL: nil, fileName: nil)
        }
       
    }

    
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
                                                 
        if gesture.state == .began && !isRecordingLocked {
            
//            handlePanGesture(gesture: gesture)
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: { [weak self] in
                guard let self = self else {return}
                
                self.onLongPressStart()
//                self.backgroundColor = .systemGray6
                self.micIconImage.image = UIImage(systemName: "mic.fill")
                self.micIconImage.tintColor = .white
                self.micButton.backgroundColor = AppTheme.primaryColor
                
                self.micButtonWidthConstraint?.constant = 100
                self.micButtonHeightConstraint?.constant = 100
                self.micButtonTrailingConstraint?.constant = 7
                self.recordVoice()
                
                
//                self.micButton.layer.cornerRadius = 25
//                self.micButton.clipsToBounds = true
            })
            
        }
        
        else if gesture.state == .changed && !isRecordingLocked {
            
            if cancelRecording {
                gesture.state = .ended
            } else {
                shouldAllowDraggingPan = true
            }
            
        }
        
        else if gesture.state == .ended && !isRecordingLocked {
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: { [weak self] in
                guard let self = self else {return}
                
                self.onLongPressEnd()
                
                self.restProperties()
                self.layoutIfNeeded()
            }, completion: { [weak self] hasCompleted in
                guard let self = self else {return}
                if hasCompleted {
                    self.lockIconImage.image = UIImage(systemName: "lock.open.fill")
                }
            })
        }
        
        
        
    }
    
    
    
    func restProperties() {
        self.micIconImage.image = UIImage(systemName: "mic")
        self.micIconImage.tintColor = .systemGray2
        self.micButton.backgroundColor = .clear
        self.micButtonWidthConstraint?.constant = 50
        self.micButtonHeightConstraint?.constant = 50
        self.micButtonTrailingConstraint?.constant = -3
        self.recordVoice()
        self.shouldAllowDraggingPan = false
        self.micButton.transform = CGAffineTransform(translationX: 0, y: 0)
        self.cancelButton.alpha = 0
        self.blubAndTimerView.alpha = 0
        self.cancelButton.transform = .identity // reset
        self.cancelRecording = false
        self.arrowIconImage.transform = .identity // reset
        self.stopArrowAndLockLoop = false
        self.lockAndArrowBackgroundView.transform = .identity // CGAffineTransform(translationX: 0, y: 0) -> reset
        
        self.addIconToCancel(addIcon: true)
        self.lockIconImage.image = UIImage(systemName: "lock.open.fill")
        self.isRecordingLocked = false
        self.backgroundColor = .clear
        self.stopCancelLoop = false
        
        
        //                self.micButton.layer.cornerRadius = 25
        //                self.micButton.clipsToBounds = true
    }
    
    
    
    @objc func onCancelButton() {
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: { [weak self] in
            guard let self = self else {return}
            
            self.cancelRecording = true
            self.onLongPressEnd()
            self.deleteAudio()
            self.restProperties()
            self.layoutIfNeeded()
        }, completion: { [weak self] hasCompleted in
            guard let self = self else {return}
            if hasCompleted {
                self.lockIconImage.image = UIImage(systemName: "lock.open.fill")
            }
        })

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        
        var cancelRepeat = false
        var arrowAndLookRepeat = false
        
        
        if gesture.state == .changed && !isRecordingLocked {
            
            
            let translation = gesture.translation(in: self)
            micButton.transform = CGAffineTransform(translationX: translation.x / 1.8, y: translation.y / 1.8)
            
            //M MARK: translation.y
            if translation.y <= -30 {
                self.stopArrowAndLockLoop = true
                
                if !arrowAndLookRepeat {
//                    UIView.animate(withDuration: 0.52) {
//                        self.lockIconImageBottomConstraint?.constant = -10
//                        self.layoutIfNeeded()
                        arrowAndLookRepeat = true
//                    }
                }
                
                let maxTranslation: CGFloat = 200 // Adjust this value as needed
                let scaleFactor: CGFloat = 1.0 - (abs(translation.y) / maxTranslation)
                
                
                self.arrowIconImage.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor).translatedBy(x: 0, y: (translation.y + 30) / 1.8)
                
                
                
                let maxTranslation2: CGFloat = 300 // Adjust this value as needed
                let scaleFactor2: CGFloat = 1.0 - (abs(translation.y) / maxTranslation2)
                
                let verticalTranslation = translation.y * scaleFactor2
                
                
                self.lockAndArrowBackgroundView.transform = CGAffineTransform(scaleX: 1, y: scaleFactor2).translatedBy(x: 0, y: (verticalTranslation + 20) / 3)
                
                
                
                
                if translation.y <= -100 {
//                    self.arrowIconImage.transform = CGAffineTransform(scaleX: 0, y: scaleFactor).translatedBy(x: 0, y: translation.y / 4.5)

                    if !isRecordingLocked {
//                        print("openLock: ", isRecordingLocked)
                        let expandTransform:CGAffineTransform = CGAffineTransform(scaleX: 1.5, y: 1.5);
                        
                        UIView.transition(with: self.lockIconImage, duration:0.2,options: .curveEaseOut,animations: { [weak self] in
                              guard let self = self else {return}
                                self.lockIconImage.image = UIImage(systemName: "lock.fill")
                                self.micIconImage.image = UIImage(systemName: "paperplane.fill")
                                self.lockIconImage.transform = expandTransform
                                self.isRecordingLocked = true
                                self.shouldAllowDraggingPan = false
                                gesture.state = .ended
                                self.micButton.transform = .identity
                                self.cancelButton.alpha = 1
                                self.addIconToCancel(addIcon: false)
                                self.layoutIfNeeded()
                            }, completion: { [weak self] hasCompleted in
                                guard let self = self else {return}
                                if hasCompleted {
                                    UIView.animate(withDuration: 0.4, delay:0.0, usingSpringWithDamping:0.7,
                                    initialSpringVelocity:1, options: [], animations: {
                                        self.lockIconImage.transform = .identity
                                        self.stopCancelLoop = true
                                        self.cancelButtonCenterXAnchor?.constant = 0
                                        self.cancelButton.transform = .identity
                                       
                                    }, completion:nil)
                                }
                        })
                    }
                } else {
                    
                    if isRecordingLocked {
                        
                        let expandTransform:CGAffineTransform = CGAffineTransform(scaleX: 1.5, y: 1.5);
                        
                        UIView.transition(with: self.lockIconImage, duration:0.2,options: .curveEaseOut,animations: { [weak self] in
                            guard let self = self else {return}
                              self.lockIconImage.image = UIImage(systemName: "lock.open.fill")
                              self.lockIconImage.transform = expandTransform
                              self.isRecordingLocked = false
                              self.addIconToCancel(addIcon: true)
                            }, completion: { [weak self] hasCompleted in
                                guard let self = self else {return}
                                if hasCompleted {
                                    UIView.animate(withDuration: 0.4, delay:0.0, usingSpringWithDamping:0.7,
                                    initialSpringVelocity:1, options: [], animations: {
                                        self.lockIconImage.transform = .identity
                                       
                                    }, completion:nil)
                                }
                        })
                    }
                }
                
                
                
            }
            
            else if translation.y >= -30 && self.stopArrowAndLockLoop == true { // set cancelLabel loop animation to start
                self.stopArrowAndLockLoop = false
                
                // reset transform x it to 0
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: { [weak self] in
                    guard let self = self else {return}
                    self.arrowIconImage.transform = .identity // reset
                    self.lockAndArrowBackgroundView.transform = .identity // reset
                    self.moveArrowUpAndLockDown()
                    arrowAndLookRepeat = false
                })
               
            }
            
            // MARK: translation.x
            if translation.x <= -30 { // stop the cancelLabel animation looping
//                print("here")
                self.stopCancelLoop = true
                if !cancelRepeat {
                    UIView.animate(withDuration: 0.52) { [weak self] in
                        guard let self = self else {return}
                        self.cancelButtonCenterXAnchor?.constant = 0
                        self.layoutIfNeeded()
                        cancelRepeat = true
                    }
                }
               
                self.cancelButton.transform = CGAffineTransform(translationX: translation.x / 1.8, y: 0)
                
                if translation.x <= -80 && cancelButton.alpha > 0 { // hide the cancelLabel
                    
                    let maxTranslation: CGFloat = 200 // Adjust this value as needed
                    let translationRatio = min(1.0, abs(translation.x) / maxTranslation)
                    
                    let alphaValue = 1.0 - translationRatio
                    
                    cancelButton.alpha = alphaValue
                } else if translation.x >= -75 && translation.x != -30 && cancelButton.alpha < 1 { // show the cancelLabel
                    let maxTranslation: CGFloat = 200 // Adjust this value as needed
                    let translationRatio = min(1.0, abs(translation.x) / maxTranslation)
                    
                    let alphaValue = 1.0 - translationRatio
                    
                    cancelButton.alpha = alphaValue
                }
                
                if translation.x <= -110 { // MARK: end gesture and cancel recording
                    gesture.state = .ended
                    self.cancelRecording = true
                }
                
            } else if translation.x >= -30 && self.stopCancelLoop == true { // set cancelLabel loop animation to start
                self.stopCancelLoop = false
                
                // rest transform x it to 0
                UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: { [weak self] in
                    guard let self = self else {return}
                    self.cancelButton.transform = .identity
                    self.moveCancelViewToLeft()
                    cancelRepeat = false
                })
               
            }
            
        }
 
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func gestureRecognizer(_: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        // println("shouldRecognizeSimultaneouslyWithGestureRecognizer");
        return true
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
         // We only allow the (drag) gesture to continue if it is within a long press
         if((gestureRecognizer is UIPanGestureRecognizer) && (shouldAllowDraggingPan == false)) {
             return false;
         }
         return true;
    }
    

}
