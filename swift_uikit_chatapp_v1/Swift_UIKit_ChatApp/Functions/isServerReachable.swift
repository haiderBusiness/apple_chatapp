//
//  isServerReachable.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 27.7.2023.
//

//import Reachability
//let reachability = try! Reachability()
//
//func isServerReachable(urlString: String) -> Bool {
//    guard let url = URL(string: urlString) else {
//        return false // Return false if the URL string is invalid
//    }
//
//    let reachability = try! Reachability()
//
//    switch reachability.connection {
//    case .unavailable, .none:
//        return false // Return false if the device has no network connection
//    case .cellular, .wifi:
//        // Check if the host (URL) is reachable
//        return reachability.isReachableViaWiFi || reachability.isReachableViaWWAN
//    }
//}

import UIKit
func isReachable(url: String, completion: @escaping (Bool) -> ()) {
    
        guard let url = URL(string: url) else { return }
    
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        URLSession.shared.dataTask(with: request) { _, response, _ in
            completion((response as? HTTPURLResponse)?.statusCode == 200)
        }.resume()
    }
