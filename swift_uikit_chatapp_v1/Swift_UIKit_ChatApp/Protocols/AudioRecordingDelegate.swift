//
//  AudioRecordingEndedAndSavedProtocol.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 30.8.2023.
//

import Foundation

protocol AudioRecordingDelegate {
    func onAudioRecordingEnded(audioFullPathURL: URL?, fileName: String?)
}
