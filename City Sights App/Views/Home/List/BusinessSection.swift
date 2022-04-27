//
//  BusinessSection.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/26/22.
//

import SwiftUI

struct BusinessSection: View {
    
    var businesses:[Business]
    var title:String
    
    var body: some View {
        Section(header: BusinessSectionHeader(title: title)) {
            ForEach(businesses) {
                business in
                Text(business.name ?? "")
                Divider()
            }
        }
    }
}

//struct BusinessSection_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessSection()
//    }
//}
