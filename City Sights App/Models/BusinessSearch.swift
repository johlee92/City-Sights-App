//
//  BusinessSearch.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/26/22.
//

import Foundation

struct BusinessSearch: Decodable {
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region: Decodable {
    var center = Coordinate()
}
