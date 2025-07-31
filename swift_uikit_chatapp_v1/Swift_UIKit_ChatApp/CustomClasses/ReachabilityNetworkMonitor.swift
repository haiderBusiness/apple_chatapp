//
//  ReachabilityNetworkMonitor.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 25.7.2023.
//

//import UIKit
//import Reachability
//
//class NetworkManager {
//    static let shared = NetworkManager()
//
//    private let reachability = try! Reachability()
//
//    weak var delegate: NetworkManagerDelegate?
//
//    private init() {
//        startMonitoringReachability()
//    }
//
//    func startMonitoringReachability() {
//
//        do {
//            try reachability.startNotifier()
//            networkStatusChanged()
//        } catch {
//            print("Could not start reachability notifier")
//        }
//    }
//
//    func networkStatusChanged() {
//        if reachability.connection != .unavailable {
//            // Internet is available, update your UI accordingly
//            print("here here here")
//            delegate?.networkStatusDidChange(isConnected: true)
//        } else {
//
//            print("no no no")
//            // No internet connection, update your UI accordingly
//            delegate?.networkStatusDidChange(isConnected: false)
//        }
//    }
//
//    func stopMonitoringReachability() {
//        NotificationCenter.default.removeObserver(self)
//        reachability.stopNotifier()
//    }
//
//    deinit {
//        stopMonitoringReachability()
//    }
//}


import Foundation
import Reachability

class NetworkManager: NSObject {
    
    var reachability: Reachability!
    
    static let sharedInstance: NetworkManager = {
        return NetworkManager()
    }()
    
    
    var whenReachable: ((Reachability) -> Void)?
    var whenUnreachable: ((Reachability) -> Void)?
    
    override init() {
        super.init()
        // Initialise reachability
        reachability = try! Reachability()
        // Register an observer for the network status
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        do {
            // Start the network status notifier
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        print("status changed...")
        if let reachability = notification.object as? Reachability {
            if reachability.connection == .unavailable {
                whenUnreachable?(reachability)
            } else {
                whenReachable?(reachability)
            }
        }
    }
    
    
    static func stopNotifier() -> Void {
        do {
            // Stop the network status notifier
            try (NetworkManager.sharedInstance.reachability).startNotifier()
        } catch {
            print("Error stopping notifier")
        }
    }

    // Network is reachable
    static func isReachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection != .unavailable {
            completed(NetworkManager.sharedInstance)
        }
    }
    // Network is unreachable
    static func isUnreachable(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .unavailable {
            completed(NetworkManager.sharedInstance)
        }
    }
    // Network is reachable via WWAN/Cellular
    static func isReachableViaWWAN(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .cellular {
            completed(NetworkManager.sharedInstance)
        }
    }
    // Network is reachable via WiFi
    static func isReachableViaWiFi(completed: @escaping (NetworkManager) -> Void) {
        if (NetworkManager.sharedInstance.reachability).connection == .wifi {
            completed(NetworkManager.sharedInstance)
        }
    }
    
    
//    //sets the whenReachable closure:
//    func reachable(_ handler: @escaping (Reachability.NetworkReachable?) -> Void) {
//        handler(reachability.whenReachable)
//    }
//
//    //sets the whenUnreachable closure:
//    func notReachable(_ handler: @escaping (Reachability.NetworkUnreachable?) -> Void) {
//        handler(reachability.whenUnreachable)
//    }
    
}

