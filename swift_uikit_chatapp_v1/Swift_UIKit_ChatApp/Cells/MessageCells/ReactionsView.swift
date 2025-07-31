//
//  ReactionsView.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 22.9.2023.
//

import UIKit

class ReactionsView: UIView {
    
    
    let reactionsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let firstReaction: ImageViewPro = {
        let imageView = ImageViewPro();
        imageView.layer.cornerRadius = 20;
        imageView.clipsToBounds = true;
        imageView.translatesAutoresizingMaskIntoConstraints = false;
        imageView.image = UIImage(systemName: "figure.run.square.stack")
        return imageView
    }();
    
    var isLeading = false {
        didSet {
            if isLeading {
                reactionsViewLeadingAnchor?.isActive = true
                reactionsViewTrailingAnchor?.isActive = false
            } else {
                reactionsViewTrailingAnchor?.isActive = true
                reactionsViewLeadingAnchor?.isActive = false
            }
        }
    }
    
    var reactionsViewLeadingAnchor: NSLayoutConstraint?
    var reactionsViewTrailingAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    func configureUI() {
        addSubview(reactionsView)
        reactionsView.backgroundColor = .red
        NSLayoutConstraint.activate([
//            reactionsView.centerXAnchor.constrainst(equalTo: view.centerXAnchor),
//            reactionsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
//            reactionsView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            reactionsView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
//            reactionsView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            reactionsView.heightAnchor.constraint(equalToConstant: 45),
            reactionsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            reactionsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            reactionsView.widthAnchor.constraint(equalToConstant: 100),
        ])
        
//        reactionsViewLeadingAnchor = reactionsView.leadingAnchor.constraint(equalTo: leadingAnchor)
//        reactionsViewTrailingAnchor = reactionsView.trailingAnchor.constraint(equalTo: trailingAnchor)
        
//        reactionsViewLeadingAnchor?.isActive = true
        
        configureFirstReaction()
    }
    
    func configureFirstReaction() {
        reactionsView.addSubview(firstReaction)
        
        NSLayoutConstraint.activate([
            firstReaction.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstReaction.centerYAnchor.constraint(equalTo: reactionsView.centerYAnchor),
            firstReaction.widthAnchor.constraint(equalToConstant: 40),
            firstReaction.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
