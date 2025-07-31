//
//  Chatroom+OptionSheet.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 6.7.2023.
//

import UIKit

extension ChatroomVC {
    
    
    @objc func slidUpOptions() {
       
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        //bottomFooterView.alpha = 1
        UIView.animate(withDuration: 0.3) {
            self.optionsContainerBottomConstraint.constant = -50
            self.optionsContainerView.isUserInteractionEnabled = true
            self.optionsContainerView.alpha = 1
            window.layoutIfNeeded()
        }
    }

    @objc func slidDownOptions() {
       
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        //bottomFooterView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.optionsContainerBottomConstraint.constant = 350
            self.optionsContainerView.isUserInteractionEnabled = false
            self.optionsContainerView.alpha = 0
            window.layoutIfNeeded()
        }
    }

    func optionSheet() {
        
//        self.view.addSubview(optionsContainerView)
        optionsContainerView.translatesAutoresizingMaskIntoConstraints = false
        optionsContainerView.layer.cornerRadius = 15
        optionsContainerView.clipsToBounds = true
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        
        
        optionsContainerView.isUserInteractionEnabled = false
        
        optionsContainerView.alpha = 0
        
        let backgroundView = UIButton()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.3 // turn to 0.3 on activision
        backgroundView.isUserInteractionEnabled = true
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(slidDownOptions))
//        tapGesture.numberOfTapsRequired = 1
//        tapGesture.numberOfTouchesRequired = 1
//        backgroundView.addGestureRecognizer(tapGesture)
        backgroundView.addTarget(self, action: #selector(slidDownOptions), for: .touchDown)
        
        optionsContainerView.addSubview(backgroundView)
        window.addSubview(optionsContainerView)
        //keyboardContainer.backgroundColor = .red
        
        let optionsContainer = UIView()
        optionsContainer.translatesAutoresizingMaskIntoConstraints = false
        optionsContainer.layer.cornerRadius = 15
        optionsContainer.clipsToBounds = true
        
        
        
        optionsContainerView.addSubview(optionsContainer)
        
        
        NSLayoutConstraint.activate([
            optionsContainerView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
            optionsContainerView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            optionsContainerView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
            optionsContainerView.topAnchor.constraint(equalTo: window.topAnchor),
            
            backgroundView.leadingAnchor.constraint(equalTo: optionsContainerView.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: optionsContainerView.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: optionsContainerView.bottomAnchor),
            backgroundView.topAnchor.constraint(equalTo: optionsContainerView.topAnchor),
            //optionView.heightAnchor.constraint(equalToConstant: 300),
            
            optionsContainer.heightAnchor.constraint(equalToConstant: 300),
            optionsContainer.leadingAnchor.constraint(equalTo: optionsContainerView.leadingAnchor, constant: 8),
            optionsContainer.trailingAnchor.constraint(equalTo: optionsContainerView.trailingAnchor, constant: -8),
//            optionsContainer.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            //keyboardView
            //keyboardContainer.bottomAnchor.constraint(equalTo: optionView.topAnchor),
            //tableView.bottomAnchor.constraint(equalTo: optionView.topAnchor),
        ])
        
        

//        guard let topAnchor = windowScene.windows.first?.rootViewController?.view.safeAreaLayoutGuide.topAnchor else {
//            return
//        }
//
//        optionsContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        optionsContainerBottomConstraint = optionsContainer.bottomAnchor.constraint(equalTo: window.safeAreaLayoutGuide.bottomAnchor, constant: 350)
        optionsContainerBottomConstraint.isActive = true
        
        
        
        
        
        
        let cameraOption = createButton(iconName: "camera", title: Language.camera, titleColor: nil, backgroundColor: nil, upperView: nil, mainView: optionsContainer)
        
        let galleryOption = createButton(iconName: "photo", title: Language.gallery, titleColor: nil, backgroundColor: nil, upperView: cameraOption, mainView: optionsContainer)
        
        let fileOption = createButton(iconName: "doc", title: Language.file, titleColor: nil, backgroundColor: nil, upperView: galleryOption, mainView: optionsContainer)
        
        let mapOption = createButton(iconName: "map", title: Language.map, titleColor: nil, backgroundColor: nil, upperView: fileOption, mainView: optionsContainer)
        
        let userOption = createButton(iconName: "person", title: Language.user, titleColor: nil, backgroundColor: nil, upperView: mapOption, mainView: optionsContainer)
        
        let _ = createButton(iconName: "chart.bar", title: Language.poll, titleColor: nil, backgroundColor: nil, upperView: userOption, mainView: optionsContainer)
        
        let cancelOption = cancelButton(title: Language.cancel, titleColor: AppTheme.primaryColor, backgroundColor: nil, upperView: optionsContainer, mainView: optionsContainerView)
        
        cancelOption.addTarget(self, action: #selector(slidDownOptions), for: .touchUpInside)
    }
    
    
}


