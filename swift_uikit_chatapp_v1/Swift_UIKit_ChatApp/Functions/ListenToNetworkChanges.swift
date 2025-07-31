//
//  ListenToNetworkChanges.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 25.7.2023.
//

//import UIKit
//import Network
//
//class NetworkMonitor {
//
//    static let shared = NetworkMonitor()
//
//    private let monitor = NWPathMonitor()
//    private(set) var isInternetAvailable: Bool = false
//
//    private init() {
//        startMonitoring()
//    }
//
//    private func startMonitoring() {
//        monitor.pathUpdateHandler = { [weak self] path in
//            guard let self = self else { return }
//
//            if path.status == .satisfied {
//                // Internet is available
//                self.isInternetAvailable = true
//            } else {
//                // No internet connection
//                self.isInternetAvailable = false
//            }
//
//            print("internet from default networkMonitor: ", path.status)
//
//            // Post a notification to inform about the network status change on the main thread
//            DispatchQueue.main.async {
//                NotificationCenter.default.post(name: Notification.Name("NetworkStatusChanged"), object: self.isInternetAvailable)
//            }
//        }
//
//        let queue = DispatchQueue(label: "NetworkMonitor")
//        monitor.start(queue: queue)
//    }
//}
