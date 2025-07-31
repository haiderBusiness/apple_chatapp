//
//  AudioPlayerView+Logic.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 30.8.2023.
//

import UIKit
import AVFoundation
import FDWaveformView

// MARK: logic

var previousCurrentTime: Double = 0.0

extension AudioPlayerView {
    
    func loadAudio(folderName: String, fileName: String) {
        
        guard let loadedDirectoryURL = getDirectoryURL(folderName: folderName) else {
             print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Faild to get audio directory in (loadAudio > loadedDirectoryURL), failed to get folder url"]))
            return
        }

        let audioFileURL = loadedDirectoryURL.appendingPathComponent(fileName)
    
        
//            if let audioPlayer = AudioPlayerManager.shared.getAudioPlayer(for: audioFileURL)
        if let cachedAudioElements = AudioPlayerManager.shared.getCachedAudioElements(for: audioFileURL)
            {
                
//            AudioPlayerManager.shared.audioPlayerNodeDelegate = self
            self.cachedAudioElements = cachedAudioElements
            self.durationLabel.text = self.formatAudioDuration(number: Int(cachedAudioElements.audioDuration))

                
                waveformView.audioURL = audioFileURL

                    self.audioPlayer = cachedAudioElements.audioPlayerNode
//                    self.audioPlayer?.rate = audioSpeed
//                    self.cachedAudioElements?.audioPlayerNode.rate = 2.0

                if cachedAudioElements.audioPlayerNode.isPlaying {
                        self.playPauseImageView.image = UIImage(systemName: "pause.circle.fill")
//                        self.durationLabel.text = self.formatAudioDuration(number: Int(audioPlayer.currentTime))

                        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(self.audioTimer), userInfo: nil, repeats: true)
                        
                        RunLoop.main.add(self.timer!, forMode: RunLoop.Mode.common)
                    }
                // else if audio has played before or seeked forward
                else if cachedAudioElements.audioCurrentTime > 0 || cachedAudioElements.progress > 0 {
                    self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(self.fetchPreviousAudioApperance), userInfo: nil, repeats: true)
                    
                    RunLoop.main.add(self.timer!, forMode: RunLoop.Mode.common)
                    
                    }
                    else {
//                        self.durationLabel.text = self.formatAudioDuration(number: Int(audioPlayer.duration))
                        self.playPauseImageView.image = UIImage(systemName: "play.circle.fill")
                    }
            }

            // set view width
            let widthSize = durationLabel.intrinsicContentSize.width + 10

            if widthSize > durationLabelViewWidth.constant {
                durationLabelViewWidth.constant = widthSize
                durationLabelWidth.constant = widthSize
            }

           
