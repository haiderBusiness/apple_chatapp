//
//  AnimateProgramaticConstraintViewController.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 9.6.2023.
//

import UIKit

class AnimateProgramaticConstraintViewController: UIViewController {
    
    var heightConstraint: NSLayoutConstraint!;
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Animate Programatic Constranint"
        
        self.view.backgroundColor = .systemBackground
        createView()
        // Do any additional setup after loading the view.
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        heightConstraint.constant = 500
//        UIView.animate(withDuration: 2) {
//            self.view.layoutIfNeeded()
//        }
//    }
//
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        heightConstraint.constant = 200
//        UIView.animate(withDuration: 2) {
//            self.view.layoutIfNeeded()
//        }
//    }
    
    
    

   
    func createView() {
        let programaticView = UIButton()
        self.view.addSubview(programaticView)
        programaticView.backgroundColor = .red
        programaticView.translatesAutoresizingMaskIntoConstraints = false
        programaticView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        programaticView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        programaticView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightConstraint = programaticView.heightAnchor.constraint(equalToConstant: 200)
        heightConstraint.isActive = true
        
        programaticView.addTarget(self, action: #selector(onPress), for: .touchUpInside)
    }
    
    
    
    @objc func onPress() {
        heightConstraint.constant = 500
        UIView.animate(withDuration: 2) {
            self.view.layoutIfNeeded()
        }
    }

}
