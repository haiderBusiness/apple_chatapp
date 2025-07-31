//
//  FetchJsonArrayFromRootFolder.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 29.10.2023.
//

import UIKit


func loadEmojiDataFromJSON() -> [Emoji]? {
    if let path = Bundle.main.path(forResource: "emojisJson", ofType: "json") {
            do {
                print("here json reached")
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let decoder = JSONDecoder()
//                print("here json reached")
                let emojiArray = try decoder.decode([Emoji].self, from: data)
                return emojiArray
            } catch {
                print("Error loading JSON data: \(error)")
            }
        }
        print("loadEmojiDataFromJSON")
        return nil
}

//func getAllEmoji() -> [Emoji] {
//    if let emojiData = try? Data(contentsOf: Bundle.main.url(forResource: "emojisJson", withExtension: "json")!) {
//        do {
//            return try JSONDecoder().decode([Emoji].self, from: emojiData)
//        } catch {
//            print("Error decoding JSON data: \(error)")
//        }
//    } else {
//        print("Error loading JSON data")
//    }
//
//    return []
//}
