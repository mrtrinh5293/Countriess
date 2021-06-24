//
//  WorldMapView.swift
//  WorldCountriess
//
//  Created by Duc Dang on 8/7/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import SwiftUI
import UIKit
import MapKit

struct WorldMapView: UIViewRepresentable {
    
    @Binding var countryData : [CountryLocation]
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<WorldMapView>) {
        var allAnnotations: [CountryAnnotation] = []
 

        for data in countryData {
            
            if(data.latlng.count == 0 ) {
                print("error")
            } else {                                
                let title = data.name
                let coordiante = CLLocationCoordinate2D(latitude: data.latlng[0], longitude: data.latlng[1])
                allAnnotations.append(CountryAnnotation(title: title, coordinate: coordiante))
                
            }
        }
        uiView.annotations.forEach {uiView.removeAnnotation($0)}
        uiView.addAnnotations(allAnnotations)
    }
    
    func makeUIView(context: UIViewRepresentableContext<WorldMapView>) -> MKMapView {
        return MKMapView()
    }
}

class CountryAnnotation : NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
}
