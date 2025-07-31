//
//  AudioPlayerView+Reset.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 4.9.2023.
//

import UIKit

extension AudioPlayerView {
    
    func resetToDefault() {
        timer?.invalidate()
        self.circle.transform = .identity
        waveformView.highlightedSamples = 0 ..< 0
        accumulatedTranslation = .zero
        
        if let duration = cachedAudioElements?.audioDuration {
            durationLabel.text = formatAudioDuration(number: Int(duration))
        } else {
            durationLabel.text = "00:00"
        }
        
        playPauseImageView.image = UIImage(systemName: "play.circle.fill")
        
    }
}
