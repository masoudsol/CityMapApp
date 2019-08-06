//
//  CityMapAppTests.swift
//  CityMapAppTests
//
//  Created by Masoud Soleimani on 2019-08-06.
//  Copyright © 2019 Mas One. All rights reserved.
//

import XCTest
@testable import CityMapApp

class CityMapAppTests: XCTestCase {
    
    let service = APIService()
    let viewModel = ViewModel.shared
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJsonDecoder() {
        let expectation = self.expectation(description: "done")
        service.fetchCities { (result, error) in
            if let model = result as? [USCity], model.count>0 {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testSearchFilter() {
        let expectation = self.expectation(description: "json_parsed")

        var usCities = [USCity]()
        service.fetchCities { (result, error) in
            if let model = result as? [USCity], model.count>0 {
                usCities = model
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
        
        viewModel.filterCity(key: "Alb")
        if viewModel.filteredCities.count == 4, viewModel.filteredCities[0].city == "Albany", viewModel.filteredCities[3].city == "Albuquerque", viewModel.filteredCities[0].state == "Georgia", viewModel.filteredCities[3].state == "New Mexico" {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
        
        viewModel.filterCity(key: "Albf")
        
        if viewModel.filteredCities.count == 0 {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
