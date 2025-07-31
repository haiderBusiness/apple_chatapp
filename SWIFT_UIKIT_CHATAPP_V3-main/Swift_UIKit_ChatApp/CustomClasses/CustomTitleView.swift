//
//  CustomTitleView.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 26.7.2023.
//

import UIKit

class CustomTitleView: UIView {
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "change label text"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(activityIndicator)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            activityIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: activityIndicator.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setActivityIndicator(hidden: Bool) {
       if hidden {
           activityIndicator.stopAnimating()
           activityIndicator.isHidden = true
       } else {
           activityIndicator.startAnimating()
           activityIndicator.isHidden = false
       }
   }
    
}

