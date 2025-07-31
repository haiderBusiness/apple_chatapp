//
//  File.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 25.7.2023.
//

import Foundation

protocol NetworkManagerDelegate: AnyObject {
    func networkStatusDidChange(isConnected: Bool)
}
