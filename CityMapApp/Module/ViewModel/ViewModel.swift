//
//  ViewModel.swift
//  CityMapApp
//
//  Created by Masoud Soleimani on 2019-08-05.
//  Copyright © 2019 Mas One. All rights reserved.
//

import Foundation

class ViewModel {
    typealias CityType = (name: String, country: String, lon: Double?, lat: Double?)
    
    static let shared = ViewModel()
    
    var selectedCity: Int = 0
    var cities: [USCity] = []
    var filteredCities = [USCity]()
    var searchActive : Bool = false
    var cityCount: Int {
        return searchActive ? filteredCities.count : cities.count
    }
    
    private var services = APIService()
    
    private init(){
        services.fetchCities { (result, error) in
            guard let result = result as? [USCity], error == nil else {
                return
            }
            
            self.cities = result.sorted(by: {
                return ($0.city == $1.city ? ($0.state < $1.state) : ($0.city < $1.city))
            })
        }
    }
    
    func getCity(at index: Int) -> CityType {
        let city = searchActive ? filteredCities[index]:cities[index]
        
        return (city.city, city.state, city.longitude, city.latitude)
    }
    
    func filterCity(key: String) {
        filteredCities = cities.filter({ (city) -> Bool in
            guard let cityName = city.city as NSString? else {
                return false
            }
            let range = cityName.range(of: key, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound && range.location == 0
        })
    }
}
