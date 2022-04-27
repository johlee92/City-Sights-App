//
//  OnboardingView.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/27/22.
//

import SwiftUI
import MapKit

struct OnboardingView: View {
    
    @EnvironmentObject var model: ContentModel
    @State private var tabSelected = 0
    
    private let blue = Color(.sRGB, red: 0/255, green: 134/255, blue: 167/255, opacity: 1)
    private let turquoise = Color(.sRGB, red: 55/255, green: 197/255, blue: 192/255, opacity: 1)
    
    var body: some View {
        VStack {
            // Tab view
            TabView(selection: $tabSelected) {
                // First tab
                VStack {
                    Image("city2")
                        .resizable()
                        .scaledToFit()
                    Text("Welcome to City Sights!")
                        .bold()
                        .font(.title)
                    Text("City Sights helps you find the best of the city!")
                        .multilineTextAlignment(.center)
                }
                .tag(0)
                .foregroundColor(.white)
                
                // Second tab
                VStack {
                    Image("city1")
                        .resizable()
                        .scaledToFit()
                    Text("Ready to discover your city?")
                        .bold()
                        .font(.title)
                    Text("We'll show you the best restaurants, venues, and more, based on your location!")
                        .multilineTextAlignment(.center)
                }
                .tag(1)
                .foregroundColor(.white)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .padding()
            
            Button {
                if tabSelected == 0 {
                    tabSelected = 1
                } else {
                    model.requestGeolocationPermission()
                }
            } label: {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text(tabSelected == 0 ? "Next" : "Get My Location")
                        .bold()
                        .padding()
                }
            }
            .accentColor(tabSelected == 0 ? blue:turquoise)
            .padding()
        }
        .background(tabSelected == 0 ? blue : turquoise)
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
