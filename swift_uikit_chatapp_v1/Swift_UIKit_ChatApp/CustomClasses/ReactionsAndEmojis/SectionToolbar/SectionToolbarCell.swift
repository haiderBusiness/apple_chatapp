//
//  SectionToolbarCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 2.11.2023.
//

import UIKit



class SectionToolbarCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .systemGray2.withAlphaComponent(0.8)
        image.clipsToBounds = true
        return image
    }()
    
    let selectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        return view
    }()
    
    var updateSelection: (() -> Void) = {}
    
//    var isSectionSelected: Bool = false {
//        didSet {
//            if isSectionSelected == true {
//                UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
//                    self.selectionView.backgroundColor = .systemGray2.withAlphaComponent(0.3)
//                    self.imageView.tintColor = .systemGray2
//                    self.layoutIfNeeded()
//                }, completion: nil)
//            } else {
//                UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
//                    self.selectionView.backgroundColor = .clear
//                    self.imageView.tintColor = .systemGray2.withAlphaComponent(0.8)
//                    self.layoutIfNeeded()
//                }, completion: nil)
//            }
//        }
//    }
    
    func selectSection(isSelected: Bool, animated: Bool) {
        if isSelected == true {
            
            if animated {
                UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                    self.selectionView.backgroundColor = .systemGray2.withAlphaComponent(0.3)
                    self.imageView.tintColor = .systemGray2
                    self.layoutIfNeeded()
                }, completion: nil)
            } else {
                self.selectionView.backgroundColor = .systemGray2.withAlphaComponent(0.3)
                self.imageView.tintColor = .systemGray2
                self.layoutIfNeeded()
            }
            
        } else {
            if animated {
                UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                    self.selectionView.backgroundColor = .clear
                    self.imageView.tintColor = .systemGray2.withAlphaComponent(0.8)
                    self.layoutIfNeeded()
                }, completion: nil)
            } else {
                self.selectionView.backgroundColor = .clear
                self.imageView.tintColor = .systemGray2.withAlphaComponent(0.8)
                self.layoutIfNeeded()
            }
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(selectionView)
        
        contentView.addSubview(imageView)
        
        
        
        selectionView.backgroundColor = .clear
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.selectionView.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
        

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
//            imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 10)
            
            selectionView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -8),
            selectionView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            selectionView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8),
            selectionView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8)
        ])
    }
    
    
    override func prepareForReuse() {
        selectSection(isSelected: false, animated: false)
    }
    
    
     @objc func onTap() {
        updateSelection()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
