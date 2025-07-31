//
//  SearchView.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 26.10.2023.
//

import UIKit

class SearchView: UIView {
    
    
    let cancelButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchBar: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "magnifyingglass")
        imageView.tintColor = .systemGray2
        return imageView
    }()
    
    let searchLabel: UITextView = {
        let label = UITextView()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var searchLabelPlaceHolderColor: UIColor = .systemGray2
    public var searchLabelTextColor: UIColor = .label
    
    public var searchLabelPlaceHolder: String = Language.search {
        didSet {
            searchLabel.text = searchLabelPlaceHolder
        }
    }
    
    
    public var showSearchResults: ((String) -> Void) = {emptyString in}
    
    
    var cancelButtonTrailingConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
   init(frame: CGRect, searchLabelText: String) {
        super.init(frame: frame)
        
        searchLabel.text = searchLabelText
    }
    
    
    
    func configureUI() {
        
        addSubview(searchBar)
        addSubview(cancelButton)
        addSubview(searchLabel)
        addSubview(searchImageView)
        
        searchBar.addTarget(self, action: #selector(onSearchButtonClick), for: .touchUpInside)
        searchBar.isUserInteractionEnabled = true
        searchBar.layer.cornerRadius = 12
        searchBar.clipsToBounds = true
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .systemGray2
        label.text = Language.cancel
        cancelButton.addSubview(label)
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: 5),
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchImageView.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 8),
            searchImageView.heightAnchor.constraint(equalToConstant: 25),
            searchImageView.widthAnchor.constraint(equalToConstant: 25),
            searchImageView.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            searchLabel.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: 5),
            searchLabel.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -20),
            searchLabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: topAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 80),
            
            label.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
            label.centerXAnchor.constraint(equalTo: cancelButton.centerXAnchor),
            
            
            
        ])
        
        cancelButton.addTarget(self, action: #selector(onCancelButtonClick), for: .touchUpInside)
        
        cancelButtonTrailingConstraint = cancelButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 90)
        cancelButtonTrailingConstraint?.isActive = true
        
        configureSearchText()
    }
    
    
    
    private func configureSearchText() {
        searchLabel.translatesAutoresizingMaskIntoConstraints = false
        searchLabel.text = searchLabelPlaceHolder
        searchLabel.delegate = self
        searchLabel.backgroundColor = .clear
        searchLabel.isScrollEnabled = false
        searchLabel.isEditable = true
        searchLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        searchLabel.textColor = searchLabelPlaceHolderColor
        searchLabel.textContainer.maximumNumberOfLines = 1
        searchLabel.textContainer.lineBreakMode = .byTruncatingHead
        
        searchLabel.selectedTextRange = searchLabel.textRange(from: searchLabel.beginningOfDocument, to: searchLabel.beginningOfDocument)
    }
    
    @objc func onCancelButtonClick() {
        hideCancel()
    }
    
    func hideCancel() {
        searchLabel.resignFirstResponder()
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn,  animations: {
            self.cancelButtonTrailingConstraint?.constant = 90
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func onSearchButtonClick() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn,  animations: {
            self.cancelButtonTrailingConstraint?.constant = 0
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension SearchView: UITextViewDelegate {
    
}
