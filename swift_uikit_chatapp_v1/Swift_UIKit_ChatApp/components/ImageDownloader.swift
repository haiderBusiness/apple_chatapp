//
//  ImageDownloader.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 22.7.2023.
//

import UIKit

//class imageDownloader {
    
    
    func downloadImageToDisk(placeHolderUrl: String, folderName: String, beforStart:(() -> Void)? = nil, completion: (() -> Void)? = nil)  {
        
        
        if let beforStart = beforStart {
            beforStart()
        }
        
        // exit function if image is already in the disk
        if doesImageExist(folderName: folderName, fileName: placeHolderUrl) {
            return
        }

    
            guard let url = URL(string: placeHolderUrl) else{
                return
            }
    
        
    
            // load web image
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        // save placeHolder to disk
                        saveImageToDisk(imageData: data, fileName: placeHolderUrl, folderName: folderName)
                        
                        if let completion = completion {
                            completion()
                        }
                    }
                }
            }
    }
//}
