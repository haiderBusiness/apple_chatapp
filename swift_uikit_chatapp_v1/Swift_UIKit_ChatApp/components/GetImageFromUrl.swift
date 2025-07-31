//
//  GetImageFromUrl.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 13.7.2023.
//

import UIKit


    
//    static func load(urlString: String, completion: (() -> Void)? = nil) -> UIImage? {
//
//            //check if image is cached
//            if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
//                if let _ = completion {
//                    completion!()
//                }
//                return image
//            }
//
//            // check if received string prop is valid make it of type URL
//            guard let url = URL(string: urlString) else{
//                return nil
//            }
//
//
//
//            // load web image
//                if let data = try? Data(contentsOf: url) {
//                    if let image = UIImage(data: data) {
//
//                        imageCache.setObject(image, forKey: urlString as NSString)
//                        if let _ = completion {
//                            completion!()
//                        }
//
//                        return image
//                    }
//                }
//
//            return nil
//        }
    
   
func load(urlString: String) -> UIImage? {
    //check if image is cached
    if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
        return image
    }
    
    // check if received string prop is valid make it of type URL
    guard let url = URL(string: urlString) else{
        return nil
    }
    
    var loadedImage: UIImage?
    
    // load web image
    DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    loadedImage = image
                }
            }
        }
    }
    
    return loadedImage
}
