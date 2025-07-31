//
//  ChatroomVC+Audio.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 5.9.2023.
//

import UIKit
import AVFoundation


struct AudioObject {
    var id: String
    var audioFileUrl: URL
    var duration: Int
    var currentTime: Int
    var isPlaying: Bool
    var isPaused: Bool
    var indexPath: IndexPath
}

extension ChatroomVC {
    
    func audioPlaying() {
        
    }
    
    func playAudio(audioObject: AudioObject) {
        
        var audioObject = audioObject
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioObject.audioFileUrl)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioObject.isPlaying = true
            playingAudio = audioObject
            audios.append(audioObject)
//            waveformView.progressSamples = 0
        } catch {
            print("Error in initializing audio player in (playAudio > catch block). Details: ", error.localizedDescription)
        }
    }
}


extension ChatroomVC: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("finished")
            if flag {
                if let audioObejct = audios.first(where: {$0.id == playingAudio?.id}) {
                    let cell = tableView.cellForRow(at: audioObejct.indexPath) as! CTRMAudioMessageCell
                    cell.audioPlayerView.resetToDefault()
                }
//                tableView.visibleCells
            } else {
                print("Audio playback finished with an error.")
                // Handle the case where playback finished with an error
            }
        }
}
