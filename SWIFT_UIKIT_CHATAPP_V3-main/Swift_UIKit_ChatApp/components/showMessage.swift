//
//  showMessage.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 22.7.2023.
//

import UIKit

func showMessage(self: UIViewController, title: String?, message: String, okActionText: String, onActionPress: (() -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        if let onActionPress = onActionPress {
            onActionPress()
        }
    }
    alertController.addAction(okAction)
    self.present(alertController, animated: true, completion: nil)
}
