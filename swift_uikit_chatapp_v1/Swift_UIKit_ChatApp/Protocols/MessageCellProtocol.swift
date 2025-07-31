//
//  MessageCellProtocol.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 28.9.2023.
//

import UIKit


protocol MessageCellProtocol {
    var alpha: CGFloat { get set }
    var frame: CGRect { get set }
    var mainView: UIView { get set }
    func convert(_ CGRect: CGRect, to: UIView) -> CGRect
    func configure(message: Message, isSelecting: Bool)
}
