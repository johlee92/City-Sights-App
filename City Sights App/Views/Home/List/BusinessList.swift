//
//  BusinessList.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/26/22.
//

import SwiftUI

struct BusinessList: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading, pinnedViews: [.sectionHeaders]) {
                
                BusinessSection(businesses: model.restaurants, title: "Restaurants")
                
                BusinessSection(businesses: model.sights, title: "Sights")
            }
        }
    }
}

struct BusinessList_Previews: PreviewProvider {
    static var previews: some View {
        BusinessList()
    }
}
