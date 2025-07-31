//
//  EmojiSectionHeader.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 24.10.2023.
//

import UIKit


class EmojiSectionHeader: UICollectionReusableView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.5, weight: .semibold)
        label.textColor = .systemGray2.withAlphaComponent(0.7)
        return label
    }()
    
//    var searchView: SearchView? {
//        didSet {
//            if let searchView = searchView {
//
//                addSubview(searchView)
//                searchView.translatesAutoresizingMaskIntoConstraints = false
//
//                searchView.searchBar.backgroundColor = .systemGray2.withAlphaComponent(0.3)
//                searchView.layer.cornerRadius = 12
//                searchView.clipsToBounds = true
//                searchView.backgroundColor = .clear
//
//                print("there is search view")
//                NSLayoutConstraint.activate([
//                    searchView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
//                    searchView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
//                    searchView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//
//                    searchView.heightAnchor.constraint(equalToConstant: 35),
////                    searchView.bottomAnchor.constraint(equalTo: bottomAnchor)
//                ])
//
//                titleLabelTopConstraint?.isActive = false
//                titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 8)
//                titleLabelTopConstraint?.isActive = true
//            }
//        }
//    }
    
    
    var titleLabelTopConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)

        // constraints to position the label within the header view as needed
            
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        
        titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: topAnchor)
        titleLabelTopConstraint?.isActive = true
    }
    
    
    override func prepareForReuse() {
        titleLabel.text = nil
//        searchView?.removeFromSuperview()
//        searchView = nil
        titleLabelTopConstraint?.isActive = false
        titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: topAnchor)
        titleLabelTopConstraint?.isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
