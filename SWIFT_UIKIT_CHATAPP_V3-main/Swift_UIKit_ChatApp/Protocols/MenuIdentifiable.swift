//
//  MenuIdentifiable.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 22.6.2023.
//

import Foundation
import UIKit

protocol MenuIdentifiable {
    var id : String  { get }
}

extension MenuIdentifiable {
    
    var menuID: NSString {
        NSString(string: id)
    }
    
    
    
    func isReferenced(by configuration: UIContextMenuConfiguration)  -> Bool {
        
        return menuID == configuration.identifier as? NSString
    }
    
}

extension Array where Element: MenuIdentifiable {
    
    func item(for configuration: UIContextMenuConfiguration) -> Element? {
        return first(where: {$0.menuID == configuration.identifier as? NSString})
    }
    
    func index(for configuration: UIContextMenuConfiguration) -> Index? {
        return firstIndex(where: {$0.menuID == configuration.identifier as? NSString})
    }
}

