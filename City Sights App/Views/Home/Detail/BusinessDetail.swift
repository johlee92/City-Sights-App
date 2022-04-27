//
//  BusinessDetail.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/27/22.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business: Business
    
    var body: some View {
        VStack (alignment: .leading) {
            
            VStack (alignment: .leading, spacing: 0) {
            
                GeometryReader() {
                    geo in
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                }
                .ignoresSafeArea(.all, edges: .top)
                
                ZStack (alignment: .leading) {
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.horizontal)
                }
            }
            
            Group {
                Text(business.name!)
                    .font(.largeTitle)
                    .padding()
                
                if business.location?.displayAddress != nil {
                    ForEach(business.location!.displayAddress!, id:\.self) {
                        content in
                        Text(content)
                            .padding(.horizontal)
                    }
                }
                
                Image("regular_\(business.rating!)")
                    .padding()
                
                Divider()
                
                HStack {
                    Text("Phone")
                        .bold()
                    
                    Text(business.displayPhone ?? "0")
                    
                    Spacer()
                    
                    // Force unwrapping
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }
                .padding()
                
                Divider()
                
                HStack {
                    Text("Reviews")
                        .bold()
                    
                    Text(String(business.reviewCount ?? 0))
                    
                    Spacer()
                    
                    // Force unwrapping
                    Link("Read", destination: URL(string: business.url ?? " ")!)
                }
                .padding()
                
                Divider()
                
                HStack {
                    Text("Webite:")
                        .bold()
                    
                    Text(business.url ?? "")
                        .lineLimit(1)
                    
                    Spacer()
                    
                    // Force unwrapping
                    Link("Visit", destination: URL(string: business.url ?? " ")!)
                }
                .padding()
                
                Divider()
                
            }
            
            Button {
                
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()
            }

        }

    }
}

struct BusinessDetail_Previews: PreviewProvider {
    static var previews: some View {
        BusinessDetail(business: Business.getTestData())
    }
}
