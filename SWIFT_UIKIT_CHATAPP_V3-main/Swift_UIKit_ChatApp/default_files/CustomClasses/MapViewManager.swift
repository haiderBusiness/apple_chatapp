//
//  MapViewManager.swift
//  Swift_UIKit_ChatApp
//
//  Created by Al-Tameemi Hayder on 6.8.2023.
//

import UIKit
import MapKit

class MapViewManager {

    static let shared = MapViewManager()

    private let mapView: MapView

    private init() {
        mapView = MapView()
    }

    func preloadMapView() {
        // Perform any additional configuration if needed
        // For example, set map region, add annotations, etc.
    }
    

    func getMapView() -> MKMapView {
        return mapView
    }
}
