//
//  Favorites.swift
//  WorldCountriess
//
//  Created by Duc Dang on 9/1/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import Foundation

class Favorites: ObservableObject {
    private var countries : Set<Int64>
    
    private let saveKey = "Favorites"
    
    init() {
        
        if let savedSet = UserDefaults.standard.array(forKey: saveKey) as? [Int64] {
            countries = Set(savedSet)
            return
        }
        self.countries = []
    }
    
    func contains(_ country: CDCountry) -> Bool {
        countries.contains(country.wrapperId)
    }
    
    func add(_ country: CDCountry) {
        objectWillChange.send()
        countries.insert(country.wrapperId)
        save()
        
    }
    
    func remove(_ country: CDCountry) {
        objectWillChange.send()
        countries.remove(country.wrapperId)
    }
    
    func save() {
        UserDefaults.standard.set(Array(countries), forKey: saveKey)
    }
}
