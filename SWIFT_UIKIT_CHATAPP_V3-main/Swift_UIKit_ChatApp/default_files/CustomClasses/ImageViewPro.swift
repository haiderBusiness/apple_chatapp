//
//  ImageViewPro.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 21.7.2023.
//

import UIKit


var imageCache = NSCache<AnyObject, AnyObject>();

class ImageViewPro: UIImageView {
        
    func load(urlString: String, completion: (() -> Void)? = nil) {
            
            //check if image is cached
            if let image = imageCache.object(forKey: urlString as NSString) as? UIImage {
                self.image = image;
                if let _ = completion {
                    completion!()
                }
                return
            }
            
            // check if received string prop is valid make it of type URL
            guard let url = URL(string: urlString) else{
                return
            }
            
            
            
            // load web image
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            imageCache.setObject(image, forKey: urlString as NSString)
                            self?.image = image
                            if let _ = completion {
                                completion!()
                            }
                        }
                    }
                }
            }
        }
    
    
    func LoadSaveDisplayImage(originalImageUrl: String , placeHolderUrl: String, savePlaceHolder: Bool, fileName: String? = "", folderName: String, completion: ((Bool) -> Void)? = nil) {
        
            // load placeHolder
        
            if let image = loadImageFromDisk(fileName: placeHolderUrl, folderName: folderName) {
                self.image = image
                if let _ = completion {
                    completion?(true)
                }
                return
                // load origianl image
            } else if let image = loadImageFromDisk(fileName: originalImageUrl, folderName: folderName) {
                self.image = image
                if let _ = completion {
                    completion?(true)
                }
                
                return
            }

        
        
        guard let url = URL(string: placeHolderUrl) else{
            return
        }
        
    
        
        // load web image
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        
                        if savePlaceHolder {
                            // save placeHolder to disk
                            saveImageToDisk(imageData: data, fileName: placeHolderUrl, folderName: folderName)
                        }
                       
                        
                        self?.image = image
                            completion?(true)
                    }
                }
            }
        }
        
        
    }
    
    
    func showPlaceHolderWhileDonwloadingImage(originalImageUrl: String , placeHolderUrl: String, savePlaceHolder: Bool, fileName: String? = "", folderName: String, completion: ((Bool) -> Void)? = nil) {
        
        
            // load origianl image
            if let image = loadImageFromDisk(fileName: originalImageUrl, folderName: folderName) {
                self.image = image
                if let _ = completion {
                    completion?(true)
                }
                
                return
            }

        
        
        guard let webPlaceHolderUrl = URL(string: placeHolderUrl) else {
            completion?(false)
            return
        }
        
        
        
        
        
        
        // load web image
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: webPlaceHolderUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        
                        // save placeHolder to disk
                        saveImageToDisk(imageData: data, fileName: placeHolderUrl, folderName: folderName)
                        self?.image = image
                        self?.loadWebOriginalImage(imageUrl: originalImageUrl, fileNameToRemove: placeHolderUrl, folderName: folderName, completion: completion)
                    }
                }
            }
        }

    }
    
    
    private func loadWebOriginalImage(imageUrl: String, fileNameToRemove: String, folderName: String, completion: ((Bool) -> Void)? = nil) {
        
        guard let webUrl = URL(string: imageUrl) else {
            completion?(false)
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: webUrl), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    // Save the original image to disk
                    removeImageFromDisk(fileName: fileNameToRemove, folderName: folderName)
                    saveImageToDisk(imageData: data, fileName: imageUrl, folderName: folderName)
                    
                    // Display the original image
                    self?.image = image
                    completion?(true)
                }
            } else {
                completion?(false)
            }
        }
    }
    
    
    
        
        func icon() {
            self.image = Empty.image
        }
}


