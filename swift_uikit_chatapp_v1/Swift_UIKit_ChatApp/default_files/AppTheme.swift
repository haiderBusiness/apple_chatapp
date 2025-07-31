//
//  AppTheme.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 4.6.2023.
//

import UIKit

let currentTraitCollection = UITraitCollection.current



struct AppTheme {
    static let primaryColor : UIColor =   UIColor(red: 0.0, green: 194.0/255.0, blue: 168.0/255.0, alpha: 1.0)
    static let tertiaryColor = currentTraitCollection.userInterfaceStyle == .light ? UIColor.secondarySystemBackground : UIColor.tertiarySystemBackground
    static let sucsessColor : UIColor = UIColor(red: 37/255, green: 211/255, blue: 102/255, alpha: 1.0);
}
