//
//  ChatroomVC+AudioRecordingDelgiate.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 30.8.2023.
//

import UIKit

extension ChatroomVC: AudioRecordingDelegate {
    func onAudioRecordingEnded(audioFullPathURL: URL?, fileName: String?) {
        if let _ = audioFullPathURL, let audioFileName = fileName {
            sendMessage(text: nil, audioFileName: audioFileName)
        } else {
            print("show message because file is nil")
        }
    }
    
    
}
