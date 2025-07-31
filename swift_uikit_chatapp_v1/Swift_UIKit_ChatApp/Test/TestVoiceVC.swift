//
//  TestViewController.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 5.6.2023.
//

import UIKit
import AVFoundation

class TestVoiceVC: UIViewController {
    
   
    let circlesLineView = CircleLineView()
    
    let audioPlayerView = AudioPlayerView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        audioPlayerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(audioPlayerView)
        
        
        
        
        audioPlayerView.playButtonColor = .systemGray2
        audioPlayerView.wavesColor = .systemGray4
        audioPlayerView.wavesProgressColor = .systemGray2
        audioPlayerView.backgroundColor = .clear
        
        
        let diskPath = "ThisAppName/chats/2222/audios"
        
        let fileName = "audio_with_id_B3F1DF87-1405-4FE6-B492-E6B729ABB49F.m4a"
        audioPlayerView.audioUrlObject = AudioUrlObject(audioFolderName: diskPath, audioFileName: fileName)
        
        let screenWidth = UIScreen.main.bounds
        let eighty_percent = CGFloat(screenWidth.width * 0.8)
        
        NSLayoutConstraint.activate([
            audioPlayerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            audioPlayerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            audioPlayerView.widthAnchor.constraint(equalToConstant: eighty_percent),
            audioPlayerView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
  

}



