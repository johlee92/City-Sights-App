//
//  ContentView.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/25/22.
//

import SwiftUI
import CoreLocation

struct LaunchView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        // Detect authorization status of geolocating
        if model.authorizationState == .notDetermined {
            
        } else if model.authorizationState == CLAuthorizationStatus.authorizedAlways || model.authorizationState == CLAuthorizationStatus.authorizedWhenInUse {
            HomeView()
        } else {
            
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
