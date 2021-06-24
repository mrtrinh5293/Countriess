//
//  SearchView.swift
//  WorldCountriess
//
//  Created by Duc Dang on 8/7/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import SwiftUI

struct SearchView: View {
        
        @Binding var searchText: String
        
        var body: some View {
            HStack {
                TextField("Country...", text: $searchText)
                    .padding()
            }.frame(height: 50)
                .background(Color("DarkMode"))
                .cornerRadius(10.0)
                .padding(10)
            
        }
    }
