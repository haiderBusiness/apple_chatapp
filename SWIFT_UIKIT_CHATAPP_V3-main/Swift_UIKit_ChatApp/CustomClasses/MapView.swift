//
//  ChatroomCellMap.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 7.7.2023.
//

import UIKit
import MapKit

class MapView: MKMapView {
    
    private let locationPin = MKPointAnnotation()
    
    var storedRegion: MKCoordinateRegion!
    
    
        
        override init(frame: CGRect) {
//            locationPin = MKPointAnnotation()
            super.init(frame: frame)
            addAnnotation(locationPin)
        }
        
        required init?(coder aDecoder: NSCoder) {
//            locationPin = MKPointAnnotation()
            super.init(coder: aDecoder)
            addAnnotation(locationPin)
        }
    
    
    func snapshotMap(location: Coordinates) -> UIView {
        
        setMapLocation(location: location)
        centerMap()
        
        if let snapshot =  self.snapshotView(afterScreenUpdates: true) {
            return snapshot
        }
        
        return UIView()
    }
    
    
       
        
    
        func centerMap() {
                        
            // Set the map's region and center
           storedRegion = MKCoordinateRegion(center: locationPin.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
           setRegion(storedRegion, animated: false)
            
            // Add a map annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = locationPin.coordinate
           addAnnotation(annotation)
        }
    
    
        func setMapLocation(location: Coordinates) {
            locationPin.coordinate = CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            )
        }
        
        func unSetMapLocation() {
            locationPin.coordinate = CLLocationCoordinate2D()
        }
    


    
    func generateMapSnapshot(location: Coordinates, completion: @escaping (UIImage?) -> Void) {
            let options = MKMapSnapshotter.Options()
            options.region = storedRegion
//            options.size = frame.size
            
            let snapshotter = MKMapSnapshotter(options: options)
            snapshotter.start { snapshot, error in
                if let error = error {
                    print("Error generating map snapshot: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                let snapshotter = MKMapSnapshotter(options: options)
                       snapshotter.start { snapshot, error in
                           if let error = error {
                               print("Error generating map snapshot: \(error.localizedDescription)")
                               completion(nil)
                               return
                           }

                           if let snapshotImage = snapshot?.image {
                               // Call the completion handler with the generated snapshotImage
                               completion(snapshotImage)
                           } else {
                               completion(nil)
                           }
                       }
            }

//                if let snapshotImage = snapshot?.image {
//
//                    let image = snapshotImage
//                            var locationPin = MKPointAnnotation()
//                            locationPin.coordinate = CLLocationCoordinate2D(
//                                latitude: location.latitude,
//                                longitude: location.longitude
//                            )
//                            locationPin.title = "Your Title"
//
//                            let annotationView = CustomAnnotationView(annotation: locationPin, reuseIdentifier: "locationPin")
//                            let pinImage = annotationView.image
//
//                            UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale);
//
//                            image.draw(at: CGPointMake(0, 0)) //map
//
//                    //            pinImage!.drawAtPoint(snapshot.pointForCoordinate(coordinates[0]))
//
//                    annotationView.drawViewHierarchyInRect(CGRectMake(snapshot.pointForCoordinate(locationPin.coordinate).x, snapshot.pointForCoordinate(locationPin.coordinate).y, annotationView.frame.size.width, annotationView.frame.size.height), afterScreenUpdates: true)
//
//
//                            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
//                            UIGraphicsEndImageContext()
//                            completion(finalImage)
//                } else {
//                    completion(nil)
//                }
//            }
    }
 
}
