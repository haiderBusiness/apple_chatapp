//
//  MicView+Animations.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 21.8.2023.
//

import UIKit

// MARK: UI animations
extension AudioRecorderView {
    
    // start cancel label animation
    func startAnimations() {
        
        pauseBlubAnimation = false
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {
            
            // alpha
            self.lockAndArrowButton.alpha = 1
            self.cancelButton.alpha = 1
            self.blubAndTimerView.alpha = 1
            
            // cancel and button to center
            self.cancelButtonCenterXAnchor?.constant = 0
            
            // slide blubAndTimerView
            self.blubAndTimerViewLeadingConstraint?.constant = 0
            
            // slide arrowIconImage to top
            self.lockAndArrowButtonBottomConstraint?.constant = -80
            
            self.layoutIfNeeded()
            
        }, completion: {
            completed in
            if completed && !self.pauseBlubAnimation {
                
                // start cancel and left arrow icon animation
                self.moveCancelViewToLeft()
                
                // start up arrow and lock animation
                self.moveArrowUpAndLockDown()
                
                // start blub animation
                self.hideBlub()
            }
            
        })
    }

    
    func showBlub() {
        UIView.animate(withDuration: 0.52, delay: 0, options: [], animations: {
            self.blubView.alpha = 1
        }, completion: { completed in
            if completed && !self.pauseBlubAnimation {
                    self.hideBlub()
                }
            }
        )
    }
    
    

    
    
    // center cancel view to its place
    func centerCancelBack() {
        
        UIView.animate(withDuration: 0.52, delay: 0, options: [], animations: {
            self.cancelButtonCenterXAnchor?.constant = 0
            self.layoutIfNeeded()
        }, completion: {
            completed in
            if completed && !self.pauseBlubAnimation && !self.stopCancelLoop {
                self.moveCancelViewToLeft()
            }
            
        })
    }
    
    
    // move cancel view to left
    func moveCancelViewToLeft() {
        
        
        UIView.animate(withDuration: 0.52, delay: 0, options: [], animations: {
            self.cancelButtonCenterXAnchor?.constant = -15
            self.layoutIfNeeded()
        }, completion: {
            completed in
            if completed && !self.pauseBlubAnimation && !self.stopCancelLoop {
                self.centerCancelBack()
            }
            
        })
    }
    

    func moveArrowDownAndLockUp() {
        
        UIView.animate(withDuration: 0.52, delay: 0, options: [], animations: {
//            self.arrowIconImageTopConstraint?.constant = -14
            self.lockIconImageBottomConstraint?.constant = 2
            self.layoutIfNeeded()
        }, completion: {
            completed in
            if completed && !self.pauseBlubAnimation && !self.stopArrowAndLockLoop {
                self.moveArrowUpAndLockDown()
            }
            
        })
    }
    
    
    
    func moveArrowUpAndLockDown() {
        
        UIView.animate(withDuration: 0.52, delay: 0, options: [], animations: {
//            self.arrowIconImageTopConstraint?.constant = 0
            self.lockIconImageBottomConstraint?.constant = -3
            self.layoutIfNeeded()
        }, completion: {
            completed in
            if completed && !self.pauseBlubAnimation && !self.stopArrowAndLockLoop {
                self.moveArrowDownAndLockUp()
            }
            
        })
    }
    
    
    
    
    
    
    
    // start cancel label animation
    func stopAnimations() {
        
        pauseBlubAnimation = true
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [], animations: {

            // slide arrowIconImage to top
            self.lockAndArrowButtonBottomConstraint?.constant = 80
            
            // slide blubAndTimerView
            self.blubAndTimerViewLeadingConstraint?.constant = -100
            
            // cancel and button to center
            self.cancelButtonCenterXAnchor?.constant = 160
            
            // alpha
            self.lockAndArrowButton.alpha = 0
            self.cancelButton.alpha = 0
            
            
            // stop loops
//            self.blubView.alpha = 1
//            self.cancelButtonCenterXAnchor?.constant = 0
//            self.lockIconImageBottomConstraint?.constant = -6
            
            self.layoutIfNeeded()
        })
    }
    
    
    
    
    
    
}
