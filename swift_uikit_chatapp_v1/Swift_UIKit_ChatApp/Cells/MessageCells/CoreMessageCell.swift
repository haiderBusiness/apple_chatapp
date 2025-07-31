//
//  CustomUITableViewCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 18.10.2023.
//

import UIKit

class CoreMessageCell: UITableViewCell {
    
    var updateMessage: (() -> Void) = {}
    var noInternetMessage: (() -> Void) = {}
    
    var longPressRecognizer: ContextMenuOnLongPress?
    
    var isAuth: Bool = false 
    
    var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }();
    
    let bubbleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }();
    
    let messageTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1

        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }();
    
    let messageTimeBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        let blur = BlurComponent.addBlur(toView: view, blurStyle: .dark)
        view.backgroundColor = .black
        view.alpha = 0.2
//        view.addSubview(blur)
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }();
    
    let messageTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }();
    
    
    let messageImage: ImageViewPro = {
        let image = ImageViewPro()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }();
    
    
    
    var checkmarkImageView: UIImageView = {
        var view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.image = UIImage(systemName: "checkmark")
        view.tintColor = .systemGray4
        return view
    }();
    
    
}
