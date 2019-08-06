//
//  ViewModel.swift
//  CityMapApp
//
//  Created by Masoud Soleimani on 2019-08-05.
//  Copyright © 2019 Mas One. All rights reserved.
//

import Foundation


class ViewModel {
    typealias CityType = (name: String?, country: String?, lon: Double?, lat: Double?)
    
    static let shared = ViewModel()
    
    var reloadTable: ()->() = { }
    var reviewLoaded: ()->() = { }
    var cities = [City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999)), City(country: "UA", _id: "dsadsa", name: "hello", coort: Coordinates(lat: 34.283333, lon: 44.549999))]
    var filteredCities = [City]()
    var searchActive : Bool = false
    var cityCount: Int {
        return searchActive ? filteredCities.count:cities.count
    }
    var selectedCity: Int = 0
    
    private var services = APIService()
    private var ascendingOrder = false
    private init(){}
    
    func fetchCities(keyword: String?, lat: String, long: String){
        services.fetchCities() { (result, error) in
            if let result = result as? CityModel, let cities = result.cities {
                self.cities = cities
                self.reloadTable()
            }
        }
    }
    
    func getCity(at index: Int) -> CityType {
        let city = searchActive ? filteredCities[index]:cities[index]
        
        return (city.name, city.country, city.coort?.lon, city.coort?.lat)
    }
    
    
    
    func filterCity(key: String) {
        filteredCities = cities.filter({ (city) -> Bool in
            let tmp: NSString = city.name as NSString
            let range = tmp.range(of: key, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
    }
    
    func sort(){
        ascendingOrder = !ascendingOrder
        
        cities = cities.sorted {
            if ascendingOrder{
                return $0.name < $1.name
            } else {
                return $0.name > $1.name
            }
        }
        
        reloadTable()
    }
}
