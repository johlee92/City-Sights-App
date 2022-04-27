//
//  HomeView.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/26/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    // Default view is list view
    @State var isMapShowing = false
    
    var body: some View {
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            if !isMapShowing {
                // Show list
                VStack (alignment: .leading) {
                    HStack {
                        Image(systemName: "location")
                        Text("City")
                        Spacer()
                        Text("Switch to Map")
                    }
                    Divider()
                    BusinessList()
                }
                .padding()
            } else {
                // Show map
            }
            
        } else {
            // Show progress view when no data
            ProgressView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
