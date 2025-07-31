//
//  addBlur.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 24.6.2023.
//

import UIKit

 func AddBlur(toView: UIView, blurStyle: UIBlurEffect.Style) -> UIVisualEffectView {
    let blurEffect = UIBlurEffect(style: blurStyle)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)

    blurEffectView.frame = toView.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return blurEffectView
}

