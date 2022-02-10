//
//  WorldCountriessTests.swift
//  WorldCountriessTests
//
//  Created by duc on 2021-06-14.
//  Copyright © 2021 Duc Dang. All rights reserved.
//

import XCTest
@testable import WorldCountriess

class WorldCountriessTests: XCTestCase {
    var sut: APIService!
    let url = URL(string: "https://restcountries.com/v2/all")!
    var urlSession: URLSession!
    
    
    override func setUpWithError() throws {
        //        try super.setUpWithError()
        sut = APIService()
        // Set url session for mock networking
//        let configuration = URLSessionConfiguration.ephemeral
//        configuration.protocolClasses = [MockURLProtocol.self]
//        urlSession = URLSession(configuration: configuration)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testSuccessParser() {
        let json = """
                {
                "result": [
                {
                "name": "Afghanistan",
                "numericCode: "",
                "alpha2Code": "",
                "capital": "",
                "region": "",
                "population": 12,
                "area": 12.2,
                "altSpellings": ["VN"],
                "timezones": ["GMT"],
                "latlng": [12.2],
                "currencies": [Currency.init("code": "String", "name": "", "symbol": "")],
                "languages": [Language.init("name": "vn")], "flag": "", "callingCodes": [""]
                }
                ]
                }
                """.data(using: .utf8)
        
        let countries = try! JSONDecoder().decode(CountryList.self, from: json!)
        
        XCTAssertNotNil(countries)
        APIService.fetchDataFromJSON { name in
            XCTAssertEqual(name[0].name, countries.result.first?.name)
        }
    }
    
    func testSuccessfulFetchData() {
        let expectedList = [WorldData.with()]
        let service = MockService(mockData: expectedList)
        
        let viewModel = CountriesViewModel(service: service)
        viewModel.loadData()
        
        XCTAssertTrue(!viewModel.loading)
        XCTAssertEqual(viewModel.countries.result.count, 1)
    }
    
    func testEmptyData() {
      let expectedList = [WorldData]()
      let service = MockService(mockData: expectedList)
      
      let viewModel = CountriesViewModel(service: service)
      
      
      viewModel.loadData()
      
      XCTAssertTrue(!viewModel.loading)
      XCTAssertEqual(viewModel.countries.result.count, 0)
     }
     
     func testNilData() {
      let expectedList: [WorldData]? = nil
      let service = MockService(mockData: expectedList)
      
      let viewModel = CountriesViewModel(service: service)
      
      
      viewModel.loadData()
      
      XCTAssertTrue(!viewModel.loading)
      XCTAssertEqual(viewModel.countries.result.count, 0)
     }
    
    
    
//    func testNetworkRequest() throws {
//        //            let countryAPi = NetworkManager(session: urlSession, decoder: decoder)
//
//        let sampleCountryData = WorldData(name: "Vietnam", numericCode: "", alpha2Code: "", capital: "", region: "", population: 12, area: 12.2, altSpellings: ["VN"], timezones: ["GMT"], latlng: [12.2], currencies: [Currency.init(code: "String", name: "", symbol: "")], languages: [Language.init(name: "vn")], flag: "", callingCodes: [""])
//
//        let mockData = try JSONEncoder().encode(sampleCountryData)
//
//        MockURLProtocol.requestHandler = { request in
//            return (HTTPURLResponse(), mockData)
//        }
//
//        let expectation = expectation(description: "Completion handler invoked")
//
//
//        APIService.fetchDataFromJSON { name in
//            XCTAssertEqual(name[0].name, "Afghanistan")
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 1)
//    }
//
//    func testCheckDataDownloadFromApiRequest() {
//        let expectation = XCTestExpectation(description: "Fetching API from restCountries")
//        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
//
//            // Make sure we downloaded some data.
//            XCTAssertNotNil(data, "No data was downloaded.")
//            // Fulfill the expectation to indicate that the background task has finished successfully.
//            expectation.fulfill()
//        }
//
//        // Start the download task.
//        dataTask.resume()
//
//        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
//        wait(for: [expectation], timeout: 10.0)
//    }
//
    func testNetworkData_WhenGivenValidData_ReturnSuccesss() {
        let expectation = expectation(description: "Completion handler invoked")

        // when
        APIService.fetchDataFromJSON { data in
            XCTAssertEqual(data[0].name, "Afghanistan")
            expectation.fulfill()
        }
        wait(for:[expectation], timeout: 5)
    }
}
