//
//  LocationDeniedView.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/27/22.
//

import SwiftUI

struct LocationDeniedView: View {
    
    let backgroundColor = Color(.sRGB, red: 34/255, green: 141/255, blue: 138/255, opacity: 1)
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Whoops!")
                .font(.title)
                .foregroundColor(.white)
            
            Text("We need to access your location to provide you with the best sights in the neighborhood, change your decision at any time in Settings.")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding()
            
            Spacer()
            
            Button {
                // Open settings by getting the settings url
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
            } label: {
                
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text("Go to Settings")
                        .bold()
                        .foregroundColor(backgroundColor)
                }
            }
            .padding()

            Spacer()
            
        }
        .background(backgroundColor)
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
