//
//  AudioPlayerManager.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 7.9.2023.
//

import AVFoundation

//class AudioPlayerManager {
//    static let shared = AudioPlayerManager()
//
//    private var audioPlayers: [URL: AVAudioPlayer] = [:]
//
//    func getAudioPlayer(for url: URL) -> AVAudioPlayer? {
//        if let existingPlayer = audioPlayers[url] {
//            return existingPlayer
//        } else {
//            do {
//                let newPlayer = try AVAudioPlayer(contentsOf: url)
////                newPlayer.delegate = self
//                newPlayer.prepareToPlay()
//                audioPlayers[url] = newPlayer
//                return newPlayer
//            } catch {
//                print("Error creating AVAudioPlayer: \(error)")
//                return nil
//            }
//        }
//    }
//}





//class AudioPlayerManager {
//    static let shared = AudioPlayerManager()
//
//    private var audioPlayers: [URL: AVAudioPlayer] = [:]
//    private var audioPlayersSpeedRates: [URL: Float] = [:]
//    private var currentlyPlayingPlayer: AVAudioPlayer?
//
//    func getAudioPlayer(for url: URL) -> AVAudioPlayer? {
//        if let existingPlayer = audioPlayers[url] {
//            return existingPlayer
//        } else {
//            do {
//                let newPlayer = try AVAudioPlayer(contentsOf: url)
////                newPlayer.delegate = self
//                newPlayer.prepareToPlay()
//                audioPlayers[url] = newPlayer
//                return newPlayer
//            } catch {
//                print("Error creating AVAudioPlayer: \(error)")
//                return nil
//            }
//        }
//    }
//
//    func playAudio(at url: URL) {
//        if let newPlayer = getAudioPlayer(for: url) {
//            // Pause the currently playing player if there is one
//            if let currentlyPlayingPlayer = currentlyPlayingPlayer {
//                if currentlyPlayingPlayer.isPlaying {
//                    currentlyPlayingPlayer.pause()
//                }
//            }
//
//            newPlayer.play()
//            currentlyPlayingPlayer = newPlayer
//        }
//    }
//
//    func changeAudioSpeedRate(url: URL, rate: Float ) {
//        audioPlayersSpeedRates[url] = rate
//    }
//
//    func getAudioSpeedRate(for url: URL) -> Float? {
//        if let existingRate = audioPlayersSpeedRates[url] {
//            return existingRate
//        }
//        return nil
//    }
//}

struct CachedAudioData {
    var audioUrl: URL
    var audioFile: AVAudioFile
    var audioPlayerNode: AVAudioPlayerNode
    var varispeed: AVAudioUnitVarispeed? = nil
    var audioDuration: Double
    var audioCurrentTime: Double = 0.0
    var progress: Float = 0.0
   
}

class AudioPlayerManager {
    static let shared = AudioPlayerManager()
    
    public var  audioPlayerNodeDelegate: AudioPlayerNodeDelegate?
    private var audioEngine = AVAudioEngine()
    private var audioPlayerData: [URL: CachedAudioData] = [:]
    private var currentlyPlayingCachedAudioData: CachedAudioData?
    
    
    func getCachedAudioElements(for url: URL) -> CachedAudioData? {
        if let existingNode = audioPlayerData[url] {
            return existingNode
        } else {
            do {
                let audioFile = try AVAudioFile(forReading: url)
                let newNode = AVAudioPlayerNode()
                let varispeed = AVAudioUnitVarispeed()
                
                let audioDuration = getAudioDuration(audioFile: audioFile)
                
               
                audioEngine.attach(varispeed)
                audioEngine.attach(newNode)
                audioEngine.connect(newNode, to: varispeed, format: nil)
                audioEngine.connect(varispeed, to: audioEngine.mainMixerNode, format: nil)
                
                varispeed.rate = 1.0
                
                let audioPlayerProperties = CachedAudioData(audioUrl: url, audioFile: audioFile, audioPlayerNode: newNode, varispeed: varispeed, audioDuration: audioDuration) // other proerties are set automatically
                
                audioPlayerData[url] = audioPlayerProperties
                
                return audioPlayerProperties
            } catch {
                print("Error while creating AVAudioPlayerNode in AudioPlayerManager > getCachedAudioElements > catch block. Error details: \(error)")
                return nil
            }
        }
    }

    
    func updateCachedAudioElements(updatedObject: CachedAudioData?) {
        guard let updatedObject = updatedObject else {
//            print("updateObject was nil in AudioPlayerManager > updateCachedAudioElements > first guard check")
            return
        }
        
//        print("updatedObject: ", updatedObject.audioCurrentTime)
        audioPlayerData[updatedObject.audioUrl] = updatedObject
    }
    
    
    
    
    func playAudio(at url: URL, currentProgress: Float = 0.0) {
        guard let cachedAudioElements = getCachedAudioElements(for: url) else { return }

        // Check if any audio is playing and pause it
        if let currentlyPlayingCachedAudioData = currentlyPlayingCachedAudioData, currentlyPlayingCachedAudioData.audioPlayerNode.isPlaying {
//            cachedAudioElements.progress = 0.0
//            cachedAudioElements.audioCurrentTime = 0.0
            print(currentlyPlayingCachedAudioData.progress)
            currentlyPlayingCachedAudioData.audioPlayerNode.pause()
//            audioPlayerData[url] = cachedAudioElements
        }

        do {
            let audioFile = cachedAudioElements.audioFile
            
            let currentProgress = cachedAudioElements.progress
            // Calculate the sample to seek to
            let totalSamples = audioFile.length
            let targetSample = AVAudioFramePosition(Float(totalSamples) * currentProgress)
           
            if !audioEngine.isRunning {
                try audioEngine.start()
            }
            
            // reset audioPlayer by stoping it
            cachedAudioElements.audioPlayerNode.stop()
            
            let frameCount = AVAudioFrameCount(audioFile.length - targetSample)
            
            cachedAudioElements.audioPlayerNode.scheduleSegment(audioFile, startingFrame: targetSample, frameCount: frameCount, at: nil, completionHandler: {
//                print("completed")
            })
            
//            cachedAudioElements.varispeed?.rate = rate
            

            
            // Start playback
            cachedAudioElements.audioPlayerNode.play()

            // Update the currently playing node reference
            currentlyPlayingCachedAudioData = cachedAudioElements
        } catch {
            print("Error playing audio: \(error)")
        }
    }
    
    
    func getAudioDuration(audioFile: AVAudioFile) -> Double {
        let audioFileFormat = audioFile.fileFormat
        let audioDuration = Double(audioFile.length) / audioFileFormat.sampleRate
        return audioDuration
        
    }
}
