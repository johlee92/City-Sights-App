//
//  BusinessTitle.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/27/22.
//

import SwiftUI

struct BusinessTitle: View {
    
    var business: Business
    
    var body: some View {
        VStack (alignment:.leading) {
            Text(business.name!)
                .font(.largeTitle)
            
            if business.location?.displayAddress != nil {
                ForEach(business.location!.displayAddress!, id:\.self) {
                    content in
                    Text(content)
                }
            }
            
            Image("regular_\(business.rating!)")
        }
        .accentColor(.black)
    }
}

//struct BusinessTitle_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessTitle()
//    }
//}
