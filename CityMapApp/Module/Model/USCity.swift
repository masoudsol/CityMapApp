//
//  NewCityModel.swift
//  CityMapApp
//
//  Created by Masoud Soleimani on 2019-08-06.
//  Copyright © 2019 Mas One. All rights reserved.
//

import Foundation

struct USCity: Codable {
    
    let city: String
    let growth_from_2000_to_2013: String?
    let latitude: Double?
    let longitude : Double?
    let population: String?
    let rank: String?
    let state: String
}
