//
//  EmojiCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 18.10.2023.
//

import UIKit





class EmojiCell: UICollectionViewCell {
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 32)
        label.clipsToBounds = false
        return label
    }()
    
    var whenDismissed: ((String?) -> Void) = { _ in }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.clipsToBounds = false
        self.contentView.layer.zPosition = -1
//        self.layer.zPosition = 0
        self.layer.zPosition = -1
        
        contentView.addSubview(textLabel)
        
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(press))
        self.addGestureRecognizer(tapGesture)
        
//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
//        longPressGesture.minimumPressDuration = 0.3
//        self.addGestureRecognizer(longPressGesture)
        
        textLabel.isUserInteractionEnabled = false
        self.isUserInteractionEnabled = true

        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func prepareForReuse() {
//        self.layer.zPosition = 0
    }
    
    
    @objc func press(sender: UIButton) {
        
        guard let collectionView = self.superview as? UICollectionView else {
            print("There is error in EmojiCell > press: superview is not a UICollectionView")
            return
        }
        
        if let superView = collectionView.superview as? EmojisView {
            superView.reset() {
                whenDismissed(textLabel.text)
            }
        } else if let supView = collectionView.superview as? EmojisSearchResultsView {
            if let superView = supView.superview as? EmojisView {
                superView.reset() {
                    whenDismissed(textLabel.text)
                }
            }
        } else {
            print("There is error in EmojiCell > press: none of the conditions was true")
        }
        
    }
    
    
    
//    @objc func longPress(sender: UILongPressGestureRecognizer) {
//
//        self.layer.zPosition = 1000000
//        self.layoutIfNeeded()
//
//        if sender.state == .began {
//
//            UIView.animate(withDuration: 0.7,  delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
//                self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//
//            }, completion: { hasCompleted in
//                if hasCompleted {
//                }
//            })
//
////            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
////
////                self.whenDismissed(self.textLabel.text)
//                self.layer.zPosition = 0
////                label.transform = .identity
////            })
//        }
//
//        else if sender.state == .ended {
//
//            UIView.animate(withDuration: 1,  delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
//                self.transform = .identity
//            }, completion: { hasCompleted in
//                if hasCompleted {
//                }
//            })
//
////            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
//                self.layer.zPosition = 0
////                label.transform = .identity
////            })
//
//
//        }
//    }
    
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
