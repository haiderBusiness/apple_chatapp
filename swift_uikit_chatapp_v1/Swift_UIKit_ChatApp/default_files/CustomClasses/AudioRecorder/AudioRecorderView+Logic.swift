//
//  AudioMessageLogic.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 21.8.2023.
//

import UIKit
import AVFoundation

// MARK: logic
extension AudioRecorderView {
    
    

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        counter += 0.01
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let formattedCounter = formatter.string(from: counter as NSDecimalNumber)
        
        timerLabel.text = "\(formattedCounter!)"
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil // Set to nil to release the timer reference
    }

    func resetTimer() {
        stopTimer()
        counter = 0
        timerLabel.text = "0.00"
    }
    
    
    
    
    
    func hideBlub() {
        
        UIView.animate(withDuration: 0.52, delay: 0, options: [], animations: {
            self.blubView.alpha = 0
        }, completion: { completed in
            if completed && !self.pauseBlubAnimation {
                    self.showBlub()
                }
            }
        )
        
    }
    
    
    @objc func playVoice() {
        print("test1")
    }
    
    
    
    @objc func recordVoice() {
        
        if audioRecorder == nil {
            
            audioFileName = "audio_with_id_\(UUID()).m4a"
            
            let fileName = createAudioPathUrl(folderName: audioFolderName, fileName: audioFileName!)
            
            audioFullPathURL = fileName
            
            let settigns = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
            
            // start audio recording
            do {
                if let fileName = fileName {
                    audioRecorder = try AVAudioRecorder(url: fileName, settings: settigns)
                    audioRecorder.delegate = self
                    audioRecorder.record()
//                    startBlubLoopingAnimation()
                    startAnimations()
                    startTimer()
//                    startCancelAnimation()
//                    showAndStartLockAndArrowAnimation()
                    
                   print("starting recording...")
                }
            }
            catch { print("Error in recording: ", error) }
        } else {
            

            // stop audio recording
            audioRecorder.stop()
            audioRecorder = nil
            
            if self.counter < 0.01 || self.cancelRecording {
                self.deleteAudio()
                self.AudioRecordingDelegate?.onAudioRecordingEnded(audioFullPathURL: nil, fileName: nil)
            } else {
                if let audioFullPathURL = self.audioFullPathURL, let fileName = self.audioFileName {
                    self.AudioRecordingDelegate?.onAudioRecordingEnded(audioFullPathURL: audioFullPathURL, fileName: fileName)
                }
            }
            
            stopAnimations()
            stopTimer()
            resetTimer()

        }
    }
    
    
    
    
    
    func setupRecorder() {

        recordingSession = AVAudioSession.sharedInstance()
        AVAudioSession.sharedInstance().requestRecordPermission { hasPermission in

            if hasPermission {
                print("Accepted")
            }

        }
    }
    
    func createAudioPathUrl(folderName: String, fileName: String) -> URL? {
        guard let savedDirectoryURL = createOrLoadFolder(folderName: folderName) else {
             print(NSError(domain: "YourAppErrorDomain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get cached images directory URL."]))
            return nil
        }
        
        let fileURL = savedDirectoryURL.appendingPathComponent(fileName)
        
        return fileURL
    }
    
    
    func deleteAudio() {
        if let audioFileName = audioFileName {
            removeFileOrFolderFromDisk(fileName: audioFileName, folderName: audioFolderName, removeFolder: false)
        }
        
        
    }
}

