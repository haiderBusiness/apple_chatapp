//
//  EmojisSearchResultsView.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 27.10.2023.
//

import UIKit


class EmojisSearchResultsView: UIView {
    
    let searchView = SearchView()
    
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red // Customize the background color
        // Add any other subviews or content you want in your header here
        return view
    }()
    
    
    let emojisCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.register(EmojiCell.self, forCellWithReuseIdentifier: "EmojiCell")
            collectionView.backgroundColor = .clear
            return collectionView
        }()

//    let emojis: [String: [EmojiObject]] = [
//            "smily and people": smilyAndPeopleEmojis,
//            "animals and nature": animalsAndNatureEmojis,
//            "food and drink": foodAndDrinkEmojis,
//            "objects": objectsEmojis,
//            "flags": flagsEmojis,
//            "symbols": symbolsEmojis,
//            "travel and places": travelAndPlacesEmojis,
//            "activity": activityEmojis,
//        ]
    
    var emojis: [Emoji] = []
    
    let emptyCollectionBackgroundView: UIView = {
            let containerView = UIView()
            
            let messageLabel = UILabel()
            messageLabel.text = "😖"
            messageLabel.textAlignment = .center
            messageLabel.textColor = .gray
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
            containerView.addSubview(messageLabel)
            
            let additionalLabel = UILabel()
            additionalLabel.text = Language.no_emoji_found
            additionalLabel.textAlignment = .center
            additionalLabel.textColor = .gray
            additionalLabel.translatesAutoresizingMaskIntoConstraints = false
            additionalLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            additionalLabel.textColor = .systemGray2.withAlphaComponent(0.7)
            containerView.addSubview(additionalLabel)
            
            // Define constraints for the labels
            messageLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            messageLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -20).isActive = true
            
            additionalLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            additionalLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 10).isActive = true
            
            return containerView
        }()
        
    
    let sections: [String] = [
        "Search Results"
      ]


   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // search
        searchView.searchLabel.text = Language.search
        
        
        
        emojisCollectionView.backgroundView = emptyCollectionBackgroundView
        
        emojisCollectionView.register(EmojiSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        self.addSubview(emojisCollectionView)

                NSLayoutConstraint.activate([
                    emojisCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
                    emojisCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                    emojisCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    emojisCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
                ])

                emojisCollectionView.delegate = self
                emojisCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





extension EmojisSearchResultsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as! EmojiCell
        
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressGesture.minimumPressDuration = 0.3
        cell.addGestureRecognizer(longPressGesture)
        
        
        cell.whenDismissed = { [weak self] emoji in
            guard let superView = self?.superview as? EmojisView else {return}
            
            if let emoji = emoji {
                superView.whenDismissed(emoji)
            } else {
                superView.whenDismissed(nil)
            }
        }
        
        

        if emojis.count > 0  {
        emojisCollectionView.backgroundView = nil
        let emoji = emojis[indexPath.row]
            cell.textLabel.text = emoji.emoji
            cell.backgroundColor = .clear
            return cell
        } else {
           
            return UICollectionViewCell()
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! EmojiSectionHeader
            
            // Set the header's title based on your sections array
            let sectionTitle = sections[indexPath.section]
            
            if emojis.count > 0  {
                headerView.titleLabel.text = sectionTitle.uppercased()
            } else {
                emojisCollectionView.backgroundView = emptyCollectionBackgroundView
                headerView.titleLabel.text = ""
            }
           
            return headerView
        }
        
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: 30) // Adjust the height as needed
    
    }
    
    
    
    
    
    
    
    @objc func longPress(sender: UILongPressGestureRecognizer) {
        
        
          // one way to detect cell position // TODO: it needs indexPath
//        let indexPath = IndexPath(row: 0, section: 0)
//        let attributes = emojisCollectionView.layoutAttributesForItem(at: indexPath)
//        let cellRect = attributes?.frame
       
        
        guard let superView = self.superview as? EmojisView else {
            return
        }
        
        
        // remove previous cellSnapshot from superView to avoid duplications
        if let cellSnapshot = superView.snapshot {
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
        
        superView.snapshot = cellSnapshot
        
        guard let cellSnapshot = superView.snapshot else {
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

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                superView.reset() {
                    cell.whenDismissed(cell.textLabel.text)
                    cellSnapshot.transform = .identity
                }
//                cellSnapshot.removeFromSuperview()
                
            })
        }
        
        else if sender.state == .ended {
            
        // TODO: nothing to do yet
        }
    }
    
    
    
}
