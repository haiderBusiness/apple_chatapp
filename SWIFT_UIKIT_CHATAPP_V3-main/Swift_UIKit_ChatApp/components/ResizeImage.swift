//
//  ResizeImage.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 18.7.2023.
//

import UIKit

func resizeImage(_ image: UIImage, to targetSize: CGSize) -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(targetSize, false, 0.0)
    image.draw(in: CGRect(origin: .zero, size: targetSize))
    let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return resizedImage
}
