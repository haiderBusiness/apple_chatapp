//
//  LocalazationTopSections.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 1.11.2023.
//

import UIKit

class SectionsToolbar: UIView {
        
        
    let mainView = UIView()
        
    var emojiSections: [EmojiSection]!
    
    var collectionView: UICollectionView!
    
    let itemCellIdentifier = "SectionToolbarCell"
        
    var blur: UIVisualEffectView = UIVisualEffectView()
    
    var scrollToEmojis: ((Int) -> Void) = { index in }
        
    init(sections: [EmojiSection]) {
        super.init(frame: .zero)
        emojiSections = sections
        self.configureUI()
    }
        
    func configureUI() {
        setupCollectionView()
    }
    
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SectionToolbarCell.self, forCellWithReuseIdentifier: itemCellIdentifier)
        
        collectionView.showsHorizontalScrollIndicator = false
        
        // space to end and begening of the scrolling
        collectionView.contentInset = UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0)
        
        addSubview(collectionView)

        NSLayoutConstraint.activate([
                    collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    collectionView.centerYAnchor.constraint(equalTo: centerYAnchor),
                    collectionView.heightAnchor.constraint(equalToConstant: 40)
                ])
    }
        
    
        
        
        
    
    @objc func press() {
        
    }
    
    func updateSelection(sectionIndex: Int? = nil, animated: Bool) {

        for cell in collectionView.visibleCells {
            if let cell = cell as? SectionToolbarCell {
                cell.selectSection(isSelected: false, animated: animated)
            }
        }
        
        if let sectionIndex = sectionIndex {
            let indexPath = IndexPath(row: sectionIndex, section: 0)
            
            let cell = collectionView.cellForItem(at: indexPath)
            
            if let cell = cell as? SectionToolbarCell {
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
                cell.selectSection(isSelected: true, animated: animated)
            }
        }
    }
    
    
    
        
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

}


extension SectionsToolbar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojiSections.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as! SectionToolbarCell
        let section = emojiSections[indexPath.item]
        
        cell.imageView.image = section.icon

        cell.backgroundColor = .clear
        
        // by default (first lunch)
        if section.title == "Smileys & Emotion" {
            cell.selectSection(isSelected: true, animated: true)
        }
        
        cell.updateSelection = { [weak self] in
            self?.updateSelection(sectionIndex: indexPath.row, animated: true)
            self?.scrollToEmojis(indexPath.row)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Return the size for each cell
        return CGSize(width: 40, height: 40) // Adjust these values as needed
    }
    
    

}




