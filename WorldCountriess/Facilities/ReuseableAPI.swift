//
//  ReuseableAPI.swift
//  WorldCountriess
//
//  Created by duc on 2021-07-05.
//  Copyright © 2021 Duc Dang. All rights reserved.
//

import Foundation

class SomeClass {
    struct Constants {
        static let url1 = URL(string: "https://restcountries.eu/rest/v2/all")
        static let url2 = URL(string: "https://restcountries.eu/rest/v2/all")
    }
    
//    override
}

extension URLSession {
    enum CustomError: Error {
        case invalidURL
        case invalidData
    }
    
    func request<T: Decodable>(
        url: URL?,
        expectating: T.Type,
        completion: @escaping(Result<T, Error>) -> Void
    ) {
        guard let url = url else {
            completion(.failure(CustomError.invalidURL))
            return
        }
        
        let task = self.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expectating, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
