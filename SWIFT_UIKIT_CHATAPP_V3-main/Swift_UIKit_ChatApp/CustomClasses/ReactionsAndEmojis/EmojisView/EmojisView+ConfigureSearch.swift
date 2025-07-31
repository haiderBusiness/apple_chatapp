//
//  EmojisView+ConfigureSearch.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 3.11.2023.
//

import UIKit

extension EmojisView {
    
    func confgureSearchBarView() {
        
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
        searchView.searchLabelPlaceHolder = Language.search
        searchView.searchLabelPlaceHolderColor = .systemGray2
        searchView.searchLabelTextColor = .label
        searchView.layer.cornerRadius = 12
        searchView.clipsToBounds = true
        searchView.backgroundColor = .clear
        
        searchView.showSearchResults = { [weak self] text in
            guard let self = self, let text = text else {return}
            self.showOrHideView(text: text)
        }
    }
    
    
    
    func updateSearchResults(text: String?) {
        
        guard let searchText = text else {
            return
        }
        
        var cleanSearchTerm = searchText.lowercased()
        
        if cleanSearchTerm.last == " " { cleanSearchTerm.removeLast() }
        
        var results = [Emoji]()

        for section in self.emojiSections {
            results.append(contentsOf: section.emojis.filter {
                $0.aliases.contains(where: { $0.localizedCaseInsensitiveContains(cleanSearchTerm) }) ||
                $0.tags.contains(where: { $0.localizedCaseInsensitiveContains(cleanSearchTerm) }) ||
                $0.description.localizedCaseInsensitiveContains(cleanSearchTerm)
            })
        }
        
        if !results.isEmpty {
            emojisSearchResultsView.emojis = results
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
    
}
