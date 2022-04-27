//
//  ContentModel.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/25/22.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var sights = [Business]()
    @Published var restaurants = [Business]()
    
    var locationManager = CLLocationManager()
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    
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
        
        authorizationState = locationManager.authorizationStatus
        
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
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            
            // Stop requesting location after data received
            locationManager.stopUpdatingLocation()
        }
    }
    
    func getBusinesses(category:String, location:CLLocation) {
        // Create URL
//        let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&limit=6&categories=\(category)"
//        let url = URL(string: urlString)
        
        var urlComponents = URLComponents(string: Constants.apiUrl)
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
            request.addValue(Constants.apiKey, forHTTPHeaderField: "Authorization")
            
        // Get URL session
            let session = URLSession.shared
        
        // Create Data Task
            let dataTask = session.dataTask(with: request) { data, response, error in
                if error == nil {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let modelData = try decoder.decode(BusinessSearch.self, from: data!)
//                        self.businessSearch = modelData
//                        print(modelData)
                        
                        // Sort businesses so the closest ones show up first
                        var businesses =  modelData.businesses
                        businesses.sort { b1, b2 in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        for b in businesses {
                            b.getImageData()
                        }
                        
                        DispatchQueue.main.async {
                            
                            // consider changing to switch to make easier for cases
                            if category == Constants.sightsKey {
                                self.sights = businesses
                            } else if category == Constants.restaurantsKey {
                                self.restaurants = businesses
                            }
                        }
                        
                    } catch {
                        print(error)
                    }
                }
            }
        
        // Start Data Task
            dataTask.resume()
        }
    }
    
}
