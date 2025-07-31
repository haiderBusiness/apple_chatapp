//
//  Chatroom+contextmenu.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 7.11.2023.
//

import UIKit

enum CustomReactionActionAttributes {
    case extra
    case disabled
    case destructive
    case hidden
    case normal
}

struct ContextReactionItem {
    var emojiString: String = ""
    var image: UIImage? = UIImage()
    var customSize: Float = Float()
    var selected: Bool = false
    var attributes: CustomReactionActionAttributes = .normal
    var handler: ((String?) -> Void) = {empty in}
}

struct ReactionCell {
    var id: String = ""
    var reactionButton: UIButton = UIButton()
//    var imageView: UIView = UIView()
    var label: UILabel = UILabel()
    var imageView: UIImageView = UIImageView()
    var blur: UIVisualEffectView = UIVisualEffectView()
    var actionItems: ContextReactionItem = ContextReactionItem(emojiString: "")
}


struct BubbleLeadingConfiguration {
    var anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>
    var constant: CGFloat
    var left: Bool
}
