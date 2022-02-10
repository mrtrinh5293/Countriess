//
//  test.swift
//  WorldCountriess
//
//  Created by duc on 2021-10-21.
//  Copyright © 2021 Duc Dang. All rights reserved.
//

import Foundation
import Combine
protocol ServiceProtocol {
 func fetchCountries(completion: @escaping ([WorldData]?) -> Void)
}

class CountriesViewModel: ObservableObject {
    @Published var countries = CountryList(result: [])
    @Published var loading = false
    
    
    let service: ServiceProtocol
    
    init(service: ServiceProtocol = APIService()) {
        self.service = service
    }
    
    func loadData() {
        self.loading = true
        service.fetchCountries { countries in
            self.loading = false
            guard let countries = countries else { return }
            self.countries.result = countries
        }
    }
}
