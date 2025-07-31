//
//  File.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 26.9.2023.
//

import UIKit

class ContextMenuOnLongPress: UILongPressGestureRecognizer {
    
    var indexPath: IndexPath? = nil
    var message: Message? = nil
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    init(target: Any?, action: Selector?, indexPath: IndexPath, message: Message) {
       super.init(target: target, action: action)
        self.indexPath = indexPath
        self.message = message
    }
}
