//
//  AudioPlayerNodeDelegate.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 11.9.2023.
//

import Foundation
import AVFoundation

protocol AudioPlayerNodeDelegate {
    func audioPlayerDidFinishPlaying(audioElements: CachedAudioData, successfully flag: Bool)
}
