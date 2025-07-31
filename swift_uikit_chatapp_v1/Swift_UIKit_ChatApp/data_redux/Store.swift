//
//  Store.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 5.6.2023.
//

import UIKit

class Store: ObservableObject {
    @Published private(set) var state: AppState
    
    init(initialState: AppState) {
        self.state = initialState
    }
    
    func dispatch(action: AppAction) {
        appReducer(state: &state, action: action)
    }
}





