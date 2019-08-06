//
//  CityMapView.swift
//  CityMapApp
//
//  Created by Masoud Soleimani on 2019-08-05.
//  Copyright © 2019 Mas One. All rights reserved.
//

import UIKit
import MapKit

class CityMapViewController: UIViewController {
    
    @IBOutlet weak var cityMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewModel = ViewModel.shared
        let city = viewModel.getCity(at: viewModel.selectedCity)
        
        title = city.name
        
        guard let lat = city.lat, let lon = city.lon else {
            return
        }
        
        let coord = CLLocationCoordinate2DMake(lat,lon)
        
        var mapRegion = MKCoordinateRegion()
        mapRegion.center = coord
        mapRegion.span.latitudeDelta = 1.2
        mapRegion.span.longitudeDelta = 1.2
        cityMapView.setRegion(mapRegion, animated: true)
        let annotation = MKPointAnnotation()
        annotation.title = city.name
        annotation.coordinate = coord
        cityMapView.addAnnotation(annotation)
    }
}
