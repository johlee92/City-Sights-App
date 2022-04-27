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
    @State var selectedBusiness:Business?
    
    var body: some View {
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            // Putting navigation view here to change this entire view when detail is selected
            NavigationView {
            
                if !isMapShowing {
                    // Show list
                    VStack (alignment: .leading) {
                        HStack {
                            Image(systemName: "location")
                            Text(model.placemark?.locality ?? "")
                            Spacer()
                            Button {
                                self.isMapShowing = true
                            } label: {
                                Text("Switch to Map")
                            }
                        }
                        
                        Divider()
                        
                        ZStack (alignment: .top) {
                            BusinessList()
                            
                            HStack {
                                Spacer()
                                YelpAttribution(link: "https://yelp.com")
                            }
                            .padding(.trailing, -20)
                        }
                    }
                    .padding()
                    .navigationBarHidden(true)
                } else {
                    
                    ZStack (alignment: .top) {
                        // Show map
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness, content: {
                                business in
                                BusinessDetail(business: business)
                            })
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .frame(height: 48)
                            
                            HStack {
                                Image(systemName: "location")
                                Text(model.placemark?.locality ?? "")
                                Spacer()
                                Button {
                                    self.isMapShowing = false
                                } label: {
                                    Text("Switch to List View")
                                }
                            }
                            .padding()
                        }
                        .padding()
                        .navigationBarHidden(true)
                    }
                }
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
