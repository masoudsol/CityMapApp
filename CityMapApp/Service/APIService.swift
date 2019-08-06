//
//  APIService.swift
//  CityMapApp
//
//  Created by Masoud Soleimani on 2019-08-05.
//  Copyright © 2019 Mas One. All rights reserved.
//

import Foundation

class APIService {
    
    typealias WebServiceCompletionBlock = (_ data: AnyObject?,_ error: Error?)->Void
    
    func fetchCities(complete: @escaping WebServiceCompletionBlock) {
        requestAPI { (data, error) in
            guard let data = data as? Data else{
                complete(nil,error)
                return
            }
            
            do {
                let parsedJson = try self.parseJson([USCity].self, from: data)
                complete(parsedJson as AnyObject,error)
            } catch let error {
                print(error.localizedDescription)
                complete(nil,error)
            }
        }
    }
    
    func requestAPI(completion: @escaping WebServiceCompletionBlock) {
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completion(data as AnyObject, nil)
            } catch let error{
                completion(nil, error)
            }
        }
    }
    
    func parseJson<T>(_ type: T.Type, from data: Data)  throws -> T? where T : Decodable {
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(type.self, from: data)
            return model
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
