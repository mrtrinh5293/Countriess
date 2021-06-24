//
//  MapContainer.swift
//  WorldCountriess
//
//  Created by Duc Dang on 8/7/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import SwiftUI

struct MapContainer: View {
        
        @ObservedObject var countryData = NetworkManager()
        var body: some View {
            WorldMapView(countryData: $countryData.allCountries)
        }
    }

struct MapContainer_Previews: PreviewProvider {
    static var previews: some View {
        MapContainer()
    }
}
