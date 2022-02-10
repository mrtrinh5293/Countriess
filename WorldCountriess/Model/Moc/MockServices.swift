//
//  MockServices.swift
//  WorldCountriess
//
//  Created by duc on 2022-02-10.
//  Copyright © 2022 Duc Dang. All rights reserved.
//

import Foundation

class MockService: ServiceProtocol {
    let mockData: [WorldData]?
    
    init(mockData: [WorldData]?) {
        self.mockData = mockData
    }
    
    func fetchCountries(completion: @escaping ([WorldData]?) -> Void) {
        completion(mockData)
    }
    
}

extension WorldData {
    static func with(name: String = "Vietnam",
        numericCode: String = "",
        alpha2Code: String = "",
        capital: String = "",
        region: String = "",
        population: Int = 12,
        area: Double = 12.2,
        altSpellings: [String] = ["VN"],
        timezones: [String] = ["GMT"],
        latlng: [Double] = [12.2],
        currencies:[Currency] = [Currency.init(code: "String", name: "", symbol: "")],
        languages:[Language] = [Language.init(name: "vn")],
        flag: String = "",
        callingCodes:[String] = [""]) -> WorldData {
    return WorldData(name: name, numericCode: numericCode, alpha2Code: alpha2Code, capital: capital, region: region, population: population, area: area, altSpellings: altSpellings, timezones: timezones, latlng: latlng, currencies: currencies, languages: languages, flag: flag, callingCodes: callingCodes)
    }
}
