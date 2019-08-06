//
//  APIService.swift
//  CityMapApp
//
//  Created by Masoud Soleimani on 2019-08-05.
//  Copyright © 2019 Mas One. All rights reserved.
//

import Foundation

class APIService {
    
    typealias WebServiceCompletionBlock = (_ data: Data?,_ error: Error?)->Void
    typealias ParsedCompletionBlock = (_ data: AnyObject?,_ error: Error?)->Void
    
    private let cityURL = "https://s3-eu-west-1.amazonaws.com/uploads-eu.hipchat.com/128845/1765144/LqgK6ORrJR4VZ1G/cities.json"
    
    func fetchCities(complete: @escaping ParsedCompletionBlock) {
        requestAPI(url: cityURL){ (data, error) in
            guard let data = data else{
                complete(nil,error)
                return
            }
            
            do {
                let parsedJson = try self.parseJson(CityModel.self, from: data)
                complete(parsedJson as AnyObject,error)
            } catch let error {
                print(error.localizedDescription)
                complete(nil,error)
            }
        }
    }
    
    func requestAPI(url: String, completion: @escaping WebServiceCompletionBlock) {
        
        let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        var request = URLRequest(url: URL(string: escapedAddress)!)
//        request.addValue(WebServiceConstants.kAPIKEY, forHTTPHeaderField: "Authorization")
//        request.addValue("application/xml", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let task = URLSession.shared.downloadTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                print("Error in fetching response",error ?? "")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("Error in fetching response")
                completion(nil, error)
            }
            
//            completion(data,error)
            
        }
        task.resume()
        
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
