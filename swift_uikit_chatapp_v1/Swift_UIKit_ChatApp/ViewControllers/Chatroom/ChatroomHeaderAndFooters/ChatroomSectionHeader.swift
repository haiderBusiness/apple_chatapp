//
//  ChatroomSectionHeader.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 27.6.2023.
//

//import UIKit
//
//final class ChatroomSectionHeader: UICollectionReusableView {
//
//    let titleLabel = UILabel()
//
//    override init(frame: CGRect) {
//          super.init(frame: frame)
//          configureUI()
//      }
//
//      required init?(coder aDecoder: NSCoder) {
//          fatalError("init(coder:) has not been implemented")
//      }
//
//
//
//    func configureUI() {
//
//        backgroundColor = .clear
//
//        let containerView = UIView()
//        addSubview(containerView)
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.layer.cornerRadius = 20 * 0.40
//        containerView.clipsToBounds = true
//
//
//
//        let blur = addBlur(toView: containerView, blurStyle: .dark)
//
//        containerView.alpha = 0.4
//        containerView.addSubview(blur)
//
//
//
//        NSLayoutConstraint.activate([
//            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
//            //containerView.topAnchor.constraint(equalTo: sectionView.topAnchor, constant: 25),
//            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//            //containerView.bottomAnchor.constraint(equalTo: sectionView.bottomAnchor,constant: -10)
//            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
//        ])
//
//
//        titleLabel.textColor = .white
//        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(titleLabel)
//
//        NSLayoutConstraint.activate([
//            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
//            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
//            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
//            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
//        ])
//    }
//
//
//
//    func setup(title: String) {
//        titleLabel.text = title
//    }
//
//}
