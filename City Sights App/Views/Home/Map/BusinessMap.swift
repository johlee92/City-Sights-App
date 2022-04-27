//
//  BusinessMap.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/27/22.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    
    var locations:[MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        // Create a set of annotations from list of businesses
        
        for business in model.restaurants + model.sights {
            
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
            
                // Create new point annotation
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                annotations.append(a)
        
            }
        }
        
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
        
        // Make the user show up on the amp
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        
        // May need to set region if not using dynamic zooming (e.g., showAnnotations with animated true)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // Remove all annotations
        uiView.removeAnnotations(uiView.annotations)
        
        // Add the ones that are relevant, but doesn't zoom
//        uiView.addAnnotations(self.locations)
        
        // Does what add annotations does but zooms
        uiView.showAnnotations(self.locations, animated: true)
        
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        
        uiView.removeAnnotations(uiView.annotations)
    }
}
