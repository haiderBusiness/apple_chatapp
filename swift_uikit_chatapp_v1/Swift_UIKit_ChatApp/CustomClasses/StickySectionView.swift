//
//  StickySectionView.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 8.8.2023.
//

import UIKit

class StickySectionView: UIView {
    
    let sectionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        let containerView = UIView()
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 20 * 0.40
        containerView.clipsToBounds = true

        
       
        let blur = AddBlur(toView: containerView, blurStyle: .dark)

        containerView.alpha = 0.4
        containerView.addSubview(blur)
        
        
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            //containerView.topAnchor.constraint(equalTo: sectionStickyView.topAnchor, constant: 25),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            //containerView.bottomAnchor.constraint(equalTo: sectionStickyView.bottomAnchor,constant: -10)
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
            
            sectionLabel.textColor = .white
            sectionLabel.text = ""
            sectionLabel.font = UIFont.boldSystemFont(ofSize: 14)
            sectionLabel.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(sectionLabel)
            
            // Add constraints to position the sectionLabel within the headerView
            NSLayoutConstraint.activate([
                sectionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
                sectionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
                sectionLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
                sectionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
            
            
            //sectionStickyView.transform = CGAffineTransform(scaleX: 1, y: -1)
            
//            return sectionStickyView
    }

}
