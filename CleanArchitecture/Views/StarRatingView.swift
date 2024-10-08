//
//  StarRatingView.swift
//  CleanArchitecture
//
//  Created by Štěpán Friedl on 04.10.2024.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double
    var roundedRating: Double {
        (rating * 2).rounded(.down) / 2
    }
    
    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                if roundedRating >= Double(index) + 1 {
                    Image(systemName: "star.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                } else if roundedRating >= Double(index) + 0.5 {
                    Image(systemName: "star.leadinghalf.filled")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Image(systemName: "star")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

#Preview {
    StarRatingView(
        rating: 2.66
    )
}
