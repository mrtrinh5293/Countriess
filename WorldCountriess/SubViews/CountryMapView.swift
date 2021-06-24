//
//  CountryMapView.swift
//  WorldCountriess
//
//  Created by Duc Dang on 8/7/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import SwiftUI
import MapKit

struct CountryMapView: UIViewRepresentable {
    
//    var country : WorldData
    var country : CDCountry

    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        let latitude = country.wrapperLatlng[0]
        let longtitude = country.wrapperLatlng[1]
        
        let coordinate = CLLocationCoordinate2D(
            latitude: latitude, longitude: longtitude)
        let span = MKCoordinateSpan(latitudeDelta: 20.0, longitudeDelta: 20.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
}
