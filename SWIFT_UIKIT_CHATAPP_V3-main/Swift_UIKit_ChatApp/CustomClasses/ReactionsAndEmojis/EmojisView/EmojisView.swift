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
    
    
    
    internal var snapshot: UIView? = nil
    
    let searchView = SearchView()
    
    let emojisSearchResultsView = EmojisSearchResultsView()
    
    var whenDismissed: ((String?) -> Void) = { _ in }
    
    var toolbar: SectionsToolbar!
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear // Customize the background color
        // Add any other subviews or content you want in your header here
        
        return view
    }()
    
    var prevFocusedSection: Int = 0
    var focusedSection: Int = 0
    
    var overridingFocusedSection: Bool = false
    
    
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

    let searhEmojis: [String] = []
    
    
    var emojiSections = [EmojiSection]()
    
    var isScrolling: Bool = false
    
    
    
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.emojiSections = getDefaultEmojiSections()
       
        

        self.addSubview(headerView)
        headerView.addSubview(searchView)
        
        self.addSubview(emojisCollectionView)
        self.addSubview(emojisSearchResultsView)
        
        self.AddToolbar()
        
        
        
        // collection view
        configureCollectionView()
        // search view
        confgureSearchBarView()
        // search results view
        configureSearchResultsView()
    }
    
    
    
    
    func AddToolbar () {
        
        
        toolbar = SectionsToolbar(sections: emojiSections)
        
        toolbar.backgroundColor = .clear
        
//        toolbar.backgroundColor = .red
//        emojisCollectionView.alpha = 0
        
        
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(toolbar)
        
        
        
        let borderView = UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        
        borderView.backgroundColor = .systemBackground.withAlphaComponent(0.5)
        
        toolbar.addSubview(borderView)
        
        toolbar.scrollToEmojis = { [weak self] index in
            self?.isScrolling = true
            let indexPath = IndexPath(row: 0, section: index)
            self?.emojisCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        }
        
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: self.searchView.leadingAnchor, constant: 0 ),
            toolbar.trailingAnchor.constraint(equalTo: self.searchView.trailingAnchor, constant: 0),
            toolbar.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 5),
            toolbar.heightAnchor.constraint(equalToConstant: 45),
            
            borderView.trailingAnchor.constraint(equalTo: self.toolbar.trailingAnchor),
            borderView.leadingAnchor.constraint(equalTo: self.toolbar.leadingAnchor),
            borderView.bottomAnchor.constraint(equalTo: self.toolbar.bottomAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 0.5),
        ])
        
        
    }
    
    
    
    
    func configureCollectionView() {
        
        self.clipsToBounds = true
//        toolbar.clipsToBounds = false
        emojisCollectionView.clipsToBounds = true
        
//        emojisCollectionView.backgroundColor = .red
//        emojisSearchResultsView.backgroundColor = .blue
        
        emojisCollectionView.register(EmojiSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        

        NSLayoutConstraint.activate([
//          emojisCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            emojisCollectionView.topAnchor.constraint(equalTo: self.toolbar.bottomAnchor),
            emojisCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            emojisCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            emojisCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        emojisCollectionView.delegate = self
        emojisCollectionView.dataSource = self
    }
    
    
    
    
    
    func showOrHideView(text: String) {
        
        if !text.isEmpty {
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                self.emojisCollectionView.alpha = 0
                self.emojisCollectionView.isUserInteractionEnabled = false
                
                self.toolbar.isUserInteractionEnabled = false
                self.toolbar.alpha = 0
                
                self.updateSearchResults(text: text)
                self.emojisSearchResultsView.alpha = 1
                
                self.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                
                self.emojisSearchResultsView.alpha = 0
                self.emojisSearchResultsView.emojis = []
                self.emojisSearchResultsView.emojisCollectionView.reloadData()
            
                self.emojisCollectionView.alpha = 1
                self.emojisCollectionView.isUserInteractionEnabled = true
                
                self.toolbar.isUserInteractionEnabled = true
                self.toolbar.alpha = 2
                
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    
    
    
   
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //TODO:
        print("here")
        searchView.hideCancel()
    }
    
    

    
    
    
    
    func getAllEmoji () -> [Emoji] {

        if let jsonURL = Bundle.main.url(forResource: "Emoji Unicode 15.0", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: jsonURL)
                let decoder = JSONDecoder()
                let yourDecodableStruct = try  decoder.decode([Emoji].self, from: jsonData)
                // Now you can work with your JSON data as a Swift object
//                print("here is the json: ", yourDecodableStruct)
                return yourDecodableStruct
            } catch {
                print("Error loading and parsing JSON: \(error)")
            }
        } else {
            print("JSON file not found in the bundle.")
            return [Emoji]()
        }
        
        
        return [Emoji]()
    }
    
    
    func getDefaultEmojiSections(config: EmojiSectionConfiguration = EmojiSectionConfiguration(), localization: EmojiSectionLocalization = EmojiSectionLocalization()) -> [EmojiSection]  {
        
        let emojis = getAllEmoji()

        
        var emojiSections = [EmojiSection]()
        
        let currentIOSVersion = UIDevice.current.systemVersion
        
        
        
        for emoji in emojis {
            if emoji.iOSVersion.compare(currentIOSVersion, options: .numeric) == .orderedDescending { continue } // Skip unsupported emojis.
            let categoryTitle = emoji.category.rawValue
            
            if let section = emojiSections.firstIndex(where: { $0.title == categoryTitle }) {
                emojiSections[section].emojis.append(emoji)
            } else if config.categories.contains(emoji.category) {
                emojiSections.append(
                    EmojiSection(title: categoryTitle, icon: emoji.category.image, emojis: [emoji])
                )
            }
        }
        
        return emojiSections
    }

    
    
    
    func reset(complation: (() -> Void) = {}) {
        
        // search
//        emojisSearchResultsView.emojis = []
        emojisSearchResultsView.emojisCollectionView.reloadData()
        searchView.onCancelButtonClick()
        
        
        
        
        //toolbar
        toolbar.updateSelection(sectionIndex: 0, animated: false)
//        toolbar.emojiSections = []
//        toolbar.collectionView.reloadData()
        toolbar.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        
        //emojisCollectionView
//        emojisCollectionView.reloadData()
        emojisCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
//        emojisCollectionView.scrollToItem(at: indexPath, at: .top, animated: false)
        
        
        self.snapshot?.removeFromSuperview()
        
//        emojiSections = []
//        emojisCollectionView.reloadData()
        
        
        complation()
    }

    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





