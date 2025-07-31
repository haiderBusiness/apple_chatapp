//
//  ConvertImage.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 27.9.2023.
//

import UIKit
func emojiToImage(emoji: String, size: CGSize = CGSize(width: 100, height: 100)) -> UIImage? {
    let nsString = emoji as NSString
    let font = UIFont.systemFont(ofSize: size.width)
    
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    nsString.draw(at: CGPoint(x: 0, y: 0), withAttributes: [NSAttributedString.Key.font: font])
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
}
