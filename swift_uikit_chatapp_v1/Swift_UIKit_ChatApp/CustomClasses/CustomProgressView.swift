//
//  CirularIndicator.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 22.7.2023.
//

import UIKit


class CustomProgressView: UIView, CAAnimationDelegate {
    
    let spiningCirculeView = UIView()
    let spiningCircule = CAShapeLayer()
    
    
    
    var progress: CGFloat = 0.0
    
    var circleProgress: CGFloat = 0 {
        didSet {
            spiningCircule.strokeEnd = circleProgress
            
        }
    }
    
    var lineWidth: CGFloat = 0 {
        didSet {
            spiningCircule.lineWidth = lineWidth
            
        }
    }
    
    var isCircling : Bool = false
    
    var isProgressing: Bool = false
    
    
    let sequare = UIView()
    
    
    var strokColor: UIColor = UIColor.systemRed {
        didSet {
            spiningCircule.strokeColor = strokColor.cgColor
            sequare.backgroundColor = strokColor
        }
    }
    var fillColor: UIColor = UIColor.clear {
        didSet {
            spiningCircule.fillColor = fillColor.cgColor
        }
    }
    
    override init(frame: CGRect){
        progress = 0
        lineWidth = 0
        strokColor = .clear
        fillColor = .clear
        isCircling = false
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        progress = 0
        lineWidth = 0
        strokColor = .clear
        fillColor = .clear
        isCircling = false
        super.init(coder: coder)
        configureUI()
    }

//    init(frame: CGRect, lineWidth: CGFloat?) {
//        super.init(frame: frame)
//        configureUI()
//        progress = 0
//        lineWidth = 0
//    }
    
    func configureUI() {
    //        frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let rect = self.bounds
        let circularPath = UIBezierPath(ovalIn: rect)
        
        spiningCircule.path = circularPath.cgPath
        spiningCircule.fillColor = UIColor.clear.cgColor
        spiningCircule.strokeColor = UIColor.systemRed.cgColor
        spiningCircule.lineWidth = lineWidth
        spiningCircule.strokeEnd = circleProgress
        spiningCircule.lineCap = .round
        
        
        
        
        
        sequare.translatesAutoresizingMaskIntoConstraints = false
        sequare.layer.cornerRadius = 2
        sequare.clipsToBounds = true
        self.addSubview(sequare)
        self.addSubview(spiningCirculeView)
        
        spiningCirculeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sequare.widthAnchor.constraint(equalToConstant: 10),
            sequare.heightAnchor.constraint(equalToConstant: 10),
            sequare.centerXAnchor.constraint(equalTo: centerXAnchor),
            sequare.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            spiningCirculeView.leadingAnchor.constraint(equalTo: leadingAnchor),
            spiningCirculeView.trailingAnchor.constraint(equalTo: trailingAnchor),
            spiningCirculeView.topAnchor.constraint(equalTo: topAnchor),
            spiningCirculeView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
        
        
        
        
        spiningCirculeView.layer.addSublayer(spiningCircule)
        
    //        self.backgroundColor = .blue
    }
    

    
    func setProgressValue(fromValue: Float? = nil, toValue: Float, animated: Bool) {

            
            isProgressing = true
            // Create a CABasicAnimation for strokeEnd property
            let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
            if let fromValue = fromValue {
                strokeEndAnimation.fromValue = fromValue
            } else {
                strokeEndAnimation.fromValue = progress
            }
        
            strokeEndAnimation.toValue = toValue
            
            strokeEndAnimation.duration = 0.5 // The duration for one full rotation
        
            // Set animation properties to make it circular
            strokeEndAnimation.repeatCount = .zero
            strokeEndAnimation.fillMode = .forwards
            strokeEndAnimation.isRemovedOnCompletion = false
        
            // Add the animation to the spiningCircule layer
            spiningCircule.add(strokeEndAnimation, forKey: "strokeAnimation")
            progress = CGFloat(toValue)

        
        
    }
    
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            isProgressing = false
        }
    }
    
    
    func startCircling() {
    
        isCircling = true
        // Create a CABasicAnimation for transform.rotation property
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = CGFloat.pi * 2 // Full rotation (360 degrees)
    
        let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        rotationAnimation.timingFunction = timingFunction
    
        rotationAnimation.duration = 1.2 // The duration for one full rotation
    
        // Set animation properties to make it circular
        rotationAnimation.repeatCount = .infinity
        rotationAnimation.fillMode = .forwards
        rotationAnimation.isRemovedOnCompletion = false
    
        // Add the animation to the spiningCircule layer
        //spiningCircule.add(rotationAnimation, forKey: "rotationAnimation")
        spiningCirculeView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    
    func stopCircling() {
        // Check if there's a running animation
//        if let _ = spiningCirculeView.layer.animation(forKey: "rotationAnimation") {
//            // Pause the animation and save its current state
//            let pausedTime = spiningCirculeView.layer.convertTime(CACurrentMediaTime(), from: nil)
//            self.layer.speed = 0.0
//            self.layer.timeOffset = pausedTime
//        }
        spiningCirculeView.layer.removeAnimation(forKey: "rotationAnimation")
        isCircling = false
    }
    
    
}



