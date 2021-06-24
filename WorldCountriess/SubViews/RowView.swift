//
//  RowView.swift
//  WorldCountriess
//
//  Created by Duc Dang on 8/7/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct RowView: View {
    
//    var country : WorldData
    var cdCountry : CDCountry
    @Binding var edit : Bool
    @ObservedObject var favorites = Favorites()
    
    var body: some View {
        
        HStack {
            if ( cdCountry.wrapperName == "Ecuador" || cdCountry.wrapperName == "Nicaragua") {
                    AnimatedImage(url: URL(string: "https://thumbs.dreamstime.com/b/no-image-available-icon-photo-camera-flat-vector-illustration-132483141.jpg"))

                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            } else {
//                Image(url)
                AnimatedImage(url: URL(string: cdCountry.wrapperFlag)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .shadow(radius: 5)

            }
            Text(cdCountry.wrapperName ?? "...")
                .fontWeight(.bold)
            Spacer()
        }
    }
}
