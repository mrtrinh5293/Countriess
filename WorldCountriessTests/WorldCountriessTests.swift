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
    var sut: NetworkManager!
    let url = URL(string: "https://restcountries.eu/rest/v2/all")!
    var urlSession: URLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NetworkManager()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testCheckDataDownloadFromApiRequest() {
        let expectation = XCTestExpectation(description: "Fetching API from restCountries")
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            // Make sure we downloaded some data.
            XCTAssertNotNil(data, "No data was downloaded.")
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
        }
        
        // Start the download task.
        dataTask.resume()
        
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testNetworkData_WhenGivenValidData_ReturnSuccesss() {
        let expectation = expectation(description: "Completion handler invoked")
        
        // when
        sut.fetchDataForUnitTest { data in
            XCTAssertEqual(data[0].name, "Afghanistan")
            expectation.fulfill()
        }
        wait(for:[expectation], timeout: 5)
    }
    
    
}