//    func setProgressValue(toValue: Float) {
//        // Create a CABasicAnimation for strokeEnd property
//        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        strokeEndAnimation.fromValue = 0.0
//        strokeEndAnimation.toValue = 1.0
//        //strokeEndAnimation.duration = 1.0 // The duration for one full rotation
//
//        // Set animation properties to make it circular
//        strokeEndAnimation.repeatCount = .infinity
//        strokeEndAnimation.fillMode = .forwards
//        strokeEndAnimation.isRemovedOnCompletion = false
//
//        // Add the animation to the spiningCircule layer
//        spiningCircule.add(strokeEndAnimation, forKey: "strokeAnimation")
//    }

//    func startCircling() {
//        // Create a CABasicAnimation for transform.rotation property
//        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
//        rotationAnimation.fromValue = 0.0
//        rotationAnimation.toValue = CGFloat.pi * 2 // Full rotation (360 degrees)
//
//        let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//        rotationAnimation.timingFunction = timingFunction
//
//        rotationAnimation.duration = 1.2 // The duration for one full rotation
//
//        // Set animation properties to make it circular
//        rotationAnimation.repeatCount = .infinity
//        rotationAnimation.fillMode = .forwards
//        rotationAnimation.isRemovedOnCompletion = false
//
//        // Add the animation to the spiningCircule layer
//        //spiningCircule.add(rotationAnimation, forKey: "rotationAnimation")
//        self.layer.add(rotationAnimation, forKey: "rotationAnimation")
//    }


//let spiningCircule = CAShapeLayer()
//
//var progress: Float = 0.0
//var lineWidth: CGFloat = 0
//var strokColor: CGColor = UIColor.systemRed.cgColor
//var fillColor: CGColor?
//var trackColor: CGColor = UIColor.systemGray2.cgColor
//
//override init(frame: CGRect){
//    progress = 0
//    lineWidth = 0
//    super.init(frame: frame)
//    configureUI()
//}
//
//required init?(coder: NSCoder) {
//    progress = 0
//    lineWidth = 0
//    super.init(coder: coder)
//    configureUI()
//}
//
//init(frame: CGRect, lineWidth: CGFloat?) {
//    super.init(frame: frame)
//    configureUI()
//}
//
////    required init?(coder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
////    }
//
//func configureUI() {
////        frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//    let rect = self.bounds
//    let circularPath = UIBezierPath(ovalIn: rect)
//
//    spiningCircule.path = circularPath.cgPath
////        spiningCircule.fillColor = fillColor != nil ? fillColor : UIColor.clear.cgColor
//    spiningCircule.fillColor =  UIColor.clear.cgColor
////        spiningCircule.strokeColor = strokColor
//    spiningCircule.strokeColor = UIColor.systemRed.cgColor
////        spiningCircule.trackColor = trackColor
////        spiningCircule.lineWidth = lineWidth
//    spiningCircule.lineWidth = 3
//    spiningCircule.strokeEnd = 0.7
//
//    spiningCircule.lineCap = .round
//
//    self.layer.addSublayer(spiningCircule)
////        setProgressValue(fromValue: 0.0, toValue: progress, animated: true)
////        self.backgroundColor = .blue
//}
//
//
//func setProgressValue(fromValue: Float? = nil, toValue: Float, animated: Bool) {
//    // Create a CABasicAnimation for strokeEnd property
//    let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
//    if let fromValue = fromValue {
//        strokeEndAnimation.fromValue = fromValue
//    } else {
//        strokeEndAnimation.fromValue = progress
//    }
//
//    strokeEndAnimation.toValue = toValue
//    strokeEndAnimation.duration = animated ? 0.2 : 0.0 // The duration for one full rotation
//
//    // Set animation properties to make it circular
//    strokeEndAnimation.repeatCount = .zero
//    strokeEndAnimation.fillMode = .forwards
//    strokeEndAnimation.isRemovedOnCompletion = false
//
//    // Add the animation to the spiningCircule layer
//    spiningCircule.add(strokeEndAnimation, forKey: "strokeAnimation")
//}
//
//func startCircling() {
//
//
//    // Create a CABasicAnimation for transform.rotation property
//    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
//    rotationAnimation.fromValue = 0.0
//    rotationAnimation.toValue = CGFloat.pi * 2 // Full rotation (360 degrees)
//
//    let timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
//    rotationAnimation.timingFunction = timingFunction
//
//    rotationAnimation.duration = 1.2 // The duration for one full rotation
//
//    // Set animation properties to make it circular
//    rotationAnimation.repeatCount = .infinity
//    rotationAnimation.fillMode = .forwards
//    rotationAnimation.isRemovedOnCompletion = false
//
//    // Add the animation to the spiningCircule layer
//    //spiningCircule.add(rotationAnimation, forKey: "rotationAnimation")
//    self.layer.add(rotationAnimation, forKey: "rotationAnimation")
//}
//
//func stopCircling() {
//    // Check if there's a running animation
//    if let _ = self.layer.animation(forKey: "rotationAnimation") {
//        // Pause the animation and save its current state
//        let pausedTime = self.layer.convertTime(CACurrentMediaTime(), from: nil)
//        self.layer.speed = 0.0
//        self.layer.timeOffset = pausedTime
//    }
//}
