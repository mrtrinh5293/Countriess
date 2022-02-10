//
//  ServiceProtocol.swift
//  WorldCountriess
//
//  Created by duc on 2022-02-09.
//  Copyright © 2022 Duc Dang. All rights reserved.
//

import Foundation
import CoreData

class APIService : ServiceProtocol {
    func fetchCountries(completion: @escaping ([WorldData]?) -> Void) {
        APIService.fetchDataFromJSON(completion: completion)
    }
    
    static func fetchDataFromJSON(completion: @escaping ([WorldData]) ->()) {
        if let url = URL(string: "https://restcountries.com/v2/all") {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode([WorldData].self, from: safeData)
                            completion(results)
                        } catch {
                            print("error: ", error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    static func loadDataToCD(moc: NSManagedObjectContext) {
        fetchDataFromJSON { (countries) in
            DispatchQueue.main.async {
                var tempCountries = [CDCountry]()
                for country in countries {
                    let newCountry = CDCountry(context: moc)
                    
                    newCountry.id = Int64(country.id)
                    newCountry.latlng = country.latlng
                    newCountry.alpha2Code = country.alpha2Code
                    newCountry.area =  country.area ?? 0.0
                    newCountry.capital = country.capital
                    newCountry.flag = country.flag
                    newCountry.name = country.name
                    newCountry.numericCode = country.numericCode
                    newCountry.population = Int64(country.population)
                    newCountry.region = country.region
                    
                    tempCountries.append(newCountry)
                }
                do {
                    try moc.save()
                } catch let error {
                    print("Could not save to CD: ", error.localizedDescription)
                }
            }
        }
    }
    
}

