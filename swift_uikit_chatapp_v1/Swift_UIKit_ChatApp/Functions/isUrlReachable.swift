//
//  isUrlReachable.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 23.7.2023.
//

import UIKit

func isServerReachable(urlString: String, completion: @escaping (Bool) -> Void) {
    guard let url = URL(string: urlString) else {
            completion(false)
            return
        }

        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: urlRequest) { _, response, error in
            if let error = error {
                // The server is not reachable
                print("Server is not reachable. Error: \(error.localizedDescription)")
                completion(false)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    // The server is reachable and returned a successful response
                    print("Server is reachable.")
                    completion(true)
                } else {
                    // The server responded with an error status code
                    print("Server is reachable, but returned status code: \(httpResponse.statusCode)")
                    completion(false)
                }
            } else {
                // Unable to determine server reachability
                print("Unable to determine server reachability.")
                completion(false)
            }
        }

        task.resume()
}


//func isUrlReachable(url: String, completion: @escaping (Bool) -> Void) {
//    isServerReachable(urlString: url) { isReachable in
//        completion(isReachable)
//    }
//}
//
//func isUrlWorking(url: String) -> Bool {
//    isUrlReachable(url: url) { isReachable in
//        if isReachable {
//            // Do something if the server is reachable
//            return true
//        } else {
//            // Do something if the server is not reachable
//            return false
//        }
//    }
//}


func isUrlReachable(urlString: String) -> Bool {
    guard let url = URL(string: urlString) else {
        return false
    }

    return (try? url.checkResourceIsReachable()) ?? false
}



