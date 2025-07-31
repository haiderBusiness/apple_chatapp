//
//  GroupCreationHeader.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 19.6.2023.
//

import UIKit


class GroupCreationHeader: UIView {
    
    var optionDelegate: GroupCreationMessageDisapearSheet?
    var photoDelegate: GroupCreationPhotoSheet?
    
    let firstContainerView = UIView()
    let groupImage = ImageViewPro()
    let nameTextField = UITextField()
    
    let secondContainerView = HighlightedButton()
    let noteLabel = UILabel()
    var option: MessageDisapear = .off
    
    let optionText = UILabel()
    
    
    func configureUI() {
        configureFirstContainerView()
        configureSecondContainerView()
    }

    
}


