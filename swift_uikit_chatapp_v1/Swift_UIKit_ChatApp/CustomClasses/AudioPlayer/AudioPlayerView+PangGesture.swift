//
//  AudioPlayerView+PangGesture.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 30.8.2023.
//

import UIKit
import AVFoundation

// MARK: Pan Gesture

extension AudioPlayerView {
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
            guard var cachedAudioElements = cachedAudioElements else {
                return
            }
        
//        print("previousDraggedValue, ")

            switch gestureRecognizer.state {
            case .began :
                print("began")
                isDragging = true
                
//                accumulatedTranslation = .zero
            case .changed:
                // Calculate the progress based on the pan gesture's translation
                let translation = gestureRecognizer.translation(in: self)
//                accumulatedTranslation.x += translation.x
                
                
            
                if  accumulatedTranslation.x <= (waveformView.bounds.size.width - 3) {
                    
                    if accumulatedTranslation.x <= 1 && translation.x < 0 {
//                        print("first")
                        accumulatedTranslation.x = 0
                    } else if accumulatedTranslation.x >= (waveformView.bounds.size.width - 3) && translation.x > 0 {
//                        print("second")
                        accumulatedTranslation.x = (waveformView.bounds.size.width - 3)
                    } else if accumulatedTranslation.x + translation.x <= (waveformView.bounds.size.width - 3) {
//                        print("third")
                        accumulatedTranslation.x += translation.x
                    } else  {
//                        print("forth")
                        accumulatedTranslation.x = (waveformView.bounds.size.width - 3)
                    }
                    
                }
                else if accumulatedTranslation.x >= (waveformView.bounds.size.width - 3) && translation.x < 0 {
                    accumulatedTranslation.x += translation.x
                }

                self.circle.transform = CGAffineTransform(translationX: accumulatedTranslation.x, y: 0)
                
                let totalWidth = waveformView.bounds.width
                let progress = Float(accumulatedTranslation.x / totalWidth)
                
                // Update the highlighted samples based on the progress
                let totalSamples = waveformView.totalSamples
                let newHighlightedSamples = Int(Float(totalSamples) * progress)
                
//                print("newHighlightedSamples: ", newHighlightedSamples)
                if newHighlightedSamples > 0 {
                    waveformView.highlightedSamples = 0 ..< newHighlightedSamples
                }
                

                let newPlaybackTime = cachedAudioElements.audioDuration * Double(progress)
                durationLabel.text = formatAudioDuration(number: Int(newPlaybackTime))
                cachedAudioElements.audioCurrentTime = newPlaybackTime
                cachedAudioElements.progress = progress
                cachedAudioElements.audioCurrentTime = Double(progress) * cachedAudioElements.audioDuration
                self.cachedAudioElements = cachedAudioElements
                
                gestureRecognizer.setTranslation(.zero, in: self)

                
            case .ended:
                // Playback the audio from the new position
//                playButtonTapped()
                AudioPlayerManager.shared.updateCachedAudioElements(updatedObject: cachedAudioElements)
                if  cachedAudioElements.audioCurrentTime == 0 {
                    durationLabel.text = formatAudioDuration(number: Int(cachedAudioElements.audioDuration))
                }
                if cachedAudioElements.audioPlayerNode.isPlaying == true {
                    AudioPlayerManager.shared.playAudio(at: cachedAudioElements.audioUrl)
                }
                
                isDragging = false

                
            
            default:
                break
            }
        }
}
