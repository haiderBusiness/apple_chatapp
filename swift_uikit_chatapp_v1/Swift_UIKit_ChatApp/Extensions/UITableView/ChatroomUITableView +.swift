//
//  ChatroomUITableView +.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 23.9.2023.
//

import UIKit


extension UIContextMenuInteraction {
    
    func locationInCoordinateSpace(point: CGPoint, in coordinateSpace: UICoordinateSpace) -> CGPoint {
        guard let view = self.view else { return point }
        
        // Get the frame of the view in the coordinate space
        let frameInCoordinateSpace = coordinateSpace.convert(view.bounds, from: view)
        
        // Calculate the bottom-right point
        let bottomRightPoint = CGPoint(x: frameInCoordinateSpace.maxX, y: frameInCoordinateSpace.maxY)
        
        return bottomRightPoint
    }
    
}

//extension UITableView {
//
//    override open func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
//
//        let newLocation = interaction.locationInCoordinateSpace(point: location, in: self)
//        return super.contextMenuInteraction(interaction, configurationForMenuAtLocation: newLocation)
//
//    }
//
//}
