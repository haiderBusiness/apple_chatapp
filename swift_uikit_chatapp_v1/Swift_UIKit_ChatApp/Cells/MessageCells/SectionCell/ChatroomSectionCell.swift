//
//  ChatroomSectionCell.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 8.8.2023.
//

import UIKit

class ChatroomSectionCell: UITableViewCell {
    
    static let identifier = "ChatroomSectionCell"
    
    let sectionLabel = UILabel()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated);
        selectionStyle = .none
    }
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI();
        //layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
       
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI() {
        let containerView = UIView()
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 20 * 0.40
        containerView.clipsToBounds = true

        
       
        let blur = AddBlur(toView: containerView, blurStyle: .dark)

        containerView.alpha = 0.4
        containerView.addSubview(blur)
        
        
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            //containerView.topAnchor.constraint(equalTo: sectionStickyView.topAnchor, constant: 25),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            //containerView.bottomAnchor.constraint(equalTo: sectionStickyView.bottomAnchor,constant: -10)
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
            
            sectionLabel.textColor = .white
            sectionLabel.text = ""
            sectionLabel.font = UIFont.boldSystemFont(ofSize: 14)
            sectionLabel.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(sectionLabel)
            
            // Add constraints to position the sectionLabel within the headerView
            NSLayoutConstraint.activate([
                sectionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
                sectionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
                sectionLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
                sectionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
            ])
            
            
            //sectionStickyView.transform = CGAffineTransform(scaleX: 1, y: -1)
            
//            return sectionStickyView
    }
}
