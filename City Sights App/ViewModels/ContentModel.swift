//
//  ContentModel.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/25/22.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    override init() {
        // Run the NSObject's init func (i.e., the super version)
        // Init method of the NSObject
        super.init()
        
        // Set content model as the delegate of the location manager
        locationManager.delegate = self
        
        //Request permission from user for location
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    // MARK - Location Manager Delegate Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            // Start geolocating the user AFTER permission granted
            locationManager.startUpdatingLocation()
        } else if locationManager.authorizationStatus == .denied {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Gives us the location of the user
        print(locations.first ?? "no location")
        
        // Once coordinates received, send to API
        
        // Stop requesting location after data received
        locationManager.stopUpdatingLocation()
        
    }
    
}
