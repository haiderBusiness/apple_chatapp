//
//  MapSnapShot.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 27.7.2023.
//

import Foundation
import MapKit

// Function to generate the map snapshot using MKMapSnapshotter.
func generateMapSnapshot(location: Coordinates, completion: @escaping (UIImage?) -> Void) {
       let options = MKMapSnapshotter.Options()
//       options.region = cell.mapView.region
//       options.size = cell.mapView.frame.size

       let snapshotter = MKMapSnapshotter(options: options)
       snapshotter.start { snapshot, error in
           if let error = error {
               print("Error generating map snapshot: \(error.localizedDescription)")
               completion(nil)
               return
           }

           if let snapshotImage = snapshot?.image {
               // Update the image view in the cell with the snapshot image.
                completion(snapshotImage)
           }
       }
   }
