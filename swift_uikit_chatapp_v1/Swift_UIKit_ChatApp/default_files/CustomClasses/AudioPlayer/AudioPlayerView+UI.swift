//
//  AudioPlayerView+UI.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 30.8.2023.
//

import UIKit

// MARK: UI


extension AudioPlayerView {
    
    func configureCircle() {
        
        circle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circle)
        circle.backgroundColor = pointerColor
        circle.layer.cornerRadius = 7.5
        circle.clipsToBounds = true
        circle.layer.zPosition = 2
        
        circle.alpha = showPointer ? 1 : 0
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        circle.addGestureRecognizer(panGestureRecognizer)
        
        let constraints = [
            circle.centerYAnchor.constraint(equalTo: centerYAnchor),
            circle.leadingAnchor.constraint(equalTo: playPauseButton.trailingAnchor, constant: 15),
            circle.widthAnchor.constraint(equalToConstant: 15),
            circle.heightAnchor.constraint(equalToConstant: 15) // Set your desired height
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    
    func setupPlayPauseButton() {
        
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playPauseButton)
        
        playPauseButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        playPauseButton.backgroundColor = .clear
        
        playPauseButton.isUserInteractionEnabled = true
        
        playPauseImageView.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.addSubview(playPauseImageView)
        
        playPauseImageView.isUserInteractionEnabled = false
        playPauseImageView.tintColor = playButtonColor
        
       
        
        NSLayoutConstraint.activate([
            playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playPauseButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            playPauseImageView.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor),
            playPauseImageView.centerXAnchor.constraint(equalTo: playPauseButton.centerXAnchor),
            playPauseImageView.widthAnchor.constraint(equalToConstant: 35),
            playPauseImageView.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    
    func setupWaves() {
        
        waveformView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(waveformView)
        
        waveformView.wavesColor = wavesColor
        waveformView.backgroundColor = .clear
//        waveformView.delegate = self
        
        waveformView.doesAllowScrubbing = false // Enable scrubbing interaction
        waveformView.doesAllowStretch = false  // Enable stretching interaction
        waveformView.doesAllowScroll = false
        
        waveformView.progressColor = wavesProgressColor
        
        waveformView.layer.zPosition = 1
        
//        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
//        waveformView.addGestureRecognizer(panGestureRecognizer)
        
        let constraints = [
            waveformView.centerYAnchor.constraint(equalTo: centerYAnchor),
            waveformView.leadingAnchor.constraint(equalTo: playPauseButton.trailingAnchor, constant: 15),
            waveformView.trailingAnchor.constraint(equalTo: audioSpeedButton.leadingAnchor, constant: -20),
            waveformView.heightAnchor.constraint(equalToConstant: 50) // Set your desired height
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func setupCircleLineView() {
        circleLineView.translatesAutoresizingMaskIntoConstraints = false
        circleLineView.backgroundColor = .clear
        circleLineView.fillColor = wavesColor
        
        circleLineView.layer.zPosition = 0
        
        addSubview(circleLineView)
        
        let constraints = [
            circleLineView.centerYAnchor.constraint(equalTo: waveformView.centerYAnchor),
            circleLineView.leadingAnchor.constraint(equalTo: waveformView.leadingAnchor),
            circleLineView.trailingAnchor.constraint(equalTo: waveformView.trailingAnchor),
            circleLineView.heightAnchor.constraint(equalToConstant: 40) // Set your desired height
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    func setupDurationLabel() {
        
        durationView.translatesAutoresizingMaskIntoConstraints = false
        durationView.backgroundColor = .red
        durationView.addSubview(durationLabel)
        
        durationView.layer.zPosition = 3
        
        durationLabel.textColor = durationLabelColor
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.layer.zPosition = 3
        
        
//        durationLabel.textAlignment = .right
//        durationLabel.backgroundColor = .red
     

        NSLayoutConstraint.activate([
            durationView.topAnchor.constraint(equalTo: waveformView.bottomAnchor),
            durationView.leadingAnchor.constraint(equalTo: waveformView.leadingAnchor),
//            durationView.heightAnchor.constraint(equalTo: waveformView.20),
//            durationView.widthAnchor.constraint(equalToConstant: 50),
            
            durationLabel.topAnchor.constraint(equalTo: waveformView.bottomAnchor, constant: -5),
            durationLabel.leadingAnchor.constraint(equalTo: waveformView.leadingAnchor),
            
        ])
        
        let widthSize = durationLabel.intrinsicContentSize.width + 10
        durationLabelWidth = durationLabel.widthAnchor.constraint(equalToConstant: widthSize)
        durationLabelWidth.isActive = true
        
        durationLabelViewWidth = durationView.widthAnchor.constraint(equalToConstant: widthSize)
        durationLabelViewWidth.isActive = true
        
        
    }
    
    
    func configureAudioSpeedButton() {

        audioSpeedButton.translatesAutoresizingMaskIntoConstraints = false
        audioSpeedButton.backgroundColor = audioSpeedButtonColor
        audioSpeedButton.layer.zPosition = 3
        
        audioSpeedButton.addTarget(self, action: #selector(onSpeedButtonPress), for: .touchUpInside)
        
        audioSpeedButton.layer.cornerRadius = 12
        audioSpeedButton.clipsToBounds = true
        
        audioSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        audioSpeedLabel.textColor = audioSpeedTextColor
        audioSpeedLabel.textAlignment = .center
        audioSpeedLabel.text = "1x"
        
        audioSpeedLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        audioSpeedLabel.layer.zPosition = 3
        
        addSubview(audioSpeedLabel)
        
        NSLayoutConstraint.activate([
//            audioSpeedButton.centerYAnchor.constraint(equalTo: waveformView.centerYAnchor),
//            audioSpeedButton.bottomAnchor.constraint(equalTo: bottomAnchor),
//            audioSpeedButton.trailingAnchor.constraint(equalTo: waveformView.leadingAnchor, constant:0),
            
            audioSpeedLabel.centerYAnchor.constraint(equalTo: waveformView.centerYAnchor, constant: -2),
            audioSpeedLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
//            audioSpeedLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
//            audioSpeedLabel.heightAnchor.constraint(equalToConstant: 20),
            
//            audioSpeedLabel.centerYAnchor.constraint(equalTo: audioSpeedLabelView.centerYAnchor),
//            audioSpeedLabel.centerXAnchor.constraint(equalTo: audioSpeedLabelView.centerXAnchor)
            
            audioSpeedButton.leadingAnchor.constraint(equalTo: audioSpeedLabel.leadingAnchor, constant: 0),
            audioSpeedButton.trailingAnchor.constraint(equalTo: audioSpeedLabel.trailingAnchor, constant:0),
            audioSpeedButton.topAnchor.constraint(equalTo: audioSpeedLabel.topAnchor, constant: 0),
            audioSpeedButton.bottomAnchor.constraint(equalTo: audioSpeedLabel.bottomAnchor, constant: 0)
        ])
        
        audioSpeedLabelWidthConstraint = audioSpeedLabel.widthAnchor.constraint(equalToConstant: 40)
        audioSpeedLabelWidthConstraint?.isActive = true
    }
    
    
}
