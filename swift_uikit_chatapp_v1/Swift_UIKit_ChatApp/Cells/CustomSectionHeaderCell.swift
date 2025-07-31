//
//  CustomSectionHeaderView.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 21.6.2023.
//


import UIKit


class CustomSectionHeaderView: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // Customize the section header view
        // Create a blur effect
//           let blurEffect = UIBlurEffect(style: .regular)
//           
//           // Create a blur effect view
//           let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        
        self.contentView.backgroundColor = .systemGray6 // Replace with your desired background color
        //self.addSubview(blurEffectView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
