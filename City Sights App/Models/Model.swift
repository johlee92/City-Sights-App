//
//  Model.swift
//  City Sights App
//
//  Created by Johnathan Lee on 4/26/22.
//

import Foundation

class Business: Identifiable, Decodable, ObservableObject {
    
    // Not part of codingkeys so won't be decoded
    @Published var imageData: Data?
    
    var id:String?
    var alias:String?
    var name:String?
    var imageUrl:String?
    var isClosed:Bool?
    var url:String?
    var reviewCount:Int?
    var categories: [Category]?
    var rating:Double?
    var coordinates:Coordinate?
    var transactions:[String]?
    var price:String?
    var location:Location?
    var phone:String?
    var displayPhone:String?
    var distance:Double?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case isClosed = "is_closed"
        case reviewCount = "review_count"
        case displayPhone = "display_phone"
        
        case id
        case alias
        case name
        case url
        case categories
        case rating
        case coordinates
        case transactions
        case price
        case location
        case phone
        case distance
    }
    
    func getImageData() {
        // Check image URL isn't nil
        guard imageUrl != nil else {
            return
        }
        // Download image
        if let url = URL(string: imageUrl!) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    
                    DispatchQueue.main.async {
                        self.imageData = data!
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    static func getTestData() -> Business {
        
        // TO DO: need real test data
        let b = Business()
        
        b.id = "tRiDMqAxeBERRvuyYPZ-aw"
        b.alias = "dishdash-sunnyvale"
        b.name = "DishDash"
        b.imageUrl = "https://s3-media2.fl.yelpcdn.com/bphoto/NfeFZQXrvH5r051M3Lr3uA/o.jpg"
        b.isClosed = false
        b.url = "https://www.yelp.com/biz/dishdash-sunnyvale?adjust_creative=z4qmun-AgTPhSSZvbt4SeQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=z4qmun-AgTPhSSZvbt4SeQ"
        b.reviewCount = 4125
        b.categories = [Category(alias: "mideastern", title: "Middle Eastern"),Category(alias: "mediterranean", title: "Mediterranean")]
        b.rating = 4.5
        b.coordinates = Coordinate(latitude: 37.376194, longitude: -122.030146)
        b.transactions = ["Delivery"]
        b.price = "$$"
        b.location = Location(address1: "190 S Murphy Ave", address2: "", address3: "", city: "Sunnyvale", zipCode: "94086", country: "US", state: "CA", displayAddress: ["190 S Murphy Ave", "Sunnyvale, CA 94086"])
        b.phone = "+14087741889"
        b.displayPhone = "(408) 774-1889"
        b.distance = 6279.247612191038
        
        return b
    }
}

struct Category: Decodable {
    var alias:String?
    var title:String?
}

struct Coordinate: Decodable {
    var latitude: Double?
    var longitude: Double?
}

struct Location: Decodable {
    var address1:String?
    var address2:String?
    var address3:String?
    var city:String?
    var zipCode:String?
    var country:String?
    var state:String?
    var displayAddress:[String]?

    enum CodingKeys: String, CodingKey {
        case zipCode = "zip_code"
        case displayAddress = "display_address"
        
        case address1
        case address2
        case address3
        case city
        case country
        case state
    }
}
