//
//  Restaurant .swift
//  CityMapApp
//
//  Created by Masoud Soleimani on 2019-08-05.
//  Copyright © 2019 Mas One. All rights reserved.
//

import Foundation

struct CityModel: Codable {
    
    let cities: [City]?
}

struct City: Codable {
    let country: String
    let _id: String?
    let name: String
    let coort: Coordinates?
}

struct Coordinates: Codable {
    let lat: Double?
    let lon: Double?
}
