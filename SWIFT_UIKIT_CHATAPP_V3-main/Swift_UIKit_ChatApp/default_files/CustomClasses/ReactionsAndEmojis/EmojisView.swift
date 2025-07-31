//
//  ViewController.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 18.10.2023.
//

import UIKit

struct EmojiObject {
    let keyWord: String
    let emoji: String
}


class EmojisView: UIView {
    
    let searchView = SearchView()
    
    let emojisSearchResultsView = EmojisSearchResultsView()
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear // Customize the background color
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

    let sectionEmojis: [String: [EmojiObject]] = [
            "smily and people": smilyAndPeopleEmojis,
            "animals and nature": animalsAndNatureEmojis,
            "food and drink": foodAndDrinkEmojis,
            "objects": objectsEmojis,
            "flags": flagsEmojis,
            "symbols": symbolsEmojis,
            "travel and places": travelAndPlacesEmojis,
            "activity": activityEmojis,
        ]
    
    
    
//    let searhEmojis: [EmojiObject] = Array(smilyAndPeopleEmojis +
//                                           animalsAndNatureEmojis +
//                                           foodAndDrinkEmojis +
//                                           objectsEmojis +
//                                           flagsEmojis +
//                                           symbolsEmojis +
//                                           travelAndPlacesEmojis +
//                                           activityEmojis)
    let searhEmojis: [String] = ["😀","😃","😄","😁","😆","😅","😂","🤣","☺️","😊","😇","🙂","🙃","😉","😌","😍","😘","😗","😙","😚","😋","😜","😝","😛","🤑","🤗","🤓","😎","🤡","🤠","😏","😒","😞","😔","😟","😕","🙁","☹️","😣","😖","😫","😩","😤","😠","😡","😶","😐","😑","😯","😦","😧","😮","😲","😵","😳","😱","😨","😰","😢","😥","🤤","😭","😓","😪","😴","🙄","🤔","🤥","😬","🤐","🤢","🤧","😷","🤒","🤕","😈","👿","👹","👺","💩","👻","💀","☠️","👽","👾","🤖","🎃","😺","😸","😹","😻","😼","😽","🙀","😿","😾","👐","🙌","👏","🙏","🤝","👍","👎","👊","✊","🤛","🤜","🤞","✌️","🤘","👌","👈","👉","👆","👇","☝️","✋","🤚","🖐","🖖","👋","🤙","💪","🖕","✍️","🤳","💅","💍","💄","💋","👄","👅","👂","👃","👣","👁","👀", "🧠","🗣","👤","👥","👶","👦","👧","👨","👩","👱‍♀","👱","👴","👵","👲","👳‍♀","👳","👮‍♀","👮","👷‍♀","👷","💂‍♀","💂","🕵️‍♀️","🕵","👩‍⚕","👨‍⚕","👩‍🌾","👨‍🌾","👩‍🍳","👨‍🍳","👩‍🎓","👨‍🎓","👩‍🎤","👨‍🎤","👩‍🏫","👨‍🏫","👩‍🏭","👨‍🏭","👩‍💻","👨‍💻","👩‍💼","👨‍💼","👩‍🔧","👨‍🔧","👩‍🔬","👨‍🔬","👩‍🎨","👨‍🎨","👩‍🚒","👨‍🚒","👩‍✈","👨‍✈","👩‍🚀","👨‍🚀","👩‍⚖","👨‍⚖","🤶","🎅","👸","🤴","👰","🤵","👼","🤰","🙇‍♀","🙇","💁","💁‍♂","🙅","🙅‍♂","🙆","🙆‍♂","🙋","🙋‍♂","🤦‍♀","🤦‍♂","🤷‍♀","🤷‍♂","🙎","🙎‍♂","🙍","🙍‍♂","💇","💇‍♂","💆","💆‍♂","🕴","💃","🕺","👯","👯‍♂","🚶‍♀","🚶","🏃‍♀","🏃","👫","👭","👬","💑","👩‍❤️‍👩","👨‍❤️‍👨","💏","👩‍❤️‍💋‍👩","👨‍❤️‍💋‍👨","👪","👨‍👩‍👧","👨‍👩‍👧‍👦","👨‍👩‍👦‍👦","👨‍👩‍👧‍👧","👩‍👩‍👦","👩‍👩‍👧","👩‍👩‍👧‍👦","👩‍👩‍👦‍👦","👩‍👩‍👧‍👧","👨‍👨‍👦","👨‍👨‍👧","👨‍👨‍👧‍👦","👨‍👨‍👦‍👦","👨‍👨‍👧‍👧","👩‍👦","👩‍👧","👩‍👧‍👦","👩‍👦‍👦","👩‍👧‍👧","👨‍👦","👨‍👧","👨‍👧‍👦","👨‍👦‍👦","👨‍👧‍👧","👚","👕","👖","👔","👗","👙","👘","👠","👡","👢","👞","👟","🧣","🧤","🧥","🧦","🧢","👒","🎩","🎓","👑","⛑","🎒","👝","👛","👜","💼","👓","🕶","🌂","☂️"]
    
