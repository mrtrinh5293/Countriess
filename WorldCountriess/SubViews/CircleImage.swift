//
//  CircleImage.swift
//  WorldCountriess
//
//  Created by Duc Dang on 8/7/20.
//  Copyright © 2020 Duc Dang. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CircleImage: View {
    
//    var country : WorldData

    var country : CDCountry
    var body: some View {
        
        HStack {
            
            if ( country.wrapperName == "Ecuador" || country.wrapperName == "Nicaragua") {
                AnimatedImage(url: URL(string: "https://thumbs.dreamstime.com/b/no-image-available-icon-photo-camera-flat-vector-illustration-132483141.jpg"))
                
                    .resizable()
//                    .aspectRatio(contentMode: .fit)

//                    .frame(width: 300, height: 300)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.gray, lineWidth: 4))
//                    .shadow(radius: 10)
                
            } else {
                
                AnimatedImage(url: URL(string: country.wrapperFlag)!)
                    .resizable()
                .edgesIgnoringSafeArea(.top)
//                    .aspectRatio(contentMode: .fit)
//                    .frame( height: 200,w)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.gray, lineWidth: 4))
//                    .shadow(radius: 10)
            }
        }
        
    }
}
