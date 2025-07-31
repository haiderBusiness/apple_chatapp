//
//  CirclesLine.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 1.9.2023.
//

import UIKit

class CircleLineView: UIView {
    
    var fillColor: UIColor = .blue
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Define circle parameters
        let circleRadius: CGFloat = 2
        let circleSpacing: CGFloat = 2
        
        // Calculate the number of circles that fit in the screen width
        let numberOfCircles = Int((rect.width - circleRadius * 2) / (circleRadius * 2 + circleSpacing))
        
        // Calculate the starting point for the line of circles
        let startY = rect.height / 2
        

        
        // Loop through and draw filled circles
        for i in 0..<numberOfCircles {
            let centerX = circleRadius + CGFloat(i) * (circleSpacing + circleRadius * 2)
            let center = CGPoint(x: centerX, y: startY)
            let circlePath = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            
            // Set the fill color and fill the circle
            fillColor.setFill()
            circlePath.fill()
        }
    }
}
