//
//  URLSessionStub.swift
//  WorldCountriess
//
//  Created by duc on 2021-06-14.
//  Copyright © 2021 Duc Dang. All rights reserved.
//

import Foundation

typealias DataTaskCompletionHandler = (Data?, URLResponse?, Error?) -> Void
protocol URLSessionProtocol {
  func dataTask(
    with url: URL,
    completionHandler: @escaping DataTaskCompletionHandler
  ) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class URLSessionStub: URLSessionProtocol {
  private let stubbedData: Data?
  private let stubbedResponse: URLResponse?
  private let stubbedError: Error?

  public init(data: Data? = nil, response: URLResponse? = nil, error: Error? = nil) {
    self.stubbedData = data
    self.stubbedResponse = response
    self.stubbedError = error
  }

  public func dataTask(
    with url: URL,
    completionHandler: @escaping DataTaskCompletionHandler
  ) -> URLSessionDataTask {
    URLSessionDataTaskStub(
      stubbedData: stubbedData,
      stubbedResponse: stubbedResponse,
      stubbedError: stubbedError,
      completionHandler: completionHandler
    )
  }
}

class URLSessionDataTaskStub: URLSessionDataTask {
  private let stubbedData: Data?
  private let stubbedResponse: URLResponse?
  private let stubbedError: Error?
  private let completionHandler: DataTaskCompletionHandler?

  init(
    stubbedData: Data? = nil,
    stubbedResponse: URLResponse? = nil,
    stubbedError: Error? = nil,
    completionHandler: DataTaskCompletionHandler? = nil
  ) {
    self.stubbedData = stubbedData
    self.stubbedResponse = stubbedResponse
    self.stubbedError = stubbedError
    self.completionHandler = completionHandler
  }

  override func resume() {
    completionHandler?(stubbedData, stubbedResponse, stubbedError)
  }
}


//class MockURLProtocol: URLProtocol {
//    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
//    
//    override class func canInit(with request: URLRequest) -> Bool {
//        return true
//    }
//    
//    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
//        return request
//    }
//    
//    override func startLoading() {
//        guard let handler = MockURLProtocol.requestHandler else {
//            XCTFail("Received unexpected request with no handler set")
//            return
//        }
//        do {
//            let (response, data) = try handler(request)
//            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
//            client?.urlProtocol(self, didLoad: data)
//            client?.urlProtocolDidFinishLoading(self)
//        } catch {
//            client?.urlProtocol(self, didFailWithError: error)
//        }
//    }
//    
//    override func stopLoading() {
//    }
//}