//            waveformView.progressSamples = 0
    }
    
    
    
    
    
    @objc func playButtonTapped() {
        
        guard let folderName = audioUrlObject?.audioFolderName, let fileName = audioUrlObject?.audioFileName else {
            print("audioUrlObject is nil: ", audioUrlObject ?? "nil")
            return
        }
        
        guard let loadedDirectoryURL = getDirectoryURL(folderName: folderName) else {
             print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Faild to get audio directory in (playButtonTapped > loadedDirectoryURL), failed to get folder url"]))
            return
        }
        
//        print("cachedAudioElements.audioCurrentTime", self.cachedAudioElements?.audioCurrentTime)
        
        let audioFileURL = loadedDirectoryURL.appendingPathComponent(fileName)
        
        if let player = audioPlayer {
            if player.isPlaying {
                // update cached audio elements
                self.cachedAudioElements = AudioPlayerManager.shared.getCachedAudioElements(for: audioFileURL)
                player.pause()
//                AudioPlayerManager.shared.updateCachedAudioElements(for: audioFileURL)
                playPauseImageView.image = UIImage(systemName: "play.circle.fill")
                timer?.invalidate()
            } else {
                    
                self.cachedAudioElements = AudioPlayerManager.shared.getCachedAudioElements(for: audioFileURL)
                AudioPlayerManager.shared.playAudio(at: audioFileURL)

                playPauseImageView.image = UIImage(systemName: "pause.circle.fill")
                
                self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector:#selector(self.audioTimer), userInfo: nil, repeats: true)
                
                RunLoop.main.add(self.timer!, forMode: RunLoop.Mode.common)
//                audioTimer() // Call this to update the appearance
            }
        }
    }
    
    
    
    func updateAudioAppearance() {
        
       
        guard var cachedAudioElements = self.cachedAudioElements else { return }
        guard isDragging == false else { return }
        
        let audioPlayerNode = cachedAudioElements.audioPlayerNode

        var currentTime: Double = cachedAudioElements.audioCurrentTime
        let duration = cachedAudioElements.audioDuration
        
        if let nodeTime = audioPlayerNode.lastRenderTime, let playerTime = audioPlayerNode.playerTime(forNodeTime: nodeTime) {
            let currentTimeInSeconds = Double(playerTime.sampleTime) / Double(playerTime.sampleRate)
            
            let newTime = currentTime + currentTimeInSeconds
            if newTime > duration {
                currentTime = duration - 0.095
            } else {
                currentTime = newTime
            }
 //           print(" cachedAudioElements.audioCurrentTime: ",  cachedAudioElements.audioCurrentTime)
            
        }
        
        
        var progress: Float = 0.0
        
        if currentTime == duration - 0.095 {
            progress = 0.98458904
            timer?.invalidate()
        } else {
            progress = Float(currentTime / duration)
        }
        
        cachedAudioElements.audioCurrentTime = currentTime
        cachedAudioElements.progress = progress
//        print("progress: ", progress)
        AudioPlayerManager.shared.updateCachedAudioElements(updatedObject: cachedAudioElements)

//          self.cachedAudioElements?.audioCurrentTime = currentTime
        
//              print("playing")
      
        // Adjust the default sample rate if necessary
        
        let totalSamples = waveformView.totalSamples
        let playedSamples = Int(Float(totalSamples) * progress)
        if playedSamples <= waveformView.totalSamples {
            waveformView.highlightedSamples = 0 ..< playedSamples
        }
        
        let totalWidth = waveformView.bounds.width

        // Calculate the corresponding translation.x value
        let translationX = CGFloat(progress) * totalWidth
        accumulatedTranslation.x = translationX
        self.circle.transform = CGAffineTransform(translationX: accumulatedTranslation.x, y: 0)

        durationLabel.text = formatAudioDuration(number: Int(currentTime))
        
        let widthSize = durationLabel.intrinsicContentSize.width + 10

        if widthSize > durationLabelViewWidth.constant {
            durationLabelViewWidth.constant = widthSize
            durationLabelWidth.constant = widthSize
        }
        
        if currentTime == duration - 0.095 {
            audioPlayerNode.stop()
            cachedAudioElements.audioCurrentTime = 0.0
            cachedAudioElements.progress = 0.0
            self.cachedAudioElements = cachedAudioElements
            AudioPlayerManager.shared.updateCachedAudioElements(updatedObject: cachedAudioElements)
            resetToDefault()
        }
    }
    
    
    
    
    
    @objc func fetchPreviousAudioApperance() {
        updateAudioAppearance()
        timer?.invalidate()
        playPauseImageView.image = UIImage(systemName: "play.circle.fill")
    }
    

    
   @objc func audioTimer() {
       
       guard let cachedAudioElements = self.cachedAudioElements else { return }
       
       let audioPlayerNode = cachedAudioElements.audioPlayerNode
       
       let currentTime: Double = cachedAudioElements.audioCurrentTime
          
       // if audio is playing, run defaultTask
       if audioPlayerNode.isPlaying {
           updateAudioAppearance()
       }
       // else if audio is not playing and playback time is not 0, run defaultTask and validate timer
       else if currentTime > 0 {
           // updateAudioAppearance()
           timer?.invalidate()
           playPauseImageView.image = UIImage(systemName: "play.circle.fill")
       }
       // else if audio is not playing and playback is not more than 0, validate timer
       else {
           timer?.invalidate()
           playPauseImageView.image = UIImage(systemName: "play.circle.fill")
       }

    }


    func formatAudioDuration(number: Int) -> String {
        let totalSeconds = number

        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60

        if hours > 0 {
            return String(format: "%d:%d:%02d", hours, minutes, seconds)
        }
        else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    @objc func onSpeedButtonPress() {
        
        if cachedAudioElements?.varispeed?.rate == 2.0 {
            cachedAudioElements?.varispeed?.rate = 1.0
//            print("cachedAudioElements.varispeed?.rate: ", cachedAudioElements?.varispeed?.rate ?? "nil")
            AudioPlayerManager.shared.updateCachedAudioElements(updatedObject: cachedAudioElements)
            audioSpeedLabel.text = "1x"
        }
        else if cachedAudioElements?.varispeed?.rate == 1.5 {
            cachedAudioElements?.varispeed?.rate = 2
            AudioPlayerManager.shared.updateCachedAudioElements(updatedObject: cachedAudioElements)
//            print("cachedAudioElements.varispeed?.rate: ", cachedAudioElements?.varispeed?.rate ?? "nil")
            audioSpeedLabel.text = "2x"
        }
        else {
            cachedAudioElements?.varispeed?.rate = 1.5
            AudioPlayerManager.shared.updateCachedAudioElements(updatedObject: cachedAudioElements)
//            print("cachedAudioElements.varispeed?.rate: ", cachedAudioElements?.varispeed?.rate ?? "nil")
            audioSpeedLabel.text = "1.5x"
        }
    }
    
}

    

//extension AudioPlayerView: FDWaveformViewDelegate, AudioPlayerNodeDelegate {

//    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//            if flag {
//                timer?.invalidate()
//                resetToDefault()
//            } else {
//                print("Audio playback finished with an error.")
//                // Handle the case where playback finished with an error
//            }
//        }
    
//    func audioPlayerDidFinishPlaying(audioElements: CachedAudioData, successfully flag: Bool) {
//        if flag {
//            print("audio finished received", audioElements.audioDuration )
//            audioElements.audioPlayerNode.pause()
//            self.timer?.invalidate()
//            resetToDefault()
//        } else {
//            print("Audio playback finished with error.")
//            // Handle the case where playback finished with an error
//        }
//    }
    
//    func audioPlayerDidPause(_ player: AVAudioPlayer) {
//            // This method is called when the audio player is paused.
//            // You can handle any required actions here.
//            print("Audio player paused")
//        }
    
    

//    func waveformDidEndScrubbing(_ waveformView: FDWaveformView) {
//
//        print("total samples: ", waveformView.totalSamples)
//        let scrubbedSamples = waveformView.highlightedSamples
//        print("scrubed samples: ", scrubbedSamples!)
//
////        let scrubbedMidpoint = scrubbedSamples!.lowerBound + (scrubbedSamples!.upperBound - scrubbedSamples!.lowerBound) / 2
////
////        print("duation: ", Float(waveformView.totalSamples / scrubbedMidpoint))
//
//        let totalSamples = waveformView.totalSamples
//        let highlightedSamples = waveformView.highlightedSamples
//        let progress = Float(highlightedSamples!.upperBound) / Float(totalSamples)
//
//
//        let duration = audioPlayer!.duration
//        let scrubbedDuration = duration * Double(progress)
//
//        audioPlayer?.currentTime = scrubbedDuration
//    }
    
    
    
    
    

//}