    let sections: [String] = [
        "smily and people",
        "animals and nature",
        "food and drink",
        "objects",
        "flags",
        "symbols",
        "travel and places",
        "activity",
      ]


   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(emojisCollectionView)
        self.addSubview(emojisSearchResultsView)
        self.addSubview(headerView)
        headerView.addSubview(searchView)
        
        // collection view
        configureCollectionView()
        // search view
        confgureSearchView()
        // search results view
        configureSearchResultsView()
            
            
    }
    
    func configureCollectionView() {
        emojisCollectionView.register(EmojiSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        
        

        NSLayoutConstraint.activate([
//                    emojisCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            emojisCollectionView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            emojisCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            emojisCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            emojisCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        emojisCollectionView.delegate = self
        emojisCollectionView.dataSource = self
    }
    
    
    func confgureSearchView() {
        
        // header view
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
       NSLayoutConstraint.activate([
           headerView.topAnchor.constraint(equalTo: self.topAnchor),
           headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
           headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
           headerView.heightAnchor.constraint(equalToConstant: 50), // Adjust the height as needed
           
           searchView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 8),
           searchView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 10),
           searchView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),

           searchView.heightAnchor.constraint(equalToConstant: 35),
       ])
        
        // search
        searchView.searchLabel.text = Language.search
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.searchBar.backgroundColor = .systemGray2.withAlphaComponent(0.3)
        searchView.layer.cornerRadius = 12
        searchView.clipsToBounds = true
        searchView.backgroundColor = .clear
        
        searchView.showSearchResults = { [weak self] text in
            guard let self = self else {return}
            self.showOrHideView(text: text)
        }
    }
    
    
    func showOrHideView(text: String) {
        
        if !text.isEmpty {
            emojisCollectionView.alpha = 0
            updateSearchResults(text: text)
            emojisSearchResultsView.alpha = 1
        } else {
            emojisSearchResultsView.alpha = 0
            emojisSearchResultsView.emojis = []
            emojisSearchResultsView.emojisCollectionView.reloadData()
            emojisCollectionView.alpha = 1
        }
    }
    
    
    func updateSearchResults(text: String?) {
        
        guard let searchText = text else {
            return
        }
        
        let searchResults = searhEmojis.filter { string in
            return string.localizedCaseInsensitiveContains(searchText)
        }
        
        if !searchResults.isEmpty {
            emojisSearchResultsView.emojis = searchResults
            emojisSearchResultsView.emojisCollectionView.reloadData()
        } else {
            emojisSearchResultsView.emojis = []
            emojisSearchResultsView.emojisCollectionView.reloadData()
        }
            
            
    }
    
    
    func configureSearchResultsView() {
        
        emojisSearchResultsView.translatesAutoresizingMaskIntoConstraints = false
        
        emojisSearchResultsView.alpha = 0
        
        NSLayoutConstraint.activate([
//                    emojisCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            emojisSearchResultsView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            emojisSearchResultsView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            emojisSearchResultsView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            emojisSearchResultsView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //TODO:
        print("here")
        searchView.hideCancel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





extension EmojisView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionTitle = sections[section]
        return sectionEmojis[sectionTitle]?.count ?? 0
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as! EmojiCell
        
        let sectionTitle = sections[indexPath.section]
        
        if let itemsInSection = sectionEmojis[sectionTitle] {
            let itemString = itemsInSection[indexPath.row].emoji
            cell.textLabel.text = itemString
            cell.backgroundColor = .clear
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! EmojiSectionHeader
            
//            if indexPath.section == 0 {
//                print("section == searchView")
//                headerView.searchView = searchView
//            }
            
            // Set the header's title based on your sections array
            let sectionTitle = sections[indexPath.section]
            headerView.titleLabel.text = sectionTitle.uppercased()
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
    
    
    
}

