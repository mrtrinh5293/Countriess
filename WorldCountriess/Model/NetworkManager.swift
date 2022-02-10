//
//  NetworkManager.swift
//  WorldCountriess
//
//  Created by Duc Dang on 8/7/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData
import Combine
import SwiftUI

class NetworkManager: ObservableObject {
    @Published var worldData = [WorldData]()
    @Published var allCountries : [CountryLocation] = []
    let url = URL(string: "https://restcountries.eu/rest/v2/all")
    
    typealias Handler = (Result<[WorldData], Error>) -> Void
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    var urlSession: URLSessionProtocol = URLSession.shared
    
    // For testing pratice    
//    static func fetchDataForUnitTest(completion: @escaping ([WorldData]) -> ()) {
//      guard let url = URL(string: "https://restcountries.eu/rest/v2/all") else {
//        return
//      }
////      let task = urlSession.dataTask(with: url) { data, _, error in
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: url) { (data, response, error) in
//        do {
//          guard
//            let data = data,
//            error == nil,
//            let newTarget = try JSONDecoder().decode([WorldData]?.self, from: data)
//          else {
//            return
//          }
//          completion(newTarget)            
//        } catch {
//          print("Decoding of World Country failed.")
//        }
//      }
//      task.resume()
//    }
//
//    static func loadDataFromJSON(completion: @escaping ([WorldData]) ->()) {
//        if let url = URL(string: "https://restcountries.com/v2/all") {
//            let session = URLSession(configuration: .default)
//
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error == nil {
//                    let decoder = JSONDecoder()
//                    if let safeData = data {
//                        do {
//                            let results = try decoder.decode([WorldData].self, from: safeData)
//                            completion(results)
//                        } catch {
//                            print("error: ", error)
//                        }
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//
//    static func loadDataToCD(moc: NSManagedObjectContext) {
//        loadDataFromJSON { (countries) in
//            DispatchQueue.main.async {
//                var tempCountries = [CDCountry]()
//                for country in countries {
//                    let newCountry = CDCountry(context: moc)
//
//                    newCountry.id = Int64(country.id)
//                    newCountry.latlng = country.latlng
//                    newCountry.alpha2Code = country.alpha2Code
//                    newCountry.area =  country.area ?? 0.0
//                    newCountry.capital = country.capital
//                    newCountry.flag = country.flag
//                    newCountry.name = country.name
//                    newCountry.numericCode = country.numericCode
//                    newCountry.population = Int64(country.population)
//                    newCountry.region = country.region
//
//                    tempCountries.append(newCountry)
//                }
//                do {
//                    try moc.save()
//                } catch let error {
//                    print("Could not save to CD: ", error.localizedDescription)
//                }
//            }
//        }
//    }
    
    func getCountryLocation() {
        AF.request("https://restcountries.eu/rest/v2/all").responseJSON { response in
            
            let result = response.value
            if result != nil {
                // Specify result
                let dataDictonary = result as! [Dictionary<String, AnyObject>]
                
                for countryData in dataDictonary
                {
                    let countryName = countryData["name"] as? String ?? "Error"
                    let latlng = countryData["latlng"] as? [Double] ?? [0.0, 0.0]
                    
                    let countryObject = CountryLocation(name: countryName, latlng: latlng)
                    
                    self.allCountries.append(countryObject)
                }                
            }
        }
    }
}

class NetworkManager2: ObservableObject {
    
}
