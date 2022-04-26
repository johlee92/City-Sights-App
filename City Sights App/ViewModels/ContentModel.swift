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
        // print(locations.first ?? "no location")
        let userLocation = locations.first
        
        if userLocation != nil {
            // Once coordinates received, send to API
            getBusinesses(category: "restaurants", location: userLocation!)
            
            // Stop requesting location after data received
            locationManager.stopUpdatingLocation()
        }
    }
    
    func getBusinesses(category:String, location:CLLocation) {
        // Create URL
//        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&limit=6&categories=\(category)"
//        let url = URL(string: urlString)
        
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
            URLQueryItem(name: "limit", value: "6")
        ]
        let url = urlComponents?.url
        
        if let url = url {
        // Create URL request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            
            request.httpMethod = "GET"
            request.addValue("Bearer 10nAtjh6CvhwkjCWHHAyraxPhNMdvzQaG-9TQyH0mjhE7uz582aQdr0lfozFDyoZXqeyYj9FdCyjKO7FRz_aS3Al9v9iuEKiNQaq5itHr5J-a47yCGNz8Q0JbpBnYnYx", forHTTPHeaderField: "Authorization")
            
        // Get URL session
            let session = URLSession.shared
        
        // Create Data Task
            let dataTask = session.dataTask(with: request) { data, response, error in
                if error == nil {
                    print(response)
                }
            }
        
        // Start Data Task
            dataTask.resume()
        }
    }
    
}
