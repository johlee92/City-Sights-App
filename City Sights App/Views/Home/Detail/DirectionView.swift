//
//  DirectionView.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/27/22.
//

import SwiftUI

struct DirectionView: View {
    
    var business: Business
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                BusinessTitle(business: business)
                
                Spacer()
                
                if let lat = business.coordinates?.latitude,
                   let long = business.coordinates?.longitude,
                   let name = business.name?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                
                    Link("Open in Maps", destination: URL(string: "http://maps.apple.com/?ll=\(lat),\(long)&q=\(name)")!)
                }
            }
            .padding()
            
            DirectionsMap(business: business)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

//struct DirectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        DirectionView()
//    }
//}
