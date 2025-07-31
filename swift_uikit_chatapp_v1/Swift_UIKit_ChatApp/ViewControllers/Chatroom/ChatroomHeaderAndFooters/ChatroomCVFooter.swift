//
//  ChatroomCVFooterCollectionReusableView.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 28.6.2023.
//

import UIKit

class ChatroomCVFooter: UICollectionReusableView {
        
    let view = UIView()
    
    override init(frame: CGRect) {
          super.init(frame: frame)
      }
      
      required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
}
