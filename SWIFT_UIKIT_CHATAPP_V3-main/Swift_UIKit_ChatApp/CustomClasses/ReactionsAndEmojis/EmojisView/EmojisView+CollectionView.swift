//
//  EmojisView+CollectionView.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 1.11.2023.
//

import UIKit




extension EmojisView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emojiSections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojiSections[section].emojis.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as! EmojiCell
        
        
        cell.clipsToBounds = false
        
        
        var emoji: Emoji? = nil
        
        if emojiSections.indices.contains(indexPath.section) {
            if emojiSections[indexPath.section].emojis.indices.contains(indexPath.row) {
                emoji = emojiSections[indexPath.section].emojis[indexPath.row]
            }
        }
        
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressGesture.minimumPressDuration = 0.3
        cell.addGestureRecognizer(longPressGesture)
        
        
        
        cell.whenDismissed = { [weak self] emoji in
            guard let self = self else {return}
            
            if let emoji = emoji {
                self.whenDismissed(emoji)
            } else {
                self.whenDismissed(nil)
            }
        }
        
        if let emoji = emoji {
            cell.textLabel.text = emoji.emoji
            return cell
        } else {
            return UICollectionViewCell()
        }
        
        

            
        
        
//        let sectionTitle = sections[indexPath.section]
//        if let itemsInSection = sectionEmojis[sectionTitle] {
//            let itemString = itemsInSection[indexPath.row].emoji
//            cell.textLabel.text = itemString
//            cell.backgroundColor = .clear
//            return cell
//        } else {
//            return UICollectionViewCell()
//        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! EmojiSectionHeader
            
            let categoryTitle = emojiSections[indexPath.section].title
            headerView.titleLabel.text = categoryTitle
            return headerView
        }
        
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        if section == 0 {
//            return CGSize(width: collectionView.frame.width, height: 70)
//        }
        return CGSize(width: collectionView.frame.width, height: 30) // Adjust the height as needed
    
    }
    
    
    
    
    
    
    
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        
        
          // one way to detect cell position // TODO: it needs indexPath
//        let indexPath = IndexPath(row: 0, section: 0)
//        let attributes = emojisCollectionView.layoutAttributesForItem(at: indexPath)
//        let cellRect = attributes?.frame
       
        
        
        // remove previous cellSnapshot from superView to avoid duplications
        if let cellSnapshot = snapshot {
            cellSnapshot.removeFromSuperview()
        }
        
        
        // one of the ways to detect what cell has been clicked // TODO: Not the easiest way
//        let point = sender.location(in: emojisCollectionView)
//        guard let receivedIndexPath = emojisCollectionView.indexPathForItem(at: point) else { return }
//        guard let cell = emojisCollectionView.cellForItem(at: receivedIndexPath) as? EmojiCell else { return }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        
        
        // the best approach to detect tapped cell
        guard let cell = sender.view as? EmojiCell else { return }
        
        guard let cellSnapshot = cell.snapshotView(afterScreenUpdates: false) else { return }
        
        snapshot = cellSnapshot
        
        guard let cellSnapshot = snapshot else {
            return
        }

        // one way of getting cell position // TODO: but not very accurate in this case
        //let cellRectInView = cell.convert(cell.frame, to: self)
        
        
        // the best working approach of getting cell position in this case
        let cellFrameInSuperview = emojisCollectionView.convert(cell.frame, to: window)
        
    
        cellSnapshot.isHidden = false
        
        cellSnapshot.frame = cellFrameInSuperview
        
        window.addSubview(cellSnapshot)
        

        
        self.layoutIfNeeded()
        
        if sender.state == .began {
            
            UIView.animate(withDuration: 0.7,  delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                       cellSnapshot.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                        
            }, completion: { hasCompleted in
                if hasCompleted {
                }
            })

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
                self?.reset() {
                    cell.whenDismissed(cell.textLabel.text)
                    cellSnapshot.transform = .identity
                }
            })
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: { [weak self] in
//
//                cell.whenDismissed(cell.textLabel.text)
//                cellSnapshot.transform = .identity
//                cellSnapshot.removeFromSuperview()
//
//            })
        }
        
        else if sender.state == .ended {
            //TODO: nothing yet
        }
    }
    
    
    
}


