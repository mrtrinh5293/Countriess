//
//  FirstUIView.swift
//  WorldCountriess
//
//  Created by Duc Dang on 8/7/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import SwiftUI

struct FirstUIView: View {
    
    @ObservedObject var networkmanager = NetworkManager()
    @State var searchText = ""
    @State var isSearchVisible = false
    @State var show = false
    
    @ObservedObject var favorites = Favorites()
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CDCountry.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \CDCountry.name, ascending: true)]) var country: FetchedResults<CDCountry>
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                if isSearchVisible {
                    SearchView(searchText: $searchText)
                }
                
                List() {
                    ForEach(country.filter {
                        self.searchText.isEmpty ? true: $0.wrapperName.lowercased().contains(self.searchText.lowercased())
                    }, id: \.name)
                    { country in
                        
                        NavigationLink(destination: DetailView(country: country)) {
                            RowView(cdCountry: country, edit: self.$show)
                            if self.favorites.contains(country) {
                                Image(systemName: "checkmark.seal.fill")
                                    .accessibility(label: Text("Favorite one"))
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }.animation(.spring())
                
            }.navigationBarTitle("World Country")
            .listStyle(GroupedListStyle())
            .navigationBarItems(
                leading:
                    Button(action: {
                        
                        self.show.toggle()
                        
                    }) {
                        if self.show {
                            Text("Done").foregroundColor(Color("DarkModeLight"))
                        } else {
                            Image(systemName: "phone.badge.plus").foregroundColor(Color("DarkModeLight"))
                        }
                    },
                trailing:
                    Button(action: {
                        self.isSearchVisible.toggle()
                        
                        if !self.isSearchVisible {
                            self.searchText = ""
                        }
                    }, label: {
                        Image(systemName: "magnifyingglass").foregroundColor(Color("DarkModeLight")).background(Color("DarkMode"))
                    })
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(favorites)
        .onAppear {
            if self.country.isEmpty {
                DispatchQueue.global().async {
                    NetworkManager.loadDataToCD(moc: self.moc)
                }
            }
        }
        
    }
}
