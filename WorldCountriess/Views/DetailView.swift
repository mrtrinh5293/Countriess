//
//  DetailView.swift
//  WorldCountriess
//
//  Created by Duc Dang on 8/7/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
    
    //    var country : WorldData
    var country : CDCountry
    @EnvironmentObject var favorites: Favorites
    @State private var showRatingView = false
    
    var body: some View {
        //        NavigationView{
        ScrollView(.vertical, showsIndicators: true) {
            
            VStack {
                CircleImage(country: country)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 300)
                VStack {
                    CountryMapView(country: country)
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        .shadow(radius: 10)
                    
                }
                .offset(y: -100)
                .padding(.bottom, -100)
                
                
                Text(country.wrapperName)
                    .font(.title).multilineTextAlignment(.center)
            }
            Button(action: {
                if self.favorites.contains(self.country) {
                    self.favorites.remove(self.country)
                } else {
                    self.favorites.add(self.country)
                }
            }, label: {
                if favorites.contains(country) {
                    Text("I have visited \(country.wrapperName) 😍")
                        .foregroundColor(Color("DarkModeLight"))
                        .padding()
                        .shadow(radius: 10)
                } else {
                    Text("I have not visited this country 😌")
                        .foregroundColor(Color("DarkModeLight"))
                        .padding()
                }
            })
            .animation(.spring())
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color("DarkModeLight"), lineWidth: 2))
            .shadow(radius: 10)
            .padding(.top, 10)
            
            HStack() {
                
                VStack(alignment: .leading) {
                    Text("Capital")
                    
                    Text("Region")
                    
                    Text("Population")
                    
//                    Text("Currency")
                    
//                    Text("ISO Code")
                    
//                    Text("Time Zone")
                    
//                    Text("Area (in Kilometer)")
                    
                    
                }.padding().font(.headline)
                VStack(alignment: .leading) {
                    if country.wrapperName == "United States Minor Outlying Islands" {
                        Text("error")
                        
                    } else {
                        Text(country.wrapperCapital )
                        
                        Text("\(country.wrapperRegion)")
                        
                        Text(country.wrapperPopulation.formatNumber())
                        
                        
                        //                            if (country.currencies![0].symbol == nil) {
                        //                                Text("\(country.currencies![0].code!)")
                        //                            } else {
                        //
                        //                                Text("\(country.currencies![0].symbol!) \(country.currencies![0].code!)")
                        //                            }
                        
                        Text(country.wrapperAlpha2Code )
                        
                        //                            Text(country.timezones?[0] ?? "error")
                        //                            Text("\((country.area?.formatNumber())!).000")
                    }
                    
                }.font(.headline).padding(.trailing, 10)
            }.background(Color("DarkMode"))
            .cornerRadius(10.0)
            .padding()
        }
        .offset(y: -5)
        .padding(.bottom, -60)
        
    }
}

