//
//  Shemas.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 1.11.2023.
//


import Foundation
import UIKit
import CoreText

/// Struct representing a single emoji
public struct Emoji: Decodable, Equatable {
    public let emoji: String
    public let description: String
    public let category: EmojiCategory
    public let aliases: [String]
    public let tags: [String]
    public let iOSVersion: String
    
    /// Get a string representation of this emoji with another skin tone
    /// - Parameter withSkinTone: new skin tone to use
    /// - Returns: a string of the new emoji with the applied skin tone
   
    
    enum CodingKeys: CodingKey {
        case emoji
        case description
        case category
        case aliases
        case tags
        case skin_tones
        case ios_version
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.emoji = try container.decode(String.self, forKey: .emoji)
        self.description = try container.decode(String.self, forKey: .description)
        self.category = try container.decode(EmojiCategory.self, forKey: .category)
        self.aliases = try container.decode([String].self, forKey: .aliases)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.iOSVersion = try container.decode(String.self, forKey: .ios_version)
    }
    
    /// Create an instance of an emoji
    /// - Parameters:
    ///    - emoji: string representation of this emoji
    ///    - description: unicode textual description
    ///    - category: unicode category of this emoji
    ///    - aliases: similar names for this emoji
    ///    - tags: this emojis tags used for search
    ///    - supportsSkinTones: weather this emoji supports skin tones
    ///    - iOSVersion: the earliest iOS which supports this emoji
    public init (emoji: String, description: String, category: EmojiCategory, aliases: [String], tags: [String], iOSVersion: String) {
        self.emoji = emoji
        self.description = description
        self.category = category
        self.aliases = aliases
        self.tags = tags
        self.iOSVersion = iOSVersion
    }
    
    /// Create a duplicate of this emoji with another skin tone
    /// - Parameter withSkinTone: new skin tone to use. If nil, creates a standard yellow emoji
    /// - Returns: new Emoji with the applied skin tone
    public func duplicate (_ withSkinTone: EmojiSkinTone?) -> Emoji {
        return Emoji(emoji: emoji, description: description, category: category, aliases: aliases, tags: tags, iOSVersion: iOSVersion)
    }
}

/// Struct describing section of emojis
public struct EmojiSection {
    public let title: String
    public let icon: UIImage?
    public var emojis: [Emoji]
    
    /// Create an instance of an emoji section.
    /// - Parameters:
    ///   - title: Displayed section title
    ///   - icon: Displayed section icon (used in the built-in toolbar)
    ///   - emojis: Emojis contained in this section
    public init(title: String, icon: UIImage?, emojis: [Emoji]) {
        self.title = title
        self.icon = icon
        self.emojis = emojis
    }
}

public enum EmojiSkinTone: String, CaseIterable {
    case Light = "🏻"
    case MediumLight = "🏼"
    case Medium = "🏽"
    case MediumDark = "🏾"
    case Dark = "🏿"
}

public enum EmojiCategory: String, CaseIterable, Decodable {
    
    case SmileysAndEmotion = "Smileys & Emotion"
    case PeopleAndBody = "People & Body"
    case AnimalsAndNature = "Animals & Nature"
    case FoodAndDrink = "Food & Drink"
    case TravelAndPlaces = "Travel & Places"
    case Activities = "Activities"
    case Objects = "Objects"
    case Symbols = "Symbols"
    case Flags = "Flags"
    
    public var image: UIImage? {
        switch self {
        case .PeopleAndBody: return UIImage(systemName: "hand.wave", withConfiguration: UIImage.SymbolConfiguration(weight: .medium))?.withRenderingMode(.alwaysTemplate)
        default: return UIImage(named: self.rawValue, in: .main, with: nil)?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    var index: Int {
        switch self {
        case .SmileysAndEmotion: return 0
        case .PeopleAndBody: return 1
        case .AnimalsAndNature: return 2
        case .FoodAndDrink: return 3
        case .TravelAndPlaces: return 4
        case .Activities: return 5
        case .Objects: return 6
        case .Symbols: return 7
        case .Flags: return 8
        }
    }
}


public struct EmojiSectionConfiguration {
   
    public var categories: [EmojiCategory]
    
    public init(
        categories: [EmojiCategory] = [.SmileysAndEmotion, .PeopleAndBody, .AnimalsAndNature, .FoodAndDrink, .TravelAndPlaces, .Activities, .Objects, .Symbols, .Flags]
        ) {
        self.categories = categories.sorted(by: { $0.index < $1.index })

    }
}

public struct EmojiSectionLocalization {
    public var searchFieldPlaceholder: String
    
    public var searchResultsTitle: String
    public var searchResultsEmptyTitle: String
    
    public var randomButtonTitle: String
    
    public var emojiCategoryTitles: [EmojiCategory:String]
    
    /// Create new localization object
    /// - Parameters:
    ///   - searchFieldPlaceholder: Placeholder text for the search bar
    ///   - searchResultsTitle: Title text shown when presenting users with emoji search results
    ///   - searchResultsEmptyTitle: Title text shown when search results are empty
    ///   - randomButtonTitle: Title for the button that selects a random emoji
    ///   - emojiCategoryTitles: Dictionary of titles for default emoji categories, like "Smileys & Emotion", "People & Body", and so on.
    public init(
        searchFieldPlaceholder: String = "Search",
        searchResultsTitle: String = "Search results",
        searchResultsEmptyTitle: String = "No emoji found",
        randomButtonTitle: String = "Random",
        emojiCategoryTitles: [EmojiCategory : String] = EmojiCategory.allCases.reduce(into: [EmojiCategory:String](), { $0[$1] = $1.rawValue })) {
            
        self.searchFieldPlaceholder = searchFieldPlaceholder
        self.searchResultsTitle = searchResultsTitle
        self.searchResultsEmptyTitle = searchResultsEmptyTitle
        self.randomButtonTitle = randomButtonTitle
        self.emojiCategoryTitles = emojiCategoryTitles
    }
}

