//
//  BusinessRow.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/26/22.
//

import SwiftUI

struct BusinessRow: View {
    
    @ObservedObject var business:Business
    
    var body: some View {
        VStack {
            HStack {
                
                // AsyncImage way to add images, not formatted
                AsyncImage(url: URL(string: business.imageUrl ?? "")) {
                    image in
                    image
                        .resizable()
                        .frame(width: 58, height: 58)
                        .cornerRadius(5)
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                
//                let uiImage = UIImage(data: business.imageData ?? Data())
//                Image(uiImage: uiImage ?? UIImage())
//                    .resizable()
//                    .frame(width: 58, height: 58)
//                    .cornerRadius(5)
//                    .scaledToFit()
                
                
                VStack (alignment: .leading){
                    Text(business.name ?? "")
                        .bold()
                    
                    Text(String(format:"%.1f km", (business.distance ?? 0)/1000))
                        .font(.caption)
                }
                
                Spacer()
                
                VStack (alignment: .leading) {
                    Image("regular_\(business.rating ?? 0)")
                    
                    Text("\(business.reviewCount ?? 0) Reviews")
                        .font(.caption)
                }
            }
            
            Divider()
        }
    }
}

//struct BusinessRow_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessRow()
//    }
//}
